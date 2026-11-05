import '../../../core/models/vehicle_model.dart';

class AddVehicleFormModel {
  final String vin;
  final String make;
  final String model;
  final int year;
  final String fuelPowertrain;
  final int mileage;
  final DistanceUnit distanceUnit;
  final Currency currency;
  final bool hasPhoto;

  const AddVehicleFormModel({
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelPowertrain,
    required this.mileage,
    required this.distanceUnit,
    required this.currency,
    required this.hasPhoto,
  });

  VehiclePassportModel toVehiclePassportModel() {
    return VehiclePassportModel(
      id: 'veh-${DateTime.now().millisecondsSinceEpoch}',
      make: make.isNotEmpty ? make : 'BMW',
      model: model.isNotEmpty ? model : '528i',
      year: year > 0 ? year : 2013,
      vin: vin.toUpperCase(),
      fuelPowertrain: fuelPowertrain,
      bodyType: 'Sedan',
      currentMileage: mileage > 0 ? mileage : 142000,
      distanceUnit: distanceUnit,
      currency: currency,
      isActive: true,
      licensePlate: '77 VV 707',
      serviceRecords: const [],
    );
  }
}
