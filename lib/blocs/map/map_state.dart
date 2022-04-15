part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialize;
  final bool isFollowUser;
  final bool showMyRoute;
  // Polyline
  final Map<String, Polyline> polyLines;

  const MapState({
    this.showMyRoute = true,
    this.isMapInitialize = false,
    this.isFollowUser = true,
    Map<String, Polyline>? polyLines,
  }) : polyLines = polyLines ?? const {};

  MapState copyWith({
    bool? isMapInitialize,
    bool? isFollowUser,
    Map<String, Polyline>? polyLines,
    bool? showMyRoute,
  }) =>
      MapState(
        isMapInitialize: isMapInitialize ?? this.isMapInitialize,
        isFollowUser: isFollowUser ?? this.isFollowUser,
        polyLines: polyLines ?? this.polyLines,
        showMyRoute: showMyRoute ?? this.showMyRoute,
      );

  @override
  List<Object> get props =>
      [isMapInitialize, isFollowUser, polyLines, showMyRoute];
}
