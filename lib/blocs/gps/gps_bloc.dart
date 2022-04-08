import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc()
      : super(
          const GpsState(
            isGpsEnabled: false,
            isGpsPermissionGranted: false,
            // TODO: Validar si el usuario ha dado permiso o no,
          ),
        ) {
    on<GpsEvent>((event, emit) {});
  }
}
