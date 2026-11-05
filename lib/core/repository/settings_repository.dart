import 'package:mobx/mobx.dart';

import '../di/locator.dart';
import '../enums/currency.dart';
import '../enums/distance_unit.dart';
import '../services/local_database_service.dart';

part 'settings_repository.g.dart';

// ignore: library_private_types_in_public_api
class SettingsRepository = _SettingsRepositoryBase with _$SettingsRepository;

abstract class _SettingsRepositoryBase with Store {
  final LocalDatabaseService databaseService;

  _SettingsRepositoryBase({LocalDatabaseService? databaseService})
      : databaseService = databaseService ?? Locator.databaseService;

  @observable
  String appLanguage = 'English';

  @observable
  Currency displayCurrency = Currency.amd;

  @observable
  DistanceUnit distanceUnit = DistanceUnit.km;

  @observable
  bool notificationsEnabled = true;

  @observable
  bool isCloudSynced = true;

  @action
  Future<void> loadSettings() async {
    final savedLang = await databaseService.getSetting<String>('app_language');
    final savedCurrency = await databaseService.getSetting<String>(
      'display_currency',
    );
    final savedUnit = await databaseService.getSetting<String>('distance_unit');
    final savedNotifications = await databaseService.getSetting<bool>(
      'notifications_enabled',
    );
    final savedCloud = await databaseService.getSetting<bool>('cloud_synced');

    if (savedLang != null) {
      appLanguage = savedLang;
    }
    if (savedCurrency != null) {
      displayCurrency = Currency.fromString(savedCurrency);
    }
    if (savedUnit != null) {
      distanceUnit = DistanceUnit.fromString(savedUnit);
    }
    if (savedNotifications != null) {
      notificationsEnabled = savedNotifications;
    }
    if (savedCloud != null) {
      isCloudSynced = savedCloud;
    }
  }

  @action
  void setAppLanguage(String lang) {
    appLanguage = lang;
    databaseService.saveSetting('app_language', lang);
  }

  @action
  void setDisplayCurrency(Currency currency) {
    displayCurrency = currency;
    databaseService.saveSetting('display_currency', currency.name);
  }

  @action
  void setDistanceUnit(DistanceUnit unit) {
    distanceUnit = unit;
    databaseService.saveSetting('distance_unit', unit.name);
  }

  @action
  void setNotificationsEnabled(bool val) {
    notificationsEnabled = val;
    databaseService.saveSetting('notifications_enabled', val);
  }

  @action
  void setCloudSynced(bool val) {
    isCloudSynced = val;
    databaseService.saveSetting('cloud_synced', val);
  }
}
