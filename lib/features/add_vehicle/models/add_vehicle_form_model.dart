import '../../../core/models/vehicle_model.dart';

class AddVehicleFormModel {
  final String id;
  final String vin;
  final String make;
  final String model;
  final int year;
  final String fuelPowertrain;
  final String bodyType;
  final int mileage;
  final DistanceUnit distanceUnit;
  final Currency currency;
  final bool hasPhoto;
  final String? photoPath;

  const AddVehicleFormModel({
    required this.id,
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelPowertrain,
    required this.bodyType,
    required this.mileage,
    required this.distanceUnit,
    required this.currency,
    required this.hasPhoto,
    this.photoPath,
  });

  VehiclePassportModel toVehiclePassportModel() {
    return VehiclePassportModel(
      id: id,
      make: make.isNotEmpty ? make : 'BMW',
      model: model.isNotEmpty ? model : '528i',
      year: year > 0 ? year : 2013,
      vin: vin.toUpperCase(),
      fuelPowertrain: fuelPowertrain,
      bodyType: bodyType,
      currentMileage: mileage > 0 ? mileage : 142000,
      distanceUnit: distanceUnit,
      currency: currency,
      isActive: true,
      photoUrl: photoPath,
      licensePlate: '77 VV 707',
      serviceRecords: const [],
    );
  }
}
