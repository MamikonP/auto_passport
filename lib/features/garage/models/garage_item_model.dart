import '../../../core/models/vehicle_model.dart';

class GarageItemModel {
  final VehiclePassportModel vehicle;
  final bool isActive;
  final Currency? displayCurrency;
  final DistanceUnit? displayDistanceUnit;

  const GarageItemModel({
    required this.vehicle,
    required this.isActive,
    this.displayCurrency,
    this.displayDistanceUnit,
  });

  String get id => vehicle.id;
  String get fullName => vehicle.fullName;
  String get maskedVin => vehicle.maskedVin;
  String get formattedMileage =>
      vehicle.formattedMileageIn(displayDistanceUnit ?? vehicle.distanceUnit);
  String get formattedTotalSpent =>
      vehicle.formattedTotalSpentIn(displayCurrency ?? vehicle.currency);
  int get verifiedRecordsCount => vehicle.verifiedRecordsCount;
  String get specSummary => '${vehicle.year} • ${vehicle.fuelPowertrain} • ${vehicle.bodyType}';
}
