import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SplashStatus { loading, authenticated, unauthenticated }

@injectable
class SplashCubit extends Cubit<SplashStatus> {
  SplashCubit() : super(SplashStatus.loading) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final loggedIn = prefs.getBool('isLoggedIn') ?? false;
      await Future.delayed(const Duration(seconds: 2));
      emit(
        loggedIn ? SplashStatus.authenticated : SplashStatus.unauthenticated,
      );

      if (loggedIn) {
        await prefs.setBool('isLoggedIn', false);
      }
    } catch (e) {
      emit(SplashStatus.unauthenticated);
    }
  }
}
