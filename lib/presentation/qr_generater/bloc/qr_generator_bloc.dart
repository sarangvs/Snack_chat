import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'qr_generator_event.dart';
part 'qr_generator_state.dart';

@injectable
class QrGeneratorBloc extends Bloc<QrGeneratorEvent, QrGeneratorState> {
  QrGeneratorBloc() : super(QrGeneratorInitial()) {
    on<GenerateQrCode>((event, emit) async {
      emit(QrGeneratorLoading());
      try {
        // In a real case, this might be fetched from a use case
        await Future.delayed(const Duration(milliseconds: 300));
        emit(QrGeneratorSuccess(event.uid));
      } catch (_) {
        emit(QrGeneratorFailure());
      }
    });
  }
}
