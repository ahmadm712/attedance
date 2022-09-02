// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/data/models/offices_model.dart';
import 'package:attendance/services/location_services.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  LocationServices services;
  AttendanceCubit(
    this.services,
  ) : super(AttendanceInitial());

  void attendance(OfficesModel offices) async {
    emit(AttendanceLoading());
    services.determinatePosition().then((value) async {
      final isWFO = await services.onAreaWFO(
          geoPointOffice: offices.location,
          geoPointAttendance: const GeoPoint(-6.1558321, 106.8075075));
      if (isWFO) {
        emit(AttendanceSucces());
      } else {
        emit(AttendanceFailed(errorMessage: '< 50 M from office'));
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
