import 'package:chat_app/domain/usecases/get_current_location_usecase.dart';
import 'package:chat_app/domain/usecases/get_nearby_water_bodies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentLocation getCurrentLocation;
  final GetNearbyWaterBodies getNearbyWaterBodies;

  MapBloc({
    required this.getCurrentLocation,
    required this.getNearbyWaterBodies,
  }) : super(MapInitial()) {
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
      final waterBodies = await getNearbyWaterBodies(
        position.latitude,
        position.longitude,
      );
      emit(MapLoaded(position: position, waterBodies: waterBodies));
    } catch (e) {
      emit(MapError("Failed to fetch location: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateLocationEvent(
    UpdateLocationEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      final waterBodies = await getNearbyWaterBodies(
        event.position.latitude,
        event.position.longitude,
      );
      emit(MapLoaded(position: event.position, waterBodies: waterBodies));
    } catch (e) {
      emit(MapError("Failed to update location: ${e.toString()}"));
    }
  }
}
