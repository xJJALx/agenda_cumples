import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFf4f2fe),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.play(fontSize: 44, color: const Color.fromARGB(211, 0, 0, 0)),
      headline2: GoogleFonts.play(fontSize: 34, color: const Color.fromARGB(211, 0, 0, 0)),
      headline3: GoogleFonts.play(fontSize: 24,color: const Color.fromARGB(211, 0, 0, 0)),
      headline4: GoogleFonts.play(fontSize: 18, color: const Color.fromARGB(211, 0, 0, 0),fontWeight: FontWeight.w500),
      subtitle1: const TextStyle(fontSize: 16, color: Color.fromARGB(213, 122, 122, 122)),
      labelMedium: const TextStyle(fontSize: 14,color:  Color.fromARGB(211, 0, 0, 0)),
      button: const TextStyle(fontSize: 14, color:  Color.fromARGB(211, 0, 0, 0), fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color:  Color.fromARGB(211, 0, 0, 0)),
  );
}
