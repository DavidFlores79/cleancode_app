import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    // Otras personalizaciones del tema light
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    // Otras personalizaciones del tema dark
  );
    static ThemeData getTheme(bool isDarkMode, Color color) {
    final baseTheme = isDarkMode ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(primary: color),
      appBarTheme: baseTheme.appBarTheme.copyWith(backgroundColor: color),
    );
  }
}