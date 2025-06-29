import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) async {
  final loc = AppLocalizations.of(context)!;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(loc.logoutConfirmationTitle),
        content: Text(loc.logoutConfirmationMessage),
        actions: <Widget>[
          TextButton(
            child: Text(loc.cancel, style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: Text(loc.logout),
            onPressed: () {
              Navigator.of(context).pop();
              logout(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> logout(BuildContext context) async {
  try {
    context.go("/login");
  } catch (e) {
    log("Logout error: $e");
  }
}
