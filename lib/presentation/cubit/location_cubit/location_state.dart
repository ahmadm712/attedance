// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSucces extends LocationState {
  OfficesModel? office;
  LocationSucces({
    this.office,
  });

  @override
  List<Object> get props => [
        office!,
      ];
}

class LocationFailed extends LocationState {
  String message;
  LocationFailed({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
