import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../cubit/locale_cubit.dart';

class LanguageSwitchPage extends StatelessWidget {
  const LanguageSwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(loc.switchLanguage, style: themeStyle.titleLarge),
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          final isArabic = locale.languageCode == 'ar';

          return ListView(
            children: [
              ListTile(
                title: Text(loc.switchLanguage),
                trailing: Switch.adaptive(
                  value: isArabic,
                  onChanged: (_) {
                    context.read<LocaleCubit>().toggleLocale();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
