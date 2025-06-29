part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMapEvent extends MapEvent {}

class UpdateLocationEvent extends MapEvent {
  final Position position;

  UpdateLocationEvent(this.position);

  @override
  List<Object?> get props => [position];
}
