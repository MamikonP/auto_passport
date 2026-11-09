import 'package:auto_passport/core/enums/body_type_options.dart';
import 'package:auto_passport/core/enums/fuel_options.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/image_picker_controller.dart';
import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../../../core/services/media_service.dart';
import '../models/add_vehicle_form_model.dart';

part 'add_vehicle_controller.g.dart';

// ignore: library_private_types_in_public_api
class AddVehicleController = _AddVehicleControllerBase
    with _$AddVehicleController;

abstract class _AddVehicleControllerBase with Store {
  final VehicleRepository _repository;
  final ImagePickerController imagePickerController;

  _AddVehicleControllerBase({
    VehicleRepository? repository,
    MediaService? mediaService,
    ImagePickerController? imagePickerController,
  }) : _repository = repository ?? Locator.vehicleRepository,
       imagePickerController =
           imagePickerController ??
           ImagePickerController(
             mediaService: mediaService ?? Locator.mediaService,
           );

  @observable
  String vin = '';

  @observable
  String make = '';

  @observable
  String model = '';

  @observable
  int year = 0;

  @observable
  String fuelPowertrain = FuelOptions.values.first.value;

  @observable
  String bodyType = BodyTypeOptions.values.first.value;

  @observable
  int mileage = 0;

  @observable
  DistanceUnit distanceUnit = DistanceUnit.km;

  @observable
  Currency currency = Currency.amd;

  @observable
  bool photoAdded = false;

  @observable
  String? photoPath;

  final fuelOptions = FuelOptions.values;
  final bodyTypeOptions = BodyTypeOptions.values;

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
  void setBodyType(String val) => bodyType = val;

  @action
  void setMileage(int val) => mileage = val;

  @action
  void setDistanceUnit(DistanceUnit val) => distanceUnit = val;

  @action
  void setCurrency(Currency val) => currency = val;

  @action
  void togglePhoto() {
    photoAdded = !photoAdded;
    if (!photoAdded) {
      photoPath = null;
      imagePickerController.clearImage();
    }
  }

  @action
  Future<String?> pickPhotoFromGallery() async {
    final path = await imagePickerController.pickFromGallery();
    if (path != null) {
      photoPath = path;
      photoAdded = true;
    }
    return path;
  }

  @action
  Future<String?> capturePhotoFromCamera() async {
    final path = await imagePickerController.captureFromCamera();
    if (path != null) {
      photoPath = path;
      photoAdded = true;
    }
    return path;
  }

  @action
  void removePhoto() {
    photoPath = null;
    photoAdded = false;
    imagePickerController.clearImage();
  }

  @action
  VehiclePassportModel submitVehicle() {
    final form = AddVehicleFormModel(
      vin: vin,
      make: make,
      model: model,
      year: year,
      fuelPowertrain: fuelPowertrain,
      bodyType: bodyType,
      mileage: mileage,
      distanceUnit: distanceUnit,
      currency: currency,
      hasPhoto: photoAdded,
      photoPath: photoPath,
    );

    final vehicle = form.toVehiclePassportModel();
    _repository.addVehicle(vehicle);
    return vehicle;
  }
}
