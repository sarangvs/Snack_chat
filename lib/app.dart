import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/presentation/language_switch/cubit/locale_cubit.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (deviceLocale != null) {
              for (final locale in supportedLocales) {
                if (locale.languageCode == deviceLocale.languageCode) {
                  return locale;
                }
              }
            }
            return supportedLocales.first;
          },
          theme: AppTheme.lightTheme,
          routerConfig: router,
        );
      },
    );
  }
}
