part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializeEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializeEvent(this.controller);
}

class OnStopFollowUserEvent extends MapEvent {}

class OnStartFollowUserEvent extends MapEvent {}

class OnToggleUserRoute extends MapEvent {}

class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> userLocation;

  const UpdateUserPolylinesEvent(this.userLocation);
}
