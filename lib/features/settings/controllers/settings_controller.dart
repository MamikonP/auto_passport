import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/controllers/billing_controller.dart';
import '../../../core/di/locator.dart';
import '../../../core/enums/currency.dart';
import '../../../core/enums/distance_unit.dart';
import '../../../core/repository/settings_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../../../core/services/vehicle_sync_codec.dart';
import '../../../core/theme/theme_controller.dart';

part 'settings_controller.g.dart';

// ignore: library_private_types_in_public_api
class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final ThemeController _themeController;
  final SettingsRepository _settingsRepository;
  final VehicleRepository _vehicleRepository;
  final BillingController _billingController;

  _SettingsControllerBase({
    ThemeController? themeController,
    SettingsRepository? settingsRepository,
    VehicleRepository? vehicleRepository,
    BillingController? billingController,
    @Deprecated('Use vehicleRepository instead') VehicleRepository? repository,
  })  : _themeController = themeController ?? Locator.themeController,
        _settingsRepository = settingsRepository ?? Locator.settingsRepository,
        _vehicleRepository = vehicleRepository ?? repository ?? Locator.vehicleRepository,
        _billingController = billingController ?? Locator.billingController;

  @computed
  String get appLanguage => _settingsRepository.appLanguage;

  @computed
  Currency get displayCurrency => _settingsRepository.displayCurrency;

  @computed
  DistanceUnit get distanceUnit => _settingsRepository.distanceUnit;

  @computed
  bool get notificationsEnabled => _settingsRepository.notificationsEnabled;

  @computed
  bool get isCloudSynced => _settingsRepository.isCloudSynced;

  @action
  void setAppLanguage(String lang) {
    _settingsRepository.setAppLanguage(lang);
    if (lang == 'Հայերեն') {
      _themeController.setLocale(const Locale('hy'));
    } else if (lang == 'Русский') {
      _themeController.setLocale(const Locale('ru'));
    } else {
      _themeController.setLocale(const Locale('en'));
    }
  }

  @action
  void setDisplayCurrency(Currency currency) {
    _settingsRepository.setDisplayCurrency(currency);
  }

  @action
  void setDistanceUnit(DistanceUnit unit) {
    _settingsRepository.setDistanceUnit(unit);
  }

  @action
  void toggleNotifications(bool val) {
    _settingsRepository.setNotificationsEnabled(val);
  }

  @action
  void toggleCloudSync(bool val) {
    _settingsRepository.setCloudSynced(val);
  }

  @action
  Future<void> clearAllData() async {
    await _vehicleRepository.clearAll();
  }

  int get vehiclesCount => _vehicleRepository.totalVehiclesCount;

  int get totalRecordsCount => _vehicleRepository.vehicles.fold(
    0,
    (sum, v) => sum + v.serviceRecords.length,
  );

  /// Encodes all vehicles, service records, and per-car passes into an encrypted sync code.
  String exportEncryptedVehicles() {
    return VehicleSyncCodec.encode(
      vehicles: _vehicleRepository.vehicles.toList(),
      activeVehicleId: _vehicleRepository.activeVehicleId,
      unlockedVehicleIds: _billingController.unlockedVehicleIds,
    );
  }

  /// Decodes an encrypted sync code and imports all vehicles and per-car passes.
  Future<int> importEncryptedVehicles(
    String encoded, {
    bool replaceExisting = false,
  }) async {
    final payload = VehicleSyncCodec.decode(encoded);
    final count = await _vehicleRepository.importVehicles(
      payload.vehicles,
      preferredActiveVehicleId: payload.activeVehicleId,
      replaceExisting: replaceExisting,
    );
    if (payload.unlockedVehicleIds.isNotEmpty) {
      await _billingController.mergeUnlockedVehicleIds(
        payload.unlockedVehicleIds,
      );
    }
    return count;
  }
}
