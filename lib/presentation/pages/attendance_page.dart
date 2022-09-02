import 'package:attendance/data/models/attendance.dart';
import 'package:attendance/data/models/offices_model.dart';
import 'package:attendance/injection.dart';
import 'package:attendance/presentation/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attendance/services/firestore_services.dart';
import 'package:attendance/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attendance/services/location_services.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Position? _currentPosition;
  late Placemark place;
  String? _currentAddress;
  double distanceMetervalue = 0;
  final _nameController = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final locationServices = locator<LocationServices>();

  Future<double> distanceMeter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var distanceInMeters = Geolocator.distanceBetween(
      prefs.getDouble(COMPANY_LATITUDE) != null
          ? prefs.getDouble(COMPANY_LATITUDE)!
          : 0,
      prefs.getDouble(COMPANY_LONGITUDE) != null
          ? prefs.getDouble(COMPANY_LONGITUDE)!
          : 0,
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );

    return distanceInMeters;
  }

  Future<String> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(COMPANY_NAME).toString();
  }

  Future<Position> _getCurrentLocation() async {
    Position position = await locationServices.determinatePosition();

    setState(() {
      _currentPosition = position;
      _getAddressFromLatLng();
    });

    return position;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        child: ElevatedButton(
          // onPressed: () async {
          //   _getCurrentLocation().then((v) {
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             contentPadding: EdgeInsets.zero,
          //             content: Stack(
          //               children: <Widget>[
          //                 Positioned(
          //                   right: -15.0,
          //                   top: -15.0,
          //                   child: InkResponse(
          //                     onTap: () {
          //                       Navigator.of(context).pop();
          //                     },
          //                     child: const CircleAvatar(
          //                       radius: 12,
          //                       backgroundColor: Colors.red,
          //                       child: Icon(
          //                         Icons.close,
          //                         size: 18,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Form(
          //                   key: _formKey,
          //                   child: Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: <Widget>[
          //                       Container(
          //                         height: 60,
          //                         width: MediaQuery.of(context).size.width,
          //                         decoration: BoxDecoration(
          //                             color: kColorPrimary,
          //                             border: Border(
          //                                 bottom: BorderSide(
          //                                     color: Colors.grey
          //                                         .withOpacity(0.3)))),
          //                         child: const Center(
          //                           child: Text(
          //                             "Add Attendance Data",
          //                             style: TextStyle(
          //                               color: Colors.white,
          //                               fontWeight: FontWeight.w700,
          //                               fontSize: 20,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.all(20.0),
          //                         child: Container(
          //                             height: 50,
          //                             decoration: BoxDecoration(
          //                                 border: Border.all(
          //                                     color: Colors.grey
          //                                         .withOpacity(0.2))),
          //                             child: Row(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     width: 30,
          //                                     decoration: BoxDecoration(
          //                                         border: Border(
          //                                             right: BorderSide(
          //                                                 color: Colors.grey
          //                                                     .withOpacity(
          //                                                         0.2)))),
          //                                     child: Center(
          //                                         child: Icon(Icons.person,
          //                                             size: 30,
          //                                             color: Colors.grey
          //                                                 .withOpacity(0.4))),
          //                                   ),
          //                                 ),
          //                                 Expanded(
          //                                   flex: 4,
          //                                   child: TextFormField(
          //                                     controller: _nameController,
          //                                     validator: (value) {
          //                                       return value!.isNotEmpty
          //                                           ? null
          //                                           : "Enter name";
          //                                     },
          //                                     decoration: const InputDecoration(
          //                                         hintText: "E.g Jhon",
          //                                         contentPadding:
          //                                             EdgeInsets.only(left: 20),
          //                                         border: InputBorder.none,
          //                                         focusedBorder:
          //                                             InputBorder.none,
          //                                         errorBorder: InputBorder.none,
          //                                         hintStyle: TextStyle(
          //                                             color: Colors.black26,
          //                                             fontSize: 14,
          //                                             fontWeight:
          //                                                 FontWeight.w500)),
          //                                   ),
          //                                 )
          //                               ],
          //                             )),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.all(20.0),
          //                         child: ElevatedButton(
          //                           child: SizedBox(
          //                             width: MediaQuery.of(context).size.width,
          //                             height: 40,
          //                             child: Center(
          //                                 child: Text(
          //                               "Submit",
          //                               style: GlobalFunctions.textTheme(
          //                                       context: context)
          //                                   .headline3!
          //                                   .copyWith(
          //                                       color: Colors.white,
          //                                       fontWeight: FontWeight.bold,
          //                                       fontSize: 18),
          //                             )),
          //                           ),
          //                           onPressed: () async {
          //                             if (GlobalFunctions.validate(
          //                               formkey: _formKey,
          //                             )) {
          //                               distanceMeter().then((value) {
          //                                 if (value < 50.0) {
          //                                   GlobalFunctions.scafoldMessage(
          //                                       context: context,
          //                                       message:
          //                                           'Attendance succes, already on pin location',
          //                                       color: Colors.green);
          //                                   Database.addAttendance(
          //                                           time: DateTime.now(),
          //                                           name: _nameController.text,
          //                                           isPinLocation: true)
          //                                       .then((value) =>
          //                                           GlobalFunctions.clearField(
          //                                               controller:
          //                                                   _nameController))
          //                                       .then((value) =>
          //                                           Navigator.pop(context));
          //                                 } else {
          //                                   GlobalFunctions.scafoldMessage(
          //                                     context: context,
          //                                     message:
          //                                         'Attendance Rejected, please come on office',
          //                                     color: Colors.red,
          //                                   );
          //                                   GlobalFunctions.clearField(
          //                                       controller: _nameController);
          //                                   Navigator.pop(context);
          //                                 }
          //                               });
          //                             }
          //                           },
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         });
          //   });
          // },

          onPressed: () async {
            OfficesModel officesModel = OfficesModel(
                location: const GeoPoint(-6.1558321, 106.8075075),
                name: 'Ahmad Muji',
                addres: 'addres');
            context.read<AttendanceCubit>().attendance(officesModel);
          },
          child: const Text('Add'),
        ),
      ),
      body: StreamBuilder<List<Attendance>>(
        stream: Database.readItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: kColorPrimary,
              strokeWidth: 0.8,
            ));
          } else if (snapshot.hasData) {
            return ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final attendance = snapshot.data![index];
                return ListTile(
                  title: Text(attendance.name),
                  subtitle: Row(
                    children: [
                      const Text('Is Pin Location ? '),
                      Text(attendance.isPinLocation.toString()),
                    ],
                  ),
                  trailing: Text(
                      "${attendance.time.day}/${attendance.time.month}/${attendance.time.year} - ${attendance.time.hour}:${attendance.time.second}"),
                );
              },
            );
          }

          return const Center(child: Text('No Data Avaible, add it'));
        },
      ),
    );
  }
}
