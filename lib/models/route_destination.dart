import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestination {
  final List<LatLng> points;
  final double distance;
  final double duration;

  RouteDestination({
    required this.points,
    required this.distance,
    required this.duration,
  });
}
