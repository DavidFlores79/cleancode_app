import 'package:flutter/material.dart';

abstract class SettingsEvent {}

class ToggleTheme extends SettingsEvent {
  final bool isDarkMode;
   final Color primaryColor;
   ToggleTheme({required this.isDarkMode, required this.primaryColor});
}

class ChangeColor extends SettingsEvent {
     final bool isDarkMode;
   final Color primaryColor;
   final Color primaryTextColor;
   ChangeColor({required this.isDarkMode, required this.primaryColor, required this.primaryTextColor});
}