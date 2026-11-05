// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsRepository on _SettingsRepositoryBase, Store {
  late final _$appLanguageAtom = Atom(
    name: '_SettingsRepositoryBase.appLanguage',
    context: context,
  );

  @override
  String get appLanguage {
    _$appLanguageAtom.reportRead();
    return super.appLanguage;
  }

  @override
  set appLanguage(String value) {
    _$appLanguageAtom.reportWrite(value, super.appLanguage, () {
      super.appLanguage = value;
    });
  }

  late final _$displayCurrencyAtom = Atom(
    name: '_SettingsRepositoryBase.displayCurrency',
    context: context,
  );

  @override
  Currency get displayCurrency {
    _$displayCurrencyAtom.reportRead();
    return super.displayCurrency;
  }

  @override
  set displayCurrency(Currency value) {
    _$displayCurrencyAtom.reportWrite(value, super.displayCurrency, () {
      super.displayCurrency = value;
    });
  }

  late final _$distanceUnitAtom = Atom(
    name: '_SettingsRepositoryBase.distanceUnit',
    context: context,
  );

  @override
  DistanceUnit get distanceUnit {
    _$distanceUnitAtom.reportRead();
    return super.distanceUnit;
  }

  @override
  set distanceUnit(DistanceUnit value) {
    _$distanceUnitAtom.reportWrite(value, super.distanceUnit, () {
      super.distanceUnit = value;
    });
  }

  late final _$notificationsEnabledAtom = Atom(
    name: '_SettingsRepositoryBase.notificationsEnabled',
    context: context,
  );

  @override
  bool get notificationsEnabled {
    _$notificationsEnabledAtom.reportRead();
    return super.notificationsEnabled;
  }

  @override
  set notificationsEnabled(bool value) {
    _$notificationsEnabledAtom.reportWrite(
      value,
      super.notificationsEnabled,
      () {
        super.notificationsEnabled = value;
      },
    );
  }

  late final _$isCloudSyncedAtom = Atom(
    name: '_SettingsRepositoryBase.isCloudSynced',
    context: context,
  );

  @override
  bool get isCloudSynced {
    _$isCloudSyncedAtom.reportRead();
    return super.isCloudSynced;
  }

  @override
  set isCloudSynced(bool value) {
    _$isCloudSyncedAtom.reportWrite(value, super.isCloudSynced, () {
      super.isCloudSynced = value;
    });
  }

  late final _$loadSettingsAsyncAction = AsyncAction(
    '_SettingsRepositoryBase.loadSettings',
    context: context,
  );

  @override
  Future<void> loadSettings() {
    return _$loadSettingsAsyncAction.run(() => super.loadSettings());
  }

  late final _$_SettingsRepositoryBaseActionController = ActionController(
    name: '_SettingsRepositoryBase',
    context: context,
  );

  @override
  void setAppLanguage(String lang) {
    final _$actionInfo = _$_SettingsRepositoryBaseActionController.startAction(
      name: '_SettingsRepositoryBase.setAppLanguage',
    );
    try {
      return super.setAppLanguage(lang);
    } finally {
      _$_SettingsRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDisplayCurrency(Currency currency) {
    final _$actionInfo = _$_SettingsRepositoryBaseActionController.startAction(
      name: '_SettingsRepositoryBase.setDisplayCurrency',
    );
    try {
      return super.setDisplayCurrency(currency);
    } finally {
      _$_SettingsRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDistanceUnit(DistanceUnit unit) {
    final _$actionInfo = _$_SettingsRepositoryBaseActionController.startAction(
      name: '_SettingsRepositoryBase.setDistanceUnit',
    );
    try {
      return super.setDistanceUnit(unit);
    } finally {
      _$_SettingsRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotificationsEnabled(bool val) {
    final _$actionInfo = _$_SettingsRepositoryBaseActionController.startAction(
      name: '_SettingsRepositoryBase.setNotificationsEnabled',
    );
    try {
      return super.setNotificationsEnabled(val);
    } finally {
      _$_SettingsRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCloudSynced(bool val) {
    final _$actionInfo = _$_SettingsRepositoryBaseActionController.startAction(
      name: '_SettingsRepositoryBase.setCloudSynced',
    );
    try {
      return super.setCloudSynced(val);
    } finally {
      _$_SettingsRepositoryBaseActionController.endAction(_$actionInfo);
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
