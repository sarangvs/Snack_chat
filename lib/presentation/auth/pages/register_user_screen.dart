import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResgisterUserScreen extends StatefulWidget {
  const ResgisterUserScreen({super.key});

  @override
  State<ResgisterUserScreen> createState() => _ResgisterUserScreenState();
}

class _ResgisterUserScreenState extends State<ResgisterUserScreen> {
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
        title: Text("Create your account", style: themeStyle.titleLarge),
        toolbarHeight: 40,
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, color: themeColor.shadowColor),
        ),
        // centerTitle: true,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
