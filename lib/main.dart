import 'package:attendance/presentation/pages/home_page.dart';
import 'package:attendance/utils/rourtes.dart';
import 'package:attendance/utils/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kColorPrimary,
        ),
      ),
      initialRoute: Routes.HOME_PAGE,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Routes.HOME_PAGE:
            MaterialPageRoute(
              builder: (context) => HomePage(),
            );
            break;
          default:
        }
      },
    );
  }
}
