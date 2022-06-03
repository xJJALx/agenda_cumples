import 'package:flutter/material.dart';

import 'package:agenda_cumples/ui/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Todo: Neomorfismo
class ThemeProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  ThemeData _theme = LightTheme.light;
  bool _isDark = false;

  ThemeData get getTheme => _theme;
  bool get isDark => _isDark;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadThemePrefs();
  }

  _saveThemePrefs(String theme) async => await _prefs.setString('theme', theme);

  _loadThemePrefs() async => setTheme = _prefs.getString('theme') ?? 'light';

  set setTheme(String value) {
    if (value == 'dark') {
      _theme = DarkTheme.dark;
      _isDark = true;
    } else if (value == 'light') {
      _theme = LightTheme.light;
      _isDark = false;
    }
    _saveThemePrefs(value);
    notifyListeners();
  }
}
