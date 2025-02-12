import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cleancode_app/core/theme/theme_manager.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_event.dart';
import 'package:cleancode_app/features/settings/presentation/bloc/settings_state.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    _loadThemeConfig();
  }

  bool isDarkMode = false;
  Color selectedColor = Colors.blueAccent;
  final themeManager = GetIt.I<ThemeManager>();

  Future<void> _loadThemeConfig() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      String? primaryColorString = prefs.getString('primaryColor');
      selectedColor = primaryColorString != null
          ? Color(int.parse(primaryColorString))
          : Colors.blueAccent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Tema Oscuro'),
              value: isDarkMode,
              onChanged: (value) async {
                final prefs = await SharedPreferences.getInstance();
                setState(() {
                  isDarkMode = value;
                });
                prefs.setBool('isDarkMode', value);
                themeManager.toggleTheme();
                context.read<SettingsBloc>().add(ToggleTheme(
                    isDarkMode: value, primaryColor: selectedColor));
              },
            ),
            ListTile(
                title: const Text('Selecciona el color principal'),
                trailing: CircleAvatar(
                  backgroundColor: selectedColor,
                ),
                onTap: () {
                  _showColorPicker(context);
                })
          ],
        );
      }),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) async {
                final prefs = await SharedPreferences.getInstance();
                setState(() {
                  selectedColor = color;
                });
                prefs.setString('primaryColor', color.value.toString());
                themeManager.changeColor(color);
                context.read<SettingsBloc>().add(
                      ChangeColor(
                        isDarkMode: isDarkMode,
                        primaryColor: selectedColor,
                      ),
                    );
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
