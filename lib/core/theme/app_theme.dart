import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(
    bool isDarkMode,
    Color primaryBgColor, {
    required Color primaryTxtColor,
  }) {
    final baseTheme = isDarkMode
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(primary: primaryBgColor),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: primaryBgColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: primaryTxtColor,
          fontSize: 22,
        ),
        iconTheme: IconThemeData(
          color: primaryTxtColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBgColor, // Color de fondo
          foregroundColor: primaryTxtColor, // Color del texto
          minimumSize: const Size(double.infinity, 60), // Tamaño mínimo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400, // Grosor de la fuente
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}