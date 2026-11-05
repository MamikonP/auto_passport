import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../models/add_vehicle_form_model.dart';

part 'add_vehicle_controller.g.dart';

// ignore: library_private_types_in_public_api
class AddVehicleController = _AddVehicleControllerBase with _$AddVehicleController;

abstract class _AddVehicleControllerBase with Store {
  final VehicleRepository _repository;

  _AddVehicleControllerBase({VehicleRepository? repository})
      : _repository = repository ?? Locator.vehicleRepository;

  @observable
  String vin = 'WBA5A7C52FD129482';

  @observable
  String make = 'BMW';

  @observable
  String model = '528i xDrive';

  @observable
  int year = 2013;

  @observable
  String fuelPowertrain = 'Petrol (Gasoline)';

  @observable
  int mileage = 142000;

  @observable
  DistanceUnit distanceUnit = DistanceUnit.km;

  @observable
  Currency currency = Currency.amd;

  @observable
  bool photoAdded = false;

  final List<String> fuelOptions = const [
    'Petrol (Gasoline)',
    'Diesel',
    'Hybrid (HEV / PHEV)',
    'Electric (EV)',
    'Gas (LPG / CNG)',
  ];

  @action
  void setVin(String val) => vin = val;

  @action
  void setMake(String val) => make = val;

  @action
  void setModel(String val) => model = val;

  @action
  void setYear(int val) => year = val;

  @action
  void setFuel(String val) => fuelPowertrain = val;

  @action
  void setMileage(int val) => mileage = val;

  @action
  void setDistanceUnit(DistanceUnit val) => distanceUnit = val;

  @action
  void setCurrency(Currency val) => currency = val;

  @action
  void togglePhoto() => photoAdded = !photoAdded;

  @action
  VehiclePassportModel submitVehicle() {
    final form = AddVehicleFormModel(
      vin: vin,
      make: make,
      model: model,
      year: year,
      fuelPowertrain: fuelPowertrain,
      mileage: mileage,
      distanceUnit: distanceUnit,
      currency: currency,
      hasPhoto: photoAdded,
    );

    final vehicle = form.toVehiclePassportModel();
    _repository.addVehicle(vehicle);
    return vehicle;
  }
}
