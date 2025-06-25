import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocListener<SplashCubit, SplashStatus>(
      listener: (context, state) {
        if (state == SplashStatus.authenticated) {
          context.goNamed('home');
        } else if (state == SplashStatus.unauthenticated) {
          context.goNamed('login');
        }
      },
      child: BlocBuilder<SplashCubit, SplashStatus>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80, color: Colors.blue),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.displayLarge,
                      children: [
                        TextSpan(
                          text: 'Snack',
                          style: TextStyle(color: theme.primary),
                        ),
                        TextSpan(
                          text: 'Chat',
                          style: TextStyle(color: theme.secondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // if (state == SplashStatus.loading)
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
