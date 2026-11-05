// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsController on _SettingsControllerBase, Store {
  Computed<String>? _$appLanguageComputed;

  @override
  String get appLanguage => (_$appLanguageComputed ??= Computed<String>(
    () => super.appLanguage,
    name: '_SettingsControllerBase.appLanguage',
  )).value;
  Computed<Currency>? _$displayCurrencyComputed;

  @override
  Currency get displayCurrency =>
      (_$displayCurrencyComputed ??= Computed<Currency>(
        () => super.displayCurrency,
        name: '_SettingsControllerBase.displayCurrency',
      )).value;
  Computed<DistanceUnit>? _$distanceUnitComputed;

  @override
  DistanceUnit get distanceUnit =>
      (_$distanceUnitComputed ??= Computed<DistanceUnit>(
        () => super.distanceUnit,
        name: '_SettingsControllerBase.distanceUnit',
      )).value;
  Computed<bool>? _$notificationsEnabledComputed;

  @override
  bool get notificationsEnabled =>
      (_$notificationsEnabledComputed ??= Computed<bool>(
        () => super.notificationsEnabled,
        name: '_SettingsControllerBase.notificationsEnabled',
      )).value;
  Computed<bool>? _$isCloudSyncedComputed;

  @override
  bool get isCloudSynced => (_$isCloudSyncedComputed ??= Computed<bool>(
    () => super.isCloudSynced,
    name: '_SettingsControllerBase.isCloudSynced',
  )).value;

  late final _$clearAllDataAsyncAction = AsyncAction(
    '_SettingsControllerBase.clearAllData',
    context: context,
  );

  @override
  Future<void> clearAllData() {
    return _$clearAllDataAsyncAction.run(() => super.clearAllData());
  }

  late final _$_SettingsControllerBaseActionController = ActionController(
    name: '_SettingsControllerBase',
    context: context,
  );

  @override
  void setAppLanguage(String lang) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
      name: '_SettingsControllerBase.setAppLanguage',
    );
    try {
      return super.setAppLanguage(lang);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDisplayCurrency(Currency currency) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
      name: '_SettingsControllerBase.setDisplayCurrency',
    );
    try {
      return super.setDisplayCurrency(currency);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDistanceUnit(DistanceUnit unit) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
      name: '_SettingsControllerBase.setDistanceUnit',
    );
    try {
      return super.setDistanceUnit(unit);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleNotifications(bool val) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
      name: '_SettingsControllerBase.toggleNotifications',
    );
    try {
      return super.toggleNotifications(val);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCloudSync(bool val) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
      name: '_SettingsControllerBase.toggleCloudSync',
    );
    try {
      return super.toggleCloudSync(val);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appLanguage: ${appLanguage},
displayCurrency: ${displayCurrency},
distanceUnit: ${distanceUnit},
notificationsEnabled: ${notificationsEnabled},
isCloudSynced: ${isCloudSynced}
    ''';
  }
}
