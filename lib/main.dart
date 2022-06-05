import 'package:attendance/presentation/pages/attendance_page.dart';
import 'package:attendance/presentation/pages/home_page.dart';
import 'package:attendance/presentation/pages/master_location.dart';
import 'package:attendance/presentation/providers/master_location_provider.dart';
import 'package:attendance/utils/rourtes.dart';
import 'package:attendance/utils/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MasterLocationProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Attendance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: kColorPrimary,
          ),
          textTheme: textTheme,
        ),
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Routes.HOME_PAGE:
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
            case Routes.MASTER_LOCATION_PAGE:
              return MaterialPageRoute(
                builder: (context) => const MasterLocationPage(),
              );
            case Routes.ATTENDANCE_PAGE:
              return MaterialPageRoute(
                builder: (context) => const AttendancePage(),
              );

            default:
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(
                    child: Text('Page Not Found'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
