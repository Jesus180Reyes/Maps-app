import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/blocs/bloc.dart';
import 'package:map_app/helpers/dialog.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            top: 70,
            left: 20,
            child: BtnBack(),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                color: Colors.black,
                elevation: 0,
                shape: const StadiumBorder(),
                minWidth: size.width - 120,
                child: const Text(
                  'Confirmar destino',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onPressed: () async {
                  final start = locationBloc.state.lastKnowLocation;
                  if (start == null) return;
                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  searchBloc.add(OnDesactivateMarkerEvent());
                  final destination =
                      await searchBloc.getCoorsStartToEnd(start, end);
                  await mapBloc.drawRoutePolyline(destination);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BtnBack extends StatelessWidget {
  const BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: FadeInLeft(
        duration: const Duration(milliseconds: 300),
        child: CircleAvatar(
          maxRadius: 30,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<SearchBloc>(context).add(
                OnDesactivateMarkerEvent(),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
