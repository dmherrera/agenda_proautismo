import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color get primaryColor => WhiteTheme.primaryColor;
  Color get secondaryColor => WhiteTheme.secondaryColor;
  Color get white => WhiteTheme.white;
  Color get black => WhiteTheme.black;
  Color get brown => WhiteTheme.brown;
}

class WhiteTheme {
  static Color primaryColor = Color.fromARGB(255, 149, 198, 238);
  static Color secondaryColor = const Color(0xFF159897);
  static Color black = Color.fromARGB(255, 0, 0, 0);
  static Color white = const Color(0xFFf7f7f7);
  static Color brown = const Color(0xFF159897);
  static Color grey = const Color.fromRGBO(240, 240, 240, 1);
  static Color textGrey = const Color.fromRGBO(181, 181, 181, 1);
  static Color borderColor = const Color.fromRGBO(204, 204, 204, 1);
  static Color backgroundMenu = const Color.fromRGBO(233, 233, 233, 1);
  static Color background = const Color.fromRGBO(249, 249, 249, 1);
  static Color backgroundMsg = const Color.fromRGBO(207, 207, 207, 1);
  static TextStyle primaryText =
      TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle secondaryText =
      TextStyle(color: black, fontWeight: FontWeight.normal);
  static TextStyle tertiaryText =
      TextStyle(color: textGrey, fontWeight: FontWeight.normal);
}
