import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/locale_cubit.dart';

class LanguageSwitchPage extends StatelessWidget {
  const LanguageSwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<LocaleCubit>().toggleLocale(),
          child: Text(loc.switchLanguage),
        ),
      ),
    );
  }
}
