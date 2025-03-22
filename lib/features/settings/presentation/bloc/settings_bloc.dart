import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleancode_app/core/constants/color_constants.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeColor>(_onChangeColor);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<SettingsState> emit) async {
    final newState = state.copyWith(isDarkMode: event.isDarkMode);
    await _savePreferences(newState);
    emit(newState);
  }

  void _onChangeColor(ChangeColor event, Emitter<SettingsState> emit) async {
    final newState = state.copyWith(
      primaryBgColor: event.primaryColor,
      primaryTxtColor: event.primaryTextColor,
    );
    await _savePreferences(newState);
    emit(newState);
  }

  Future<void> _savePreferences(SettingsState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', state.isDarkMode);
    await prefs.setString(ColorConstants.primaryColorName, state.primaryBgColor.value.toString());
    await prefs.setString(ColorConstants.primaryTxtColorName, state.primaryTxtColor.value.toString());
  }
}