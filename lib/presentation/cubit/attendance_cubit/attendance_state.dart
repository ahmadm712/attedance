// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSucces extends AttendanceState {}

class AttendanceFailed extends AttendanceState {
  dynamic errorMessage;
  AttendanceFailed({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
