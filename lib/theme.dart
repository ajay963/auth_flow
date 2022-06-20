import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kshade1 = Color(0xffFFC837);
const Color kshade2 = Color(0xffFF8008);
const Color kgreyShade1 = Color(0xffDADADA);

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    backgroundColor: const Color(0xffFEFEFE),
    scaffoldBackgroundColor: const Color(0xffFEFEFE),
    shadowColor: const Color(0xffDADADA),
    splashColor: Colors.white.withOpacity(0.4),
    iconTheme: const IconThemeData(
      color: Color(0xffFEFEFE),
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontStyle: GoogleFonts.roboto().fontStyle,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xff1b1b1b)),
      bodyLarge: TextStyle(
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontStyle: GoogleFonts.roboto().fontStyle,
          fontSize: 16,
          color: const Color(0xff1b1b1b)),
      bodyMedium: TextStyle(
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontStyle: GoogleFonts.roboto().fontStyle,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: const Color(0xffFFFFFF)),
      bodySmall: TextStyle(
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontStyle: GoogleFonts.roboto().fontStyle,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: const Color(0xffAAAAAA)),
    ),
  );
}
