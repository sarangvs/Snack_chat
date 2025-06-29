import 'package:chat_app/domain/usecases/get_current_location_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentLocation getCurrentLocation;

  MapBloc({required this.getCurrentLocation}) : super(MapInitial()) {
    on<LoadMapEvent>(_onLoadMapEvent);
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
  }

  Future<void> _onLoadMapEvent(
    LoadMapEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MapLoading());
    try {
      final position = await getCurrentLocation();
      emit(MapLoaded(position: position));
    } catch (e) {
      emit(MapError("Failed to fetch location: ${e.toString()}"));
    }
  }

  void _onUpdateLocationEvent(
    UpdateLocationEvent event,
    Emitter<MapState> emit,
  ) {
    emit(MapLoaded(position: event.position));
  }
}
