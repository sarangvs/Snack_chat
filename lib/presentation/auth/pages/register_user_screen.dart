import 'dart:developer';

import 'package:chat_app/DI/dependency_injection.dart';
import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/domain/usecases/get_country_names.dart';
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_app/presentation/auth/cubit/country_cubit.dart';
import 'package:chat_app/presentation/auth/widgets/custom_dropdown.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ResgisterUserScreen extends StatefulWidget {
  const ResgisterUserScreen({super.key});

  @override
  State<ResgisterUserScreen> createState() => _ResgisterUserScreenState();
}

class _ResgisterUserScreenState extends State<ResgisterUserScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimPasswordController = TextEditingController();
  final mobileController = TextEditingController();
  final countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedRole = "Country";

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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(loc.createYourAccount, style: themeStyle.titleLarge),
        toolbarHeight: 40,
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, color: themeColor.shadowColor),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: AppSpacing.screenPadding,
            width: width,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is AuthRegistered) {
                  context.goNamed('home');
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.gap16,
                    CustomTextFormField(
                      hintText: loc.displayName,
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.nameRequired;
                        }

                        return null;
                      },
                    ),
                    AppSpacing.gap16,
                    CustomTextFormField(
                      hintText: loc.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.emailRequired;
                        }
                        if (!value.contains('@')) return loc.invalidEmail;
                        return null;
                      },
                    ),
                    AppSpacing.gap16,
                    BlocProvider(
                      create:
                          (context) =>
                              CountryCubit(getIt<GetCountryNames>())
                                ..loadCountries(),
                      child: CustomSearchDropdown(
                        labelText: selectedRole,
                        controller: countryController,

                        onSelected: (city) {
                          log(city);
                          countryController.text = city;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return loc.countryRequired;
                          }

                          return null;
                        },
                      ),
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
                        if (passwordController.text !=
                            confrimPasswordController.text) {
                          return loc.passwordMismatch;
                        }

                        return null;
                      },
                    ),
                    AppSpacing.gap16,
                    CustomTextFormField(
                      hintText: loc.confirmPassword,
                      controller: confrimPasswordController,
                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.confirmPasswordRequired;
                        }
                        if (passwordController.text !=
                            confrimPasswordController.text) {
                          return loc.passwordMismatch;
                        }

                        return null;
                      },
                    ),
                    AppSpacing.gap16,
                    CustomTextFormField(
                      hintText: loc.mobile,
                      controller: mobileController,
                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.mobileRequired;
                        }

                        return null;
                      },
                    ),
                    AppSpacing.gap16,
                    CustomElevatedButton(
                      width: double.infinity,
                      text: loc.create,
                      backgroundColor: themeColor.primaryColor,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthBloc>().add(
                            RegisterEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              mobile: mobileController.text,
                              country: countryController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
