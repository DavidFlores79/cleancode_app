part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class ToggleTheme extends SettingsEvent {
  final bool isDarkMode;

  ToggleTheme({required this.isDarkMode});
}

class ChangeColor extends SettingsEvent {
  final Color primaryColor;
  final Color primaryTextColor;

  ChangeColor({
    required this.primaryColor,
    required this.primaryTextColor,
  });
}