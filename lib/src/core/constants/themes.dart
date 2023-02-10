import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rphu_app/src/core/constants/colors.dart';

final appTheme = _buildTheme();

ThemeData _buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.mainGreen,
        onPrimary: AppColors.white,
        secondary: AppColors.secondaryGreen,
        onSecondary: AppColors.white,
        error: AppColors.red,
        onError: AppColors.white,
        background: AppColors.lightLimeGreen,
        onBackground: AppColors.black,
        surface: AppColors.yellowGreen,
        onSurface: AppColors.black,
      ),
      textTheme: GoogleFonts.anekLatinTextTheme(),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24.0))));
}
