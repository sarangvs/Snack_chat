import 'package:flutter/widgets.dart';

/// Use for consistent spacing throughout the app.
class AppSpacing {
  // Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );
  static const EdgeInsets horizontal16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets vertical12 = EdgeInsets.symmetric(vertical: 12.0);

  // Margin
  static const EdgeInsets cardMargin = EdgeInsets.all(12.0);

  // Gaps (SizedBoxes)
  static const SizedBox gap4 = SizedBox(height: 4.0);
  static const SizedBox gap8 = SizedBox(height: 8.0);
  static const SizedBox gap12 = SizedBox(height: 12.0);
  static const SizedBox gap16 = SizedBox(height: 16.0);
  static const SizedBox gap24 = SizedBox(height: 24.0);
  static const SizedBox gap32 = SizedBox(height: 32.0);

  // Spacing units (if needed for spacing values only)
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space24 = 24.0;
}
