import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'MyApp';
  static const bool isDebug = false;
  static const String userRoleId = '644dc7c3999ad1fe7e0471ad';
  static const String primaryColorName = 'primaryColor';
  static const String primaryTxtColorName = 'primaryTextColor';
  static const Color lightGrey = Color.fromARGB(255, 210, 209, 209);
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color primaryBgColor = Colors.blueAccent;
  static const Color primaryTxtColor = Colors.black;

  static String colorToIntString(Color color) {
    return color.value.toString();
  }
}