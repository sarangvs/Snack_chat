import 'package:chat_app/core/assets/app_assets.dart';
import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:chat_app/presentation/widgets/main_title_widget.dart';
import 'package:chat_app/presentation/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!;
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is AuthLoggedIn) {
          context.goNamed('home');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.login, style: themeStyle.titleLarge),
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
                              hintText: loc.email,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return loc.emailRequired;
                                }
                                if (!value.contains('@')) {
                                  return loc.invalidEmail;
                                }
                                return null;
                              },
                            ),
                            AppSpacing.gap16,
                            CustomTextFormField(
                              hintText: loc.password,
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return loc.passwordRequired;
                                }

                                return null;
                              },
                            ),
                            AppSpacing.gap16,
                            CustomElevatedButton(
                              width: double.infinity,
                              text: loc.login,
                              backgroundColor: themeColor.primaryColor,
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                                }
                              },
                            ),
                            AppSpacing.gap16,
                            GestureDetector(
                              onTap: () {
                                context.push("/registerUser");
                              },
                              child: Text(
                                loc.createYourAccount,
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
      ),
    );
  }
}
