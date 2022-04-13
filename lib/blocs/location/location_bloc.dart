import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;
  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
      (event, emit) => emit(
        state.copyWith(followingUser: true),
      ),
    );
    on<OnStopFollowingUser>(
      (event, emit) => emit(
        state.copyWith(followingUser: false),
      ),
    );
    on<OneNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnowLocation: event.newLocation,
        mylocationHistory: [...?state.mylocationHistory, event.newLocation],
      ));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(
      OneNewUserLocationEvent(
        LatLng(position.latitude, position.longitude),
      ),
    );
  }

  void startFollowingUser() async {
    add(OnStartFollowingUser());
    positionStream = Geolocator.getPositionStream().listen(
      (event) {
        final position = event;
        add(
          OneNewUserLocationEvent(
            LatLng(position.latitude, position.longitude),
          ),
        );
      },
    );
  }

  void stopFollowingUser() {
    positionStream!.cancel();
    add(OnStopFollowingUser());
    // print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
