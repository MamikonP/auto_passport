import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/repository/settings_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../models/garage_item_model.dart';

part 'garage_controller.g.dart';

// ignore: library_private_types_in_public_api
class GarageController = _GarageControllerBase with _$GarageController;

abstract class _GarageControllerBase with Store {
  final VehicleRepository _repository;
  final SettingsRepository _settingsRepository;

  _GarageControllerBase({
    VehicleRepository? repository,
    SettingsRepository? settingsRepository,
  })  : _repository = repository ?? Locator.vehicleRepository,
        _settingsRepository = settingsRepository ?? Locator.settingsRepository;

  @computed
  List<GarageItemModel> get garageItems {
    final targetCurrency = _settingsRepository.displayCurrency;
    final targetDistanceUnit = _settingsRepository.distanceUnit;
    return _repository.vehicles.map((v) {
      return GarageItemModel(
        vehicle: v,
        isActive: v.id == _repository.activeVehicleId,
        displayCurrency: targetCurrency,
        displayDistanceUnit: targetDistanceUnit,
      );
    }).toList();
  }

  @computed
  int get totalVehiclesCount => _repository.totalVehiclesCount;

  @computed
  String? get activeVehicleId => _repository.activeVehicleId;

  @action
  void selectVehicle(String id) {
    _repository.setActiveVehicle(id);
  }

  @action
  void deleteVehicle(String id) {
    _repository.deleteVehicle(id);
  }

  @action
  Future<void> clearAll() => _repository.clearAll();
}
