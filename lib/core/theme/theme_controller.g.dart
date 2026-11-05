// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeController on _ThemeControllerBase, Store {
  Computed<bool>? _$isDarkModeComputed;

  @override
  bool get isDarkMode => (_$isDarkModeComputed ??= Computed<bool>(
    () => super.isDarkMode,
    name: '_ThemeControllerBase.isDarkMode',
  )).value;

  late final _$themeModeAtom = Atom(
    name: '_ThemeControllerBase.themeMode',
    context: context,
  );

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$currentLocaleAtom = Atom(
    name: '_ThemeControllerBase.currentLocale',
    context: context,
  );

  @override
  Locale get currentLocale {
    _$currentLocaleAtom.reportRead();
    return super.currentLocale;
  }

  @override
  set currentLocale(Locale value) {
    _$currentLocaleAtom.reportWrite(value, super.currentLocale, () {
      super.currentLocale = value;
    });
  }

  late final _$_ThemeControllerBaseActionController = ActionController(
    name: '_ThemeControllerBase',
    context: context,
  );

  @override
  void setThemeMode(ThemeMode mode) {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
      name: '_ThemeControllerBase.setThemeMode',
    );
    try {
      return super.setThemeMode(mode);
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTheme() {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
      name: '_ThemeControllerBase.toggleTheme',
    );
    try {
      return super.toggleTheme();
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocale(Locale locale) {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
      name: '_ThemeControllerBase.setLocale',
    );
    try {
      return super.setLocale(locale);
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
currentLocale: ${currentLocale},
isDarkMode: ${isDarkMode}
    ''';
  }
}
