import 'package:flutter/material.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class ThemeToggled extends SettingsState {
   final bool isDarkMode;
   final Color primaryColor;

  ThemeToggled(this.isDarkMode, this.primaryColor);
}

class ColorChanged extends SettingsState {
    final bool isDarkMode;
   final Color primaryColor;
   ColorChanged(this.isDarkMode, this.primaryColor);
}