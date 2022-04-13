part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OneNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const OneNewUserLocationEvent(this.newLocation);
}

class OnStartFollowingUser extends LocationEvent {}

class OnStopFollowingUser extends LocationEvent {}
