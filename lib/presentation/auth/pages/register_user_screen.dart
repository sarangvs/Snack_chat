import 'dart:developer';

import 'package:chat_app/DI/dependency_injection.dart';
import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/domain/usecases/get_country_names.dart';
import 'package:chat_app/presentation/auth/cubit/country_cubit.dart';
import 'package:chat_app/presentation/auth/widgets/custom_dropdown.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("Create your account", style: themeStyle.titleLarge),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.gap16,
                CustomTextFormField(
                  hintText: 'Display Name',
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }

                    return null;
                  },
                ),
                AppSpacing.gap16,
                CustomTextFormField(
                  hintText: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) return 'Enter a valid email';
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
                  ),
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
                    if (passwordController.text !=
                        confrimPasswordController.text) {
                      return 'Password and confirm password should be same';
                    }

                    return null;
                  },
                ),
                AppSpacing.gap16,
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  controller: confrimPasswordController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (passwordController.text !=
                        confrimPasswordController.text) {
                      return 'Password and confirm password should be same';
                    }

                    return null;
                  },
                ),
                AppSpacing.gap16,
                CustomTextFormField(
                  hintText: 'Mobile',
                  controller: mobileController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile is required';
                    }

                    return null;
                  },
                ),
                AppSpacing.gap16,
                CustomElevatedButton(
                  width: double.infinity,
                  text: "Create",
                  backgroundColor: themeColor.primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
