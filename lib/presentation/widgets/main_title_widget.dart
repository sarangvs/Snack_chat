import 'package:flutter/material.dart';

class MainTitleWidget extends StatelessWidget {
  const MainTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge,
        children: [
          TextSpan(text: 'Snack', style: TextStyle(color: theme.primary)),
          TextSpan(text: 'Chat', style: TextStyle(color: theme.secondary)),
        ],
      ),
    );
  }
}
