import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:map_app/models/models.dart';
import 'package:map_app/providers/providers.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({
    required this.trafficService,
  }) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
      (event, emit) => emit(
        state.copyWith(displayManualMarker: true),
      ),
    );

    on<OnDesactivateMarkerEvent>(
      (event, emit) => emit(
        state.copyWith(displayManualMarker: false),
      ),
    );
  }
  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficresponse = await trafficService.getCoorsStartToEnd(start, end);
    final distance = trafficresponse.routes[0].distance;
    final duration = trafficresponse.routes[0].duration;
    final geometry = trafficresponse.routes[0].geometry;

    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points
        .map(
          (coors) => LatLng(
            coors[0].toDouble(),
            coors[1].toDouble(),
          ),
        )
        .toList();

    return RouteDestination(
      points: latLngList,
      distance: distance,
      duration: duration,
    );
  }
}
