part of 'qr_generator_bloc.dart';

abstract class QrGeneratorState extends Equatable {
  const QrGeneratorState();
  @override
  List<Object> get props => [];
}

class QrGeneratorInitial extends QrGeneratorState {}

class QrGeneratorLoading extends QrGeneratorState {}

class QrGeneratorSuccess extends QrGeneratorState {
  final String uid;
  const QrGeneratorSuccess(this.uid);

  @override
  List<Object> get props => [uid];
}

class QrGeneratorFailure extends QrGeneratorState {}
