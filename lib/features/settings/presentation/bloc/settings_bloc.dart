import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_event.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ToggleTheme>(_onToggleTheme);
      on<ChangeColor>(_onChangeColor);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<SettingsState> emit) async {
     emit(SettingsLoading());
       emit(ThemeToggled(event.isDarkMode, event.primaryColor));
  }

  void _onChangeColor(ChangeColor event, Emitter<SettingsState> emit) {
     emit(SettingsLoading());
    emit(ColorChanged(event.isDarkMode, event.primaryColor));
  }
}