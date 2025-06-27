import 'dart:convert';

import 'package:chat_app/core/utils/uuid_generator.dart';
import 'package:chat_app/presentation/chat/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatelessWidget {
  final String myUid;
  const QrScannerScreen({super.key, required this.myUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: MobileScanner(
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          final raw = barcode.rawValue;
          if (raw != null) {
            final decoded = jsonDecode(raw);
            final otherUid = decoded['uid'];
            final chatRoomId = generateChatRoomId(myUid, otherUid);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder:
                    (_) => ChatScreen(
                      myUid: myUid,
                      receiverUid: otherUid,
                      chatRoomId: chatRoomId,
                    ),
              ),
            );
          }
        },
      ),
    );
  }
}
