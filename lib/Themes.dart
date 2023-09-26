import 'package:Growth/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextTheme GrowthTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  ),
  bodyLarge: TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  ),
  bodyMedium: TextStyle(
    fontSize: 14.0,
    color: Colors.black,
  ),
  // Add other text styles as needed
);

class ThemeGrowth {
  static ThemeData get themeData {
    return ThemeData(
        useMaterial3: true,
        cardTheme: const CardTheme(
            color: Colors.white, surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(backgroundColor: Colors.white,
            surfaceTintColor: Colors.white),
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: customGreenAccent,
            backgroundColor: Colors.white),
        textTheme: GoogleFonts.figtreeTextTheme(),
        dividerTheme: const DividerThemeData(
          color: Colors.white, // Set the color of the Divider
          thickness: 2.0, // Set the thickness of the Divider
          indent: 16.0, // Set the indent (empty space) before the Divider
          endIndent: 16.0, // Set the end indent (empty space) after the Divider
        ),
      appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white, surfaceTintColor: Colors.white),
      tabBarTheme: const TabBarTheme(unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 15))
    );
  }
}