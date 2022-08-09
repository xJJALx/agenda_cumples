import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFf4f2fe),
    ),
    textTheme: TextTheme(
      displayMedium: GoogleFonts.play(fontSize: 44, color: const Color.fromARGB(211, 0, 0, 0)),
      headlineLarge: GoogleFonts.play(fontSize: 34, color: const Color.fromARGB(211, 0, 0, 0)),
      headlineMedium: GoogleFonts.play(fontSize: 24,color: const Color.fromARGB(211, 0, 0, 0)),
      headlineSmall: GoogleFonts.play(fontSize: 18, color: const Color.fromARGB(211, 0, 0, 0),fontWeight: FontWeight.w500),
      titleMedium: const TextStyle(fontSize: 16, color: Color.fromARGB(213, 122, 122, 122)),
      labelMedium: const TextStyle(fontSize: 14,color:  Color.fromARGB(211, 0, 0, 0)),
       ),
    iconTheme: const IconThemeData(color:  Color.fromARGB(211, 0, 0, 0)),
  );
}
