// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_attendance_cubit.dart';

abstract class ListAttendanceState extends Equatable {
  const ListAttendanceState();

  @override
  List<Object> get props => [];
}

class ListAttendanceInitial extends ListAttendanceState {}

class ListAttendanceLoading extends ListAttendanceState {}

class ListAttendanceHasData extends ListAttendanceState {
  List<Attendance> data;
  ListAttendanceHasData({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}

class ListAttendanceFailed extends ListAttendanceState {
  dynamic error;
  ListAttendanceFailed({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
