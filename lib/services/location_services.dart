import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position> determinatePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
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

  Future<String> getAddressFromLatLng(Position _currentPosition) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );

      Placemark place = placemarks.first;

      return "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> onAreaWFO(
      {required GeoPoint geoPointOffice,
      required GeoPoint geoPointAttendance}) async {
    // DocumentSnapshot docData = await FirebaseAPI.getUserProfile();
    // UserProfile userProfile =
    //     UserProfile.fromJson(docData.data() as Map<String, dynamic>);
    double distanceInMeter = Geolocator.distanceBetween(
        geoPointAttendance.latitude,
        geoPointAttendance.longitude,
        geoPointOffice.latitude,
        geoPointOffice.longitude);
    return (distanceInMeter <= 50) ? true : false;
  }
}
