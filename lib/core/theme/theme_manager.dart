import 'package:flutter/material.dart';
import 'package:cleancode_app/core/theme/app_theme.dart';

class ThemeManager{
  ThemeManager() : _isDarkMode = false, _primaryColor = Colors.blue;

  bool _isDarkMode;
  Color _primaryColor;

   bool get isDarkMode => _isDarkMode;
  Color get primaryColor => _primaryColor;
  ThemeData get currentTheme =>  AppTheme.getTheme(_isDarkMode, _primaryColor);


  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
  }

  void changeColor(Color color){
    _primaryColor = color;
  }
    void initTheme(bool isDarkMode, Color color) {
      _isDarkMode = isDarkMode;
      _primaryColor = color;
  }
}