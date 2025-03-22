part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ChangeColorEvent extends ThemeEvent {
  final Color color;
  final String colorName;

  ChangeColorEvent(this.color, this.colorName);
}

class InitializeThemeEvent extends ThemeEvent {
  final bool isDarkMode;
  final Color primaryBgColor;
  final Color primaryTxtColor;

  InitializeThemeEvent(this.isDarkMode, this.primaryBgColor, this.primaryTxtColor);
}