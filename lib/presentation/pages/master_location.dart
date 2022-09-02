import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MasterLocationPage extends StatefulWidget {
  const MasterLocationPage({Key? key}) : super(key: key);

  @override
  State<MasterLocationPage> createState() => _MasterLocationPageState();
}

class _MasterLocationPageState extends State<MasterLocationPage> {
  Position? _currentPosition;

  String? _currentAddress;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: '');

  late Placemark place;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Future<Position> _determinatePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Location"),
    //   ),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.all(24),
    //     scrollDirection: Axis.vertical,
    //     child: Consumer<MasterLocationProvider>(
    //       builder: (context, value, child) {
    //         if (value.state == ResultState.loading) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else if (value.state == ResultState.hasData) {
    //           return Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: <Widget>[
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Company Name',
    //                     style: GlobalFunctions.textTheme(context: context)
    //                         .headline3!
    //                         .copyWith(color: Colors.black, fontSize: 17),
    //                   ),
    //                   const SizedBox(
    //                     width: 14,
    //                   ),
    //                   value.office.name != 'default'
    //                       ? Text(value.office.name,
    //                           style: GlobalFunctions.textTheme(context: context)
    //                               .headline3!
    //                               .copyWith(
    //                                   color: Colors.black,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 17))
    //                       : const Text('No Data'),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Company Latitude ',
    //                     style: GlobalFunctions.textTheme(context: context)
    //                         .headline3!
    //                         .copyWith(color: Colors.black, fontSize: 17),
    //                   ),
    //                   const SizedBox(
    //                     width: 14,
    //                   ),
    //                   value.office.latitude != 0
    //                       ? Text(
    //                           value.office.latitude.toString(),
    //                           style: GlobalFunctions.textTheme(context: context)
    //                               .headline3!
    //                               .copyWith(
    //                                   color: Colors.black,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 17),
    //                         )
    //                       : const Text('No Data'),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Company Longitude ',
    //                     style: GlobalFunctions.textTheme(context: context)
    //                         .headline3!
    //                         .copyWith(color: Colors.black, fontSize: 17),
    //                   ),
    //                   const SizedBox(
    //                     width: 14,
    //                   ),
    //                   value.office.longitude != 0
    //                       ? Text(
    //                           value.office.longitude.toString(),
    //                           style: GlobalFunctions.textTheme(context: context)
    //                               .headline3!
    //                               .copyWith(
    //                                   color: Colors.black,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 17),
    //                         )
    //                       : const Text('No Data'),
    //                 ],
    //               ),
    //               const SizedBox(height: 20),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Company Address ',
    //                     style: GlobalFunctions.textTheme(context: context)
    //                         .headline3!
    //                         .copyWith(color: Colors.black, fontSize: 17),
    //                   ),
    //                   const SizedBox(
    //                     width: 14,
    //                   ),
    //                   value.office.address != ''
    //                       ? Text(
    //                           value.office.address.toString(),
    //                           textAlign: TextAlign.center,
    //                           style: GlobalFunctions.textTheme(context: context)
    //                               .headline3!
    //                               .copyWith(
    //                                   color: Colors.black,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 17),
    //                         )
    //                       : const Text('No Data'),
    //                 ],
    //               ),
    //               ElevatedButton(
    //                 child: Text(value.office.name != 'default'
    //                     ? "Edit Master Location"
    //                     : 'Add Master Location'),
    //                 onPressed: () async {
    //                   _getCurrentLocation().then((v) {
    //                     showDialog(
    //                         context: context,
    //                         builder: (BuildContext context) {
    //                           return AlertDialog(
    //                             contentPadding: EdgeInsets.zero,
    //                             content: Stack(
    //                               children: <Widget>[
    //                                 Positioned(
    //                                   right: -15.0,
    //                                   top: -15.0,
    //                                   child: InkResponse(
    //                                     onTap: () {
    //                                       Navigator.of(context).pop();
    //                                     },
    //                                     child: const CircleAvatar(
    //                                       radius: 12,
    //                                       backgroundColor: Colors.red,
    //                                       child: Icon(
    //                                         Icons.close,
    //                                         size: 18,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Form(
    //                                   key: _formKey,
    //                                   child: Column(
    //                                     mainAxisSize: MainAxisSize.min,
    //                                     children: <Widget>[
    //                                       Container(
    //                                         height: 60,
    //                                         width: MediaQuery.of(context)
    //                                             .size
    //                                             .width,
    //                                         decoration: BoxDecoration(
    //                                             color: kColorPrimary,
    //                                             border: Border(
    //                                                 bottom: BorderSide(
    //                                                     color: Colors.grey
    //                                                         .withOpacity(
    //                                                             0.3)))),
    //                                         child: Center(
    //                                           child: Text(
    //                                             value.office.name != 'default'
    //                                                 ? "Edit Company Name"
    //                                                 : 'Add Company Name',
    //                                             style:
    //                                                 GlobalFunctions.textTheme(
    //                                                         context: context)
    //                                                     .headline3!
    //                                                     .copyWith(
    //                                                         color: Colors.white,
    //                                                         fontWeight:
    //                                                             FontWeight.bold,
    //                                                         fontSize: 18),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Padding(
    //                                         padding: const EdgeInsets.all(20.0),
    //                                         child: Container(
    //                                             height: 50,
    //                                             decoration: BoxDecoration(
    //                                                 border: Border.all(
    //                                                     color: Colors.grey
    //                                                         .withOpacity(0.2))),
    //                                             child: Row(
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.start,
    //                                               children: [
    //                                                 Expanded(
    //                                                   flex: 1,
    //                                                   child: Container(
    //                                                     width: 30,
    //                                                     decoration: BoxDecoration(
    //                                                         border: Border(
    //                                                             right: BorderSide(
    //                                                                 color: Colors
    //                                                                     .grey
    //                                                                     .withOpacity(
    //                                                                         0.2)))),
    //                                                     child: Center(
    //                                                         child: Icon(
    //                                                             Icons
    //                                                                 .account_balance_outlined,
    //                                                             size: 30,
    //                                                             color: Colors
    //                                                                 .grey
    //                                                                 .withOpacity(
    //                                                                     0.4))),
    //                                                   ),
    //                                                 ),
    //                                                 Expanded(
    //                                                   flex: 4,
    //                                                   child: TextFormField(
    //                                                     controller:
    //                                                         _nameController,
    //                                                     validator: (value) {
    //                                                       return value!
    //                                                               .isNotEmpty
    //                                                           ? null
    //                                                           : "Enter any text";
    //                                                     },
    //                                                     decoration: const InputDecoration(
    //                                                         hintText:
    //                                                             "E.g Hashmicro",
    //                                                         contentPadding:
    //                                                             EdgeInsets.only(
    //                                                                 left: 20),
    //                                                         border: InputBorder
    //                                                             .none,
    //                                                         focusedBorder:
    //                                                             InputBorder
    //                                                                 .none,
    //                                                         errorBorder:
    //                                                             InputBorder
    //                                                                 .none,
    //                                                         hintStyle: TextStyle(
    //                                                             color: Colors
    //                                                                 .black26,
    //                                                             fontSize: 14,
    //                                                             fontWeight:
    //                                                                 FontWeight
    //                                                                     .w500)),
    //                                                   ),
    //                                                 )
    //                                               ],
    //                                             )),
    //                                       ),
    //                                       Padding(
    //                                         padding: const EdgeInsets.all(20.0),
    //                                         child: ElevatedButton(
    //                                           child: SizedBox(
    //                                             width: MediaQuery.of(context)
    //                                                 .size
    //                                                 .width,
    //                                             height: 40,
    //                                             child: Center(
    //                                                 child: Text(
    //                                               "Submit",
    //                                               style: GlobalFunctions
    //                                                       .textTheme(
    //                                                           context: context)
    //                                                   .headline3!
    //                                                   .copyWith(
    //                                                       color: Colors.white,
    //                                                       fontWeight:
    //                                                           FontWeight.bold,
    //                                                       fontSize: 18),
    //                                             )),
    //                                           ),
    //                                           onPressed: () async {
    //                                             if (GlobalFunctions.validate(
    //                                               formkey: _formKey,
    //                                             )) {
    //                                               SharedPreferences prefs =
    //                                                   await SharedPreferences
    //                                                       .getInstance();
    //                                               value.createMasterLocation(
    //                                                 name: _nameController.text,
    //                                                 lat: v.latitude,
    //                                                 long: v.longitude,
    //                                                 address: _currentAddress!,
    //                                               );
    //                                               prefs.setDouble(
    //                                                   COMPANY_LATITUDE,
    //                                                   v.latitude);
    //                                               prefs.setDouble(
    //                                                   COMPANY_LONGITUDE,
    //                                                   v.longitude);

    //                                               prefs.setString(COMPANY_NAME,
    //                                                   _nameController.text);
    //                                               GlobalFunctions.clearField(
    //                                                   controller:
    //                                                       _nameController);
    //                                               Navigator.pop(context);
    //                                             }
    //                                           },
    //                                         ),
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           );
    //                         });
    //                   });

    //                   // _getCurrentLocation();
    //                 },
    //               ),
    //             ],
    //           );
    //         } else if (value.state == ResultState.noData) {
    //           return Center(
    //             child: Text(value.message),
    //           );
    //         } else if (value.state == ResultState.error) {
    //           return Center(
    //             child: Text(value.message),
    //           );
    //         } else {
    //           return const Center(
    //             child: Text(''),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );
  }

  Future<Position> _getCurrentLocation() async {
    Position position = await _determinatePosition();

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
      print(e);
    }
  }
}
