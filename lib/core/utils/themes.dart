import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_fonts.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      cardColor: AppColors.backgroundColor.withValues(alpha: 0.8),

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        onSurface: AppColors.darkColor,
      ),
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyles.title.copyWith(
          fontFamily: AppFonts.cairoFamily,
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.backgroundColor,
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

  static ThemeData get darkTheme {
    return ThemeData(
      cardColor: AppColors.darkColor.withValues(alpha: 0.8),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        onSurface: AppColors.backgroundColor,
      ),
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyles.title.copyWith(
          fontFamily: AppFonts.cairoFamily,
        ),
        backgroundColor: AppColors.darkColor,
        // foregroundColor: AppColors.darkColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.darkColor),
      ),
      scaffoldBackgroundColor: AppColors.darkColor,
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
