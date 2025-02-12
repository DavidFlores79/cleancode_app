import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeManager{
  ThemeManager() : _isDarkMode = false, _primaryBgColor = AppConstants.primaryBgColor, _primaryTxtColor = AppConstants.primaryTxtColor;

  bool _isDarkMode;
  Color _primaryBgColor;
  Color _primaryTxtColor;
  void Function()? callback;
  bool get isDarkMode => _isDarkMode;
  Color get primaryColor => _primaryBgColor;
  Color get primaryTxtColor => _primaryTxtColor;
  ThemeData get currentTheme =>  AppTheme.getTheme(_isDarkMode, _primaryBgColor, primaryTxtColor: _primaryTxtColor);


  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
   notify();
  }

  void changeColor(Color color, String colorName){
    if(colorName == AppConstants.primaryColorName) {
      _primaryBgColor = color;
    }
    if(colorName == AppConstants.primaryTxtColorName) {
      _primaryTxtColor = color;
    }
    notify();
  }

    void initTheme(bool isDarkMode, Color primaryBgColor, Color primaryTxtColor) {
      _isDarkMode = isDarkMode;
      _primaryBgColor = primaryBgColor;
      _primaryTxtColor = primaryTxtColor;
  }
    void notify() {
    if (callback != null) {
      callback!();
    }
  }
}