import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double? width;
  final FontWeight fontWeight;
  final IconData? icon;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? Colors.white, size: fontSize + 2),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
