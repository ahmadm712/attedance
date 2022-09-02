import 'package:attendance/injection.dart';
import 'package:attendance/presentation/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attendance/presentation/cubit/location_cubit/location_cubit.dart';
import 'package:attendance/presentation/pages/attendance_page.dart';
import 'package:attendance/presentation/pages/home_page.dart';
import 'package:attendance/presentation/pages/master_location.dart';
import 'package:attendance/utils/observer.dart';
import 'package:attendance/utils/rourtes.dart';
import 'package:attendance/utils/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance/services/location_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final locationServices = locator<LocationServices>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => AttendanceCubit(locationServices),
          child: Container(),
        ),
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
