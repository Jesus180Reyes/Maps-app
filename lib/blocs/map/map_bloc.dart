import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/blocs/bloc.dart';
import 'package:map_app/models/models.dart';
import 'package:map_app/theme/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;
  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializeEvent>(_onInitMap);
    on<OnStartFollowUserEvent>(
      (event, emit) => _onStartFollowingUser(event, emit),
    );
    on<UpdateUserPolylinesEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<OnStopFollowUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowUser: false)));

    on<DisplayPolyLineId>((event, emit) => emit(state.copyWith(
          polyLines: event.polylines,
        )));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolylinesEvent(locationState.mylocationHistory!));
      }
      if (!state.isFollowUser) return;
      if (locationState.lastKnowLocation == null) return;

      moveCamera(locationState.lastKnowLocation!);
    });
  }

  void _onInitMap(OnMapInitializeEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialize: true));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController!.animateCamera(cameraUpdate);
  }

  void _onStartFollowingUser(
      OnStartFollowUserEvent event, Emitter<MapState> emit) {
    if (locationBloc.state.lastKnowLocation == null) return;
    emit(
      state.copyWith(isFollowUser: true),
    );
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylinesEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      points: event.userLocation,
      color: Colors.red,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    final currentPolylines = Map<String, Polyline>.from(state.polyLines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polyLines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    final currentPolylines = Map<String, Polyline>.from(state.polyLines);
    currentPolylines['route'] = myRoute;

    add(DisplayPolyLineId(currentPolylines));
  }

  @override
  Future<void> close() {
    locationStateSubscription!.cancel();
    return super.close();
  }
}
