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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Center(
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               '1',
      //               textAlign: TextAlign.center,
      //               style: GlobalFunctions.textTheme(context: context)
      //                   .headline3!
      //                   .copyWith(
      //                     color: Colors.white,
      //                     fontSize: 20,
      //                   ),
      //             ),
      //             ButtonMenu(
      //               title: 'Master Lokasi',
      //               icon: Icons.home,
      //               routeName: Routes.MASTER_LOCATION_PAGE,
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           width: 16,
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               '2',
      //               textAlign: TextAlign.center,
      //               style: GlobalFunctions.textTheme(context: context)
      //                   .headline3!
      //                   .copyWith(
      //                     color: Colors.white,
      //                     fontSize: 20,
      //                   ),
      //             ),
      //             BlocBuilder<LocationCubit, LocationState>(
      //               builder: (context, state) {
      //                 if (state is LocationLoading) {
      //                   return ElevatedButton(
      //                       onPressed: () {
      //                         context.read<LocationCubit>().addMasterLocation();
      //                       },
      //                       child: const Text('End'));
      //                 } else {
      //                   return ElevatedButton(
      //                       onPressed: () {
      //                         context.read<LocationCubit>().addMasterLocation();
      //                       },
      //                       child: const Text('data'));
      //                 }
      //               },
      //             ),
      //             // ButtonMenu(
      //             //   title: 'Attendance',
      //             //   icon: Icons.check,
      //             //   routeName: Routes.ATTENDANCE_PAGE,
      //             // ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
