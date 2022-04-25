import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/blocs/bloc.dart';
import 'package:map_app/views/views.dart';
import 'package:map_app/widgets/btn_location.dart';
import 'package:map_app/widgets/btn_toggle_user_route.dart';
import 'package:map_app/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LocationBloc locationBloc;
  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnowLocation == null) {
            return const Center(
              child: Text('Espere porfavor...'),
            );
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polyLines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialPosition: locationState.lastKnowLocation!,
                      polylines: mapState.polyLines.values.toSet(),
                    ),
                    const SearchBar(),
                    const ManualMarker(),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnLocation(),
          BtnFollowUser(),
        ],
      ),
    );
  }
}
