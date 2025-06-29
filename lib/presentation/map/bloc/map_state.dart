part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Position position;

  MapLoaded({required this.position});

  @override
  List<Object?> get props => [position];
}

class MapError extends MapState {
  final String message;

  MapError(this.message);

  @override
  List<Object?> get props => [message];
}
