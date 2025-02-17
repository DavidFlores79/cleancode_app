import 'package:cleancode_app/core/constants/color_constants.dart';
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
  Color selectedPrimaryBgColor = ColorConstants.primaryBgColor;
  Color selectedPrimaryTxtColor = ColorConstants.primaryTxtColor;
  final themeManager = GetIt.I<ThemeManager>();

  Future<void> _loadThemeConfig() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      String? primaryBgColorString =
          prefs.getString(ColorConstants.primaryColorName);
      String? primaryTxtColorString =
          prefs.getString(ColorConstants.primaryTxtColorName);
      selectedPrimaryBgColor = primaryBgColorString != null
          ? Color(int.parse(primaryBgColorString))
          : ColorConstants.primaryBgColor;
      selectedPrimaryTxtColor = primaryTxtColorString != null
          ? Color(int.parse(primaryTxtColorString))
          : ColorConstants.primaryTxtColor;
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
                    isDarkMode: value, primaryColor: selectedPrimaryBgColor));
              },
            ),
            ListTile(
              title: const Text('Selecciona el color principal'),
              trailing: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstants.lightGrey,
                    width: 2,
                  ), // Borde rojo
                ),
                child: CircleAvatar(
                  backgroundColor: selectedPrimaryBgColor,
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
                  border: Border.all(
                    color: ColorConstants.lightGrey,
                    width: 2,
                  ), // Borde rojo
                ),
                child: CircleAvatar(
                  backgroundColor: selectedPrimaryTxtColor,
                ),
              ),
              onTap: () {
                _showColorPicker(context, ColorConstants.primaryTxtColorName);
              },
            ),
          ],
        );
      }),
    );
  }

  Future<void> _showColorPicker(BuildContext context, String colorName) async {
    debugPrint("Color Name $colorName");
    final prefs = await SharedPreferences.getInstance();
    String? colorString = prefs.getString(colorName);
    debugPrint("Color String $colorString");
    Color selectedColor = colorString != null
        ? Color(int.parse(colorString))
        : (colorName == ColorConstants.primaryColorName)
            ? ColorConstants.primaryBgColor
            : ColorConstants.primaryTxtColor;
    debugPrint("Selected Color ${selectedColor.value}");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) async {
                setState(() {
                  selectedColor = color;
                });
                if (colorName == ColorConstants.primaryColorName) {
                  setState(() {
                    selectedPrimaryBgColor = selectedColor;
                  });
                }
                if (colorName == ColorConstants.primaryTxtColorName) {
                  setState(() {
                    selectedPrimaryTxtColor = selectedColor;
                  });
                }
                prefs.setString(colorName, selectedColor.value.toString());
                themeManager.changeColor(color, colorName);
                context.read<SettingsBloc>().add(
                      ChangeColor(
                        isDarkMode: isDarkMode,
                        primaryColor: selectedPrimaryBgColor,
                        primaryTextColor: selectedPrimaryTxtColor,
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
