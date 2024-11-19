import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  ThemeData? currentTheme;

  setDarktheme() {
    currentTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: Brightness.dark,
      ),
      brightness: Brightness.dark,
    );
    notifyListeners();
  }

  setLighttheme() {
    currentTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purpleAccent,
        brightness: Brightness.light,
      ),
      brightness: Brightness.light,
    );
    notifyListeners();
  }
}
