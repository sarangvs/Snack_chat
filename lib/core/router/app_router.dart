import 'package:chat_app/presentation/auth/pages/login_screen.dart';
import 'package:chat_app/presentation/auth/pages/register_user_screen.dart';
import 'package:chat_app/presentation/home/pages/home_screen.dart';
import 'package:chat_app/presentation/home/widgets/qr_code_view.dart';
import 'package:chat_app/presentation/splash/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/registerUser',
      name: 'registerUser',
      builder: (context, state) => ResgisterUserScreen(),
    ),
    GoRoute(
      path: '/qrcode',
      name: 'qrcode',
      builder: (context, state) {
        final token = state.extra as String;
        return QRCodeDisplayScreen(token: token);
      },
    ),
  ],
);
