part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Position position;
  final List<LatLng> waterBodies;

  MapLoaded({required this.position, required this.waterBodies});

  @override
  List<Object?> get props => [position, waterBodies];
}

class MapError extends MapState {
  final String message;

  MapError(this.message);

  @override
  List<Object?> get props => [message];
}
