import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).textTheme;

    final borderRadius = BorderRadius.circular(8);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: themeStyle.bodyLarge?.copyWith(
          color: AppColors.lightTextShade,
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
