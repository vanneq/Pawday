import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static TextStyle get mainFont => GoogleFonts.nunito();

  static TextStyle get titleLargeFont =>
      GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 34);

  static TextStyle get titleNormalFont =>
      GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 28);

  static TextStyle get titleSmallFont =>
      GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 24);

  static TextStyle get primaryNormalFont =>
      GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 20);
}
