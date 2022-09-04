import 'package:attendance/injection.dart';
import 'package:attendance/presentation/pages/attendance_page.dart';
import 'package:attendance/presentation/pages/master_location.dart';
import 'package:attendance/utils/global_functions.dart';
import 'package:attendance/utils/style.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? _child;

  @override
  void initState() {
    _child = const MasterLocationPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _handleNavigationChange(int index) {
      setState(() {
        switch (index) {
          case 0:
            _child = const MasterLocationPage();
            break;
          case 1:
            _child = const AttendancePage();
            break;
        }
        _child = AnimatedSwitcher(
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          duration: const Duration(milliseconds: 500),
          child: _child,
        );
      });
    }

    return Scaffold(
      backgroundColor: kColorPrimary,
      bottomNavigationBar: FluidNavBar(
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
          barBackgroundColor: Colors.white,
        ),
        defaultIndex: 0,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"] ?? "",
          child: item,
        ),
        icons: [
          FluidNavBarIcon(
            icon: Icons.place,
            extras: {
              "label": "bookmark",
            },
            selectedForegroundColor: kColorPrimary,
          ),
          FluidNavBarIcon(
            icon: Icons.work,
            selectedForegroundColor: kColorPrimary,
            extras: {
              "label": "bookmark",
            },
          ),
        ],
      ),
      body: _child,
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
  final globalFunction = locator<GlobalFunctions>();

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
              style: globalFunction
                  .textTheme(context: context)
                  .headline3!
                  .copyWith(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
