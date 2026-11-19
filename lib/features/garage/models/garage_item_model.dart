import '../../../core/models/vehicle_model.dart';

class GarageItemModel {
  final VehiclePassportModel vehicle;
  final bool isActive;
  final Currency? displayCurrency;

  const GarageItemModel({
    required this.vehicle,
    required this.isActive,
    this.displayCurrency,
  });

  String get id => vehicle.id;
  String get fullName => vehicle.fullName;
  String get maskedVin => vehicle.maskedVin;
  String get formattedMileage => vehicle.formattedMileage;
  String get formattedTotalSpent =>
      vehicle.formattedTotalSpentIn(displayCurrency ?? vehicle.currency);
  int get verifiedRecordsCount => vehicle.verifiedRecordsCount;
  String get specSummary => '${vehicle.year} • ${vehicle.fuelPowertrain} • ${vehicle.bodyType}';
}
