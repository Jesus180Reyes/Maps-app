part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng>? mylocationHistory;
  const LocationState({
    this.followingUser = false,
    this.lastKnowLocation,
    this.mylocationHistory,
  });
  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? mylocationHistory,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
        mylocationHistory: mylocationHistory ?? this.mylocationHistory,
      );
  @override
  List<Object?> get props => [
        followingUser,
        lastKnowLocation,
        mylocationHistory,
      ];
}
