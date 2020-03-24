import 'package:flutter/material.dart';

class ApplicationThemeData {
  static ThemeData themeData() {
    return new ThemeData(
      brightness: Brightness.light,
      primaryColorDark: Colors.deepPurple,
      primaryColorLight: Colors.deepPurpleAccent,
      primaryColor: Colors.deepPurple,
      accentColor: Colors.orangeAccent,
      dividerColor: Colors.black,
    );
  }
}