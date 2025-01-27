import 'package:cleancode_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeManager{
  ThemeManager() : _isDarkMode = false, _primaryColor = Colors.blue;

  bool _isDarkMode;
  Color _primaryColor;
  void Function()? callback;
   bool get isDarkMode => _isDarkMode;
  Color get primaryColor => _primaryColor;
  ThemeData get currentTheme =>  AppTheme.getTheme(_isDarkMode, _primaryColor);


  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
   notify();
  }

  void changeColor(Color color){
    _primaryColor = color;
    notify();
  }

    void initTheme(bool isDarkMode, Color color) {
      _isDarkMode = isDarkMode;
      _primaryColor = color;
  }
    void notify() {
    if (callback != null) {
      callback!();
    }
  }
}