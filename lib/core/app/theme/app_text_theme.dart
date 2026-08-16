import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotik/core/app/theme/colors.dart';
import 'package:kotik/core/app/theme/fonts.dart';

TextTheme get appTextTheme => GoogleFonts.nunitoTextTheme().copyWith(
  displayLarge: Fonts.titleLargeFont.copyWith(color: mainTextColor),
  headlineLarge: Fonts.titleNormalFont.copyWith(color: mainTextColor),
  titleLarge: Fonts.titleSmallFont.copyWith(color: mainTextColor),
  bodyLarge: Fonts.primaryNormalFont.copyWith(color: mainTextColor),
  bodyMedium: Fonts.mainFont.copyWith(
    color: mainTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  labelLarge: Fonts.mainFont.copyWith(
    color: secondaryWhiteTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  ),
);
