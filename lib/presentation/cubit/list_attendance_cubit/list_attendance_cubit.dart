// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:attendance/data/models/attendance.dart';
import 'package:attendance/services/firestore_services.dart';

part 'list_attendance_state.dart';

class ListAttendanceCubit extends Cubit<ListAttendanceState> {
  FirebaseServices services;
  ListAttendanceCubit(
    this.services,
  ) : super(ListAttendanceInitial());

  void getData() async {
    emit(ListAttendanceLoading());
    try {
      final data = await services.readListAttendance();
      emit(ListAttendanceHasData(data: data));
    } catch (e) {
      emit(ListAttendanceFailed(error: e));
    }
  }
}
