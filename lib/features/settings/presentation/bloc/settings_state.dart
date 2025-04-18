part of 'settings_bloc.dart';

class SettingsState {
  final bool isDarkMode;
  final Color primaryBgColor;
  final Color primaryTxtColor;

  const SettingsState({
    required this.isDarkMode,
    required this.primaryBgColor,
    required this.primaryTxtColor,
  });

  factory SettingsState.initial() {
    return SettingsState(
      isDarkMode: false,
      primaryBgColor: ColorConstants.primaryBgColor,
      primaryTxtColor: ColorConstants.primaryTxtColor,
    );
  }

  SettingsState copyWith({
    bool? isDarkMode,
    Color? primaryBgColor,
    Color? primaryTxtColor,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryBgColor: primaryBgColor ?? this.primaryBgColor,
      primaryTxtColor: primaryTxtColor ?? this.primaryTxtColor,
    );
  }
}