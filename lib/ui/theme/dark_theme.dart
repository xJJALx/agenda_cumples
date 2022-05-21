import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  static final ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 40, 40, 40),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color.fromARGB(255, 54, 54, 54),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.play(fontSize: 44, color: const Color.fromARGB(210, 216, 206, 206)),
      headline2: GoogleFonts.play(fontSize: 34, color: const Color.fromARGB(210, 216, 206, 206)),
      headline3: GoogleFonts.play(fontSize: 24, color: const Color.fromARGB(210, 216, 206, 206)),
      headline4: GoogleFonts.play(fontSize: 18, fontWeight: FontWeight.w500,  color: const Color.fromARGB(210, 216, 206, 206)),
      subtitle1: const TextStyle(fontSize: 16, color: Color.fromARGB(213, 122, 122, 122)),
      labelMedium: const TextStyle(fontSize: 14, color:  Color.fromARGB(210, 216, 206, 206)),
      button: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),      
    ),
    iconTheme: const IconThemeData(color:  Color.fromARGB(210, 216, 206, 206)),

  );

}
