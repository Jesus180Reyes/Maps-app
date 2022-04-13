part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialize;
  final bool isFollowUser;

  const MapState({
    this.isMapInitialize = false,
    this.isFollowUser = false,
  });

  MapState copyWith({
    bool? isMapInitialize,
    bool? isFollowUser,
  }) =>
      MapState(
        isMapInitialize: isMapInitialize ?? this.isMapInitialize,
        isFollowUser: isFollowUser ?? this.isFollowUser,
      );

  @override
  List<Object> get props => [isMapInitialize, isFollowUser];
}
