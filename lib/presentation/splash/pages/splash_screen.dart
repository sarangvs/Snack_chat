import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:chat_app/presentation/widgets/main_title_widget.dart';
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
                  MainTitleWidget(),
                  const SizedBox(height: 40),
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
