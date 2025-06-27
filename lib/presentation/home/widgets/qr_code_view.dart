import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDisplayScreen extends StatefulWidget {
  final String token;

  const QRCodeDisplayScreen({super.key, required this.token});
  @override
  _QRCodeDisplayScreenState createState() => _QRCodeDisplayScreenState();
}

class _QRCodeDisplayScreenState extends State<QRCodeDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your QR Code')),
      body: Center(
        child:
            widget.token.isNotEmpty
                ? QrImageView(
                  data: widget.token,
                  version: QrVersions.auto,
                  size: 250.0,
                )
                : CircularProgressIndicator(),
      ),
    );
  }
}
