import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_fonts.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.darkColor),
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: AppFonts.cairoFamily,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.fillColor,
        filled: true,
        prefixIconColor: AppColors.primaryColor,
        suffixIconColor: AppColors.primaryColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
