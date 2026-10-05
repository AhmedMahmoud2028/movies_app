import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {

  ThemeMode currentTheme = ThemeMode.light;


  void changeCurrentTheme(ThemeMode newThemeMode)
  {
    if (newThemeMode == currentTheme) {
      return;
    }

    currentTheme = newThemeMode ;
    notifyListeners();

  }

  bool isDark() =>  currentTheme == ThemeMode.dark;

  }




