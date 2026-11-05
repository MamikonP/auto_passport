import '../../../core/models/vehicle_model.dart';

class GarageItemModel {
  final VehiclePassportModel vehicle;
  final bool isActive;

  const GarageItemModel({
    required this.vehicle,
    required this.isActive,
  });

  String get id => vehicle.id;
  String get fullName => vehicle.fullName;
  String get maskedVin => vehicle.maskedVin;
  String get formattedMileage => vehicle.formattedMileage;
  String get formattedTotalSpent => vehicle.formattedTotalSpent;
  int get verifiedRecordsCount => vehicle.verifiedRecordsCount;
  String get specSummary => '${vehicle.year} • ${vehicle.fuelPowertrain} • ${vehicle.bodyType}';
}
