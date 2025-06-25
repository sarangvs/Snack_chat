import 'dart:developer';

import 'package:chat_app/core/assets/app_assets.dart';
import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:chat_app/presentation/widgets/main_title_widget.dart';
import 'package:chat_app/presentation/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    padding: AppSpacing.screenPadding,
                    width: width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgIcon(assetPath: AppAssets.loginImg, size: 200),
                          AppSpacing.gap32,

                          MainTitleWidget(),
                          AppSpacing.gap32,
                          CustomTextFormField(
                            hintText: 'Email',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
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
                          GestureDetector(
                            onTap: () {
                              log("ontappp");
                              context.push("/registerUser");
                            },
                            child: Text(
                              "Create Account",
                              style: themeStyle.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AppSpacing.gap32,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
