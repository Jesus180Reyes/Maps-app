import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/blocs/bloc.dart';

class MapView extends StatelessWidget {
  final Set<Polyline> polylines;
  final LatLng initialPosition;
  const MapView({
    Key? key,
    required this.initialPosition,
    required this.polylines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapbloc = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialPosition,
      zoom: 15,
    );
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointMoveEnvent) => mapbloc.add(
          OnStopFollowUserEvent(),
        ),
        child: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: initialCameraPosition,
          compassEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          polylines: polylines,
          onCameraMove: (position) => mapbloc.mapCenter = position.target,
          onMapCreated: (controller) =>
              mapbloc.add(OnMapInitializeEvent(controller)),
        ),
      ),
    );
  }
}
