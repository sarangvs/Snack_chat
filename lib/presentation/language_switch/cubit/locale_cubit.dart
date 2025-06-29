import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LocaleCubit extends Cubit<Locale> {
  static const _localeKey = 'selected_locale';

  LocaleCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey) ?? 'en';
    emit(Locale(code));
  }

  void toggleLocale() async {
    final newLocale =
        state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, newLocale.languageCode);
    emit(newLocale);
  }
}
