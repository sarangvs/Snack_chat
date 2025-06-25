import 'package:chat_app/core/assets/app_assets.dart';
import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:chat_app/presentation/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In", style: themeStyle.titleLarge),
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(assetPath: AppAssets.loginImg, size: 200),

            AppSpacing.gap16,
            Text(
              "Welcome back",
              style: themeStyle.titleLarge!.copyWith(fontSize: 24),
            ),
            AppSpacing.gap16,
            CustomTextFormField(
              hintText: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,

              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!value.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            AppSpacing.gap16,
            CustomTextFormField(
              hintText: 'Password',
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }

                return null;
              },
            ),
            AppSpacing.gap16,
            CustomElevatedButton(
              width: double.infinity,
              text: "Login",
              backgroundColor: themeColor.primaryColor,
              onPressed: () {},
            ),
            AppSpacing.gap16,
            Text(
              "Create Account",
              style: themeStyle.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
