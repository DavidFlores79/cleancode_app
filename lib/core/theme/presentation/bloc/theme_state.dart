part of 'theme_bloc.dart';

class ThemeState {
  final bool isDarkMode;
  final Color primaryBgColor;
  final Color primaryTxtColor;

  const ThemeState({
    required this.isDarkMode,
    required this.primaryBgColor,
    required this.primaryTxtColor,
  });

  factory ThemeState.initial() {
    return ThemeState(
      isDarkMode: false,
      primaryBgColor: ColorConstants.primaryBgColor,
      primaryTxtColor: ColorConstants.primaryTxtColor,
    );
  }

  ThemeState copyWith({
    bool? isDarkMode,
    Color? primaryBgColor,
    Color? primaryTxtColor,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryBgColor: primaryBgColor ?? this.primaryBgColor,
      primaryTxtColor: primaryTxtColor ?? this.primaryTxtColor,
    );
  }
}