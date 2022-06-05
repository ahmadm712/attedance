import 'package:attendance/utils/global_functions.dart';
import 'package:attendance/utils/rourtes.dart';
import 'package:attendance/utils/style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: GlobalFunctions.textTheme(context: context)
                        .headline3!
                        .copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                  ),
                  ButtonMenu(
                    title: 'Master Lokasi',
                    icon: Icons.home,
                    routeName: Routes.MASTER_LOCATION_PAGE,
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: GlobalFunctions.textTheme(context: context)
                        .headline3!
                        .copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                  ),
                  ButtonMenu(
                    title: 'Attendance',
                    icon: Icons.check,
                    routeName: Routes.ATTENDANCE_PAGE,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonMenu extends StatelessWidget {
  String title;
  String routeName;
  IconData icon;
  ButtonMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        height: 112,
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: kColorPrimary,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GlobalFunctions.textTheme(context: context)
                  .headline3!
                  .copyWith(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
