import 'package:flutter/material.dart';

import 'package:agenda_cumples/ui/themes/themes.dart';

// Todo: Neomorfismo
class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = LightTheme.light;
  bool _isDark = false;

  ThemeData get getTheme => _theme;
  bool get isDark => _isDark;

  set setTheme(String value) {
    if (value == 'dark') {
      _theme = DarkTheme.dark;
      _isDark = true;
    } else if(value == 'light') {
      _theme = LightTheme.light;
      _isDark = false;
    }
    notifyListeners();
  }
}
