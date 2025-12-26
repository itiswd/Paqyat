import 'package:flutter/material.dart';

/// ألوان التطبيق
class AppColors {
  AppColors._();

  // الوضع الداكن (الافتراضي)
  static const Color darkBackground = Color(0xFF1a1a2e);
  static const Color darkItem = Color(0xFF16213e);
  static const Color darkText = Colors.white;
  static const Color darkQuranText = Colors.white;
  static const Color darkQuranBackground = Color(0xFF1a1a2e);

  // الوضع الفاتح
  static const Color lightBackground = Color(0xFFf5f5f5);
  static const Color lightItem = Color(0xFF2d4059);
  static const Color lightText = Colors.black87;
  static const Color lightQuranText = Colors.black;
  static const Color lightQuranBackground = Colors.white;

  // ألوان عامة
  static const Color primary = Color(0xFF16213e);
  static const Color accent = Color(0xFFe94560);
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
}

/// مدير السمات - للتحكم في ألوان التطبيق
class ThemeManager {
  static Color backgroundColor = AppColors.darkBackground;
  static Color itemColor = AppColors.darkItem;
  static Color textColor = AppColors.darkText;
  static Color quranTextColor = AppColors.darkQuranText;
  static Color quranBackgroundColor = AppColors.darkQuranBackground;

  static int currentMode = 0;

  /// تحديث السمة بناءً على الوضع
  static void updateTheme(int mode) {
    currentMode = mode;
    switch (mode) {
      case 0: // داكن
        backgroundColor = AppColors.darkBackground;
        itemColor = AppColors.darkItem;
        textColor = AppColors.darkText;
        quranTextColor = AppColors.darkQuranText;
        quranBackgroundColor = AppColors.darkQuranBackground;
        break;
      case 1: // فاتح
        backgroundColor = AppColors.lightBackground;
        itemColor = AppColors.lightItem;
        textColor = AppColors.lightText;
        quranTextColor = AppColors.lightQuranText;
        quranBackgroundColor = AppColors.lightQuranBackground;
        break;
      default:
        backgroundColor = AppColors.darkBackground;
        itemColor = AppColors.darkItem;
        textColor = AppColors.darkText;
        quranTextColor = AppColors.darkQuranText;
        quranBackgroundColor = AppColors.darkQuranBackground;
    }
  }
}
