import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cleancode_app/core/theme/app_theme.dart';

class ThemeManager extends StateNotifier<ThemeData>{
  ThemeManager() : super(AppTheme.lightTheme);

  bool _isDarkMode = false;
  Color _primaryColor = Colors.blue;

  bool get isDarkMode => _isDarkMode;
  Color get primaryColor => _primaryColor;

  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    state = AppTheme.getTheme(_isDarkMode, _primaryColor);
  }

  void changeColor(Color color){
    _primaryColor = color;
    state = AppTheme.getTheme(_isDarkMode, _primaryColor);
  }

  void initTheme(bool isDarkMode, Color color) {
    _isDarkMode = isDarkMode;
    _primaryColor = color;
    state = AppTheme.getTheme(_isDarkMode, _primaryColor);
  }
}

final themeProvider = StateNotifierProvider<ThemeManager, ThemeData>((ref) => ThemeManager());