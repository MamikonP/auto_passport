import '../../../core/models/vehicle_model.dart';

class SettingsConfigModel {
  final String appLanguage;
  final Currency defaultCurrency;
  final DistanceUnit distanceUnit;
  final bool isCloudSynced;

  const SettingsConfigModel({
    this.appLanguage = 'English',
    this.defaultCurrency = Currency.amd,
    this.distanceUnit = DistanceUnit.km,
    this.isCloudSynced = true,
  });
}
