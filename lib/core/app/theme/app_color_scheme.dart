import 'package:flutter/material.dart';
import 'package:kotik/core/app/theme/colors.dart';

const appColorScheme = ColorScheme.light(
  primary: primaryColor,
  onPrimary: secondaryWhiteTextColor,
  secondary: navColor,
  onSecondary: secondaryWhiteTextColor,
  tertiary: secondaryColor,
  onTertiary: tertiaryColor,
  surface: background,
  onSurface: mainTextColor,
  error: Color.fromARGB(255, 186, 26, 26),
  onError: secondaryWhiteTextColor,
  outline: borderColor,
);
