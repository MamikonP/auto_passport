import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme_controller.g.dart';

// ignore: library_private_types_in_public_api
class ThemeController = _ThemeControllerBase with _$ThemeController;

abstract class _ThemeControllerBase with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  @observable
  Locale currentLocale = const Locale('en');

  @computed
  bool get isDarkMode => themeMode == ThemeMode.dark;

  @action
  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
  }

  @action
  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  @action
  void setLocale(Locale locale) {
    currentLocale = locale;
  }
}
