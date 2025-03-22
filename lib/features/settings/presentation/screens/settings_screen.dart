import 'package:cleancode_app/core/constants/color_constants.dart';
import 'package:cleancode_app/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Tema Oscuro'),
                value: state.isDarkMode,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              ),
              ListTile(
                title: const Text('Selecciona el color principal'),
                trailing: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: CircleAvatar(
                    backgroundColor: state.primaryBgColor,
                  ),
                ),
                onTap: () {
                  _showColorPicker(context, ColorConstants.primaryColorName);
                },
              ),
              ListTile(
                title: const Text('Selecciona el color del texto principal'),
                trailing: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: CircleAvatar(
                    backgroundColor: state.primaryTxtColor,
                  ),
                ),
                onTap: () {
                  _showColorPicker(context, ColorConstants.primaryTxtColorName);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showColorPicker(BuildContext context, String colorName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: colorName == ColorConstants.primaryColorName
                  ? context.read<ThemeBloc>().state.primaryBgColor
                  : context.read<ThemeBloc>().state.primaryTxtColor,
              onColorChanged: (color) {
                if (colorName == ColorConstants.primaryColorName) {
                  context.read<ThemeBloc>().add(ChangeColorEvent(color, colorName));
                } else {
                  context.read<ThemeBloc>().add(ChangeColorEvent(color, colorName));
                }
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
