import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

String formatChatTimestamp(BuildContext context, DateTime? timestamp) {
  if (timestamp == null) return 'Time unavailable';
  final loc = AppLocalizations.of(context)!;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final messageDay = DateTime(timestamp.year, timestamp.month, timestamp.day);

  final difference = today.difference(messageDay).inDays;
  final timeOfDay = TimeOfDay.fromDateTime(timestamp);
  final formattedTime = timeOfDay.format(context);

  if (difference == 0) {
    return '${loc.today}, $formattedTime';
  } else if (difference == 1) {
    return '${loc.yesterday}, $formattedTime';
  } else if (difference > 1 && difference <= 6) {
    return '${loc.daysAgo(difference)}, $formattedTime';
  } else {
    final formattedDate = DateFormat('dd MMM yyyy').format(timestamp);
    return '$formattedDate, $formattedTime';
  }
}
