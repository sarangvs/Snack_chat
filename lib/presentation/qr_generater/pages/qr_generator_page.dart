import 'package:chat_app/presentation/qr_generater/bloc/qr_generator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorScreen extends StatelessWidget {
  final String myUid;
  const QrGeneratorScreen({super.key, required this.myUid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QrGeneratorBloc()..add(GenerateQrCode(myUid)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your QR Code')),
        body: BlocBuilder<QrGeneratorBloc, QrGeneratorState>(
          builder: (context, state) {
            if (state is QrGeneratorLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QrGeneratorSuccess) {
              return Center(
                child: QrImageView(
                  data: '{"uid":"${state.uid}"}',
                  version: QrVersions.auto,
                  size: 240,
                ),
              );
            } else if (state is QrGeneratorFailure) {
              return const Center(child: Text("Failed to generate QR"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
