// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/data/models/attendance.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:attendance/data/models/offices_model.dart';
import 'package:attendance/services/firestore_services.dart';
import 'package:attendance/services/location_services.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  LocationServices services;
  FirebaseServices firebaseservices;
  AttendanceCubit(
    this.services,
    this.firebaseservices,
  ) : super(AttendanceInitial());

  void attendance(OfficesModel offices, Attendance attendance) async {
    emit(AttendanceLoading());
    services.determinatePosition().then((value) async {
      attendance.geoPoint = GeoPoint(value.latitude, value.longitude);
      final isWFO = await services.onAreaWFO(
        geoPointOffice: offices.location!,
        geoPointAttendance: attendance.geoPoint!,
      );
      if (isWFO) {
        attendance.isWFO = isWFO;
        final addAttendaceSucces =
            await firebaseservices.addAttendance(attendance: attendance);
        addAttendaceSucces
            ? emit(AttendanceSucces())
            : emit(AttendanceFailed(errorMessage: 'Error'));
      } else {
        emit(AttendanceFailed(
            errorMessage:
                'Attendane Rejected, you are too far from the office or You did\'t add office location'));
      }
    }).catchError((
      error,
    ) {
      emit(AttendanceFailed(
        errorMessage: error,
      ));
    });
  }
}
