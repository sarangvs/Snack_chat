import 'package:chat_app/presentation/auth/pages/login_screen.dart';
import 'package:chat_app/presentation/auth/pages/register_user_screen.dart';
import 'package:chat_app/presentation/chat/pages/chat_screen.dart';
import 'package:chat_app/presentation/home/pages/home_screen.dart';
import 'package:chat_app/presentation/language_switch/pages/language_swtich_page.dart';
import 'package:chat_app/presentation/map/pages/map_view.dart';
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
      path: '/languageSwitch',
      name: 'languageSwitch',
      builder: (context, state) => LanguageSwitchPage(),
    ),

    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final extra = state.extra! as Map<String, String>;
        final myUid = extra['myUid']!;
        final receiverUid = extra['receiverUid']!;
        final chatRoomId = extra['chatRoomId']!;
        return ChatScreen(
          myUid: myUid,
          receiverUid: receiverUid,
          chatRoomId: chatRoomId,
        );
      },
    ),
    GoRoute(path: '/map', name: 'map', builder: (context, state) => MapPage()),
  ],
);
