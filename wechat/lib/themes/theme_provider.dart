import 'package:flutter/material.dart';
import 'package:wechat/themes/light_mode.dart';

import 'dark_mode.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  // Getter for accessing the current theme data
  ThemeData get themeData => _themeData;

  // Getter for checking if the current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Setter for updating the theme data and notifying listeners
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Function to toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }
}
