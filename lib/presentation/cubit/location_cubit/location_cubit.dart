// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/services/location_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:attendance/data/models/offices_model.dart';
import 'package:attendance/services/firestore_services.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  FirebaseServices services;
  LocationServices locationservices;
  LocationCubit(
    this.services,
    this.locationservices,
  ) : super(LocationInitial());

  void addMasterLocation(OfficesModel office) async {
    emit(LocationLoading());
    locationservices.determinatePosition().then((value) async {
      try {
        var geoPoint = GeoPoint(value.latitude, value.longitude);
        String address = await locationservices.getAddressFromLatLng(geoPoint);
        office.location = geoPoint;
        office.addres = address;
        final data = await services.addMasterLocation(office);
        final location = await services.readMasterLocation();
        emit(LocationSucces(office: location));
      } on FirebaseException catch (e) {
        emit(LocationFailed(message: e.message!));
      }
    }).catchError((e) {
      emit(LocationFailed(message: e.message!));
    });
  }

  void getLocation() async {
    try {
      emit(LocationLoading());

      final location = await services.readMasterLocation();
      emit(LocationSucces(office: location));
    } on FirebaseException catch (e) {
      emit(LocationFailed(message: e.message!));
    }
  }
}
