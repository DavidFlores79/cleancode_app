import 'package:flutter/material.dart';

class ColorConstants {
  static const String primaryColorName = 'primaryColor';
  static const String primaryTxtColorName = 'primaryTextColor';
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color.fromARGB(255, 228, 227, 227);
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
  static const Color primaryBgColor = Colors.blueAccent;
  static const Color primaryTxtColor = Colors.black;
  //Status
  static const Color inactiveColor = Colors.red;
  static const Color activeColor = Colors.lightGreen;

  static String colorToIntString(Color color) {
    return color.value.toString();
  }
}
