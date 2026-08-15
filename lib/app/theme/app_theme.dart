import 'package:flutter/material.dart';
import 'package:kotik/app/theme/app_color_scheme.dart';
import 'package:kotik/app/theme/app_text_theme.dart';
import 'package:kotik/app/theme/colors.dart';
import 'package:kotik/app/theme/fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: appColorScheme,
    scaffoldBackgroundColor: background,
    textTheme: appTextTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: mainTextColor,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: secondaryWhiteTextColor,
        textStyle: Fonts.mainFont.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: navBgColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
    ),
  );
}
