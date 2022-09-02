// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSucces extends LocationState {
  Position position;
  LocationSucces({
    required this.position,
  });

  @override
  List<Object> get props => [
        position,
      ];
}

class LocationFailed extends LocationState {}
