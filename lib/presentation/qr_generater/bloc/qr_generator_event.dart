part of 'qr_generator_bloc.dart';

abstract class QrGeneratorEvent extends Equatable {
  const QrGeneratorEvent();
  @override
  List<Object> get props => [];
}

class GenerateQrCode extends QrGeneratorEvent {
  final String uid;
  const GenerateQrCode(this.uid);

  @override
  List<Object> get props => [uid];
}
