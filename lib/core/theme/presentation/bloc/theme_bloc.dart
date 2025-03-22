import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleancode_app/core/constants/color_constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    // Manejadores para los eventos
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ChangeColorEvent>(_onChangeColor);
    on<InitializeThemeEvent>(_onInitializeTheme); // Añade este manejador
    _loadPreferences(); // Cargar preferencias al iniciar
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    String? primaryBgColorString = prefs.getString(ColorConstants.primaryColorName);
    String? primaryTxtColorString = prefs.getString(ColorConstants.primaryTxtColorName);

    Color primaryBgColor = ColorConstants.primaryBgColor;
    if (primaryBgColorString != null) {
      primaryBgColor = Color(int.parse(primaryBgColorString));
    }
    Color primaryTxtColor = ColorConstants.primaryTxtColor;
    if (primaryTxtColorString != null) {
      primaryTxtColor = Color(int.parse(primaryTxtColorString));
    }

    // Emitir el evento InitializeThemeEvent
    add(InitializeThemeEvent(isDarkMode, primaryBgColor, primaryTxtColor));
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final newIsDarkMode = !state.isDarkMode;
    await _savePreferences(newIsDarkMode, state.primaryBgColor, state.primaryTxtColor);
    emit(state.copyWith(isDarkMode: newIsDarkMode));
  }

  void _onChangeColor(ChangeColorEvent event, Emitter<ThemeState> emit) async {
    final newPrimaryBgColor = event.colorName == ColorConstants.primaryColorName
        ? event.color
        : state.primaryBgColor;
    final newPrimaryTxtColor = event.colorName == ColorConstants.primaryTxtColorName
        ? event.color
        : state.primaryTxtColor;

    await _savePreferences(state.isDarkMode, newPrimaryBgColor, newPrimaryTxtColor);
    emit(state.copyWith(
      primaryBgColor: newPrimaryBgColor,
      primaryTxtColor: newPrimaryTxtColor,
    ));
  }

  void _onInitializeTheme(InitializeThemeEvent event, Emitter<ThemeState> emit) {
    // Inicializar el estado con los valores cargados
    emit(ThemeState(
      isDarkMode: event.isDarkMode,
      primaryBgColor: event.primaryBgColor,
      primaryTxtColor: event.primaryTxtColor,
    ));
  }

  Future<void> _savePreferences(bool isDarkMode, Color primaryBgColor, Color primaryTxtColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.setString(ColorConstants.primaryColorName, primaryBgColor.value.toString());
    await prefs.setString(ColorConstants.primaryTxtColorName, primaryTxtColor.value.toString());
  }
}