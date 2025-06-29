import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainTitleWidget extends StatelessWidget {
  const MainTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge,
        children: [
          TextSpan(text: loc.snack, style: TextStyle(color: theme.primary)),
          TextSpan(text: loc.chat, style: TextStyle(color: theme.secondary)),
        ],
      ),
    );
  }
}
