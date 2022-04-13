import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/blocs/bloc.dart';
import 'package:map_app/ui/ui.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location, color: Colors.black),
          onPressed: () {
            final userLocation = locationBloc.state.lastKnowLocation;
            if (userLocation == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: 'Localización No encontrada',
                  duration: const Duration(seconds: 3),
                ),
              );
              return;
            }

            mapBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}
