import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeTextStyle {
  static TextStyle header1 = GoogleFonts.workSans(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF000000));

  static TextStyle headline24sp = GoogleFonts.ibmPlexSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM18sp = GoogleFonts.ibmPlexSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM20sp = GoogleFonts.ibmPlexSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM22sp = GoogleFonts.ibmPlexSans(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM16sp = GoogleFonts.ibmPlexSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
  );

  static TextStyle regularIBM14sp = GoogleFonts.ibmPlexSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle toggleButtonStyle = const TextStyle(
    fontSize: 15,
    fontFamily: "Roboto",
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 15 / 15,
    letterSpacing: 0,
  );
}
