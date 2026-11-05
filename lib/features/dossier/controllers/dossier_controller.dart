import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/repository/vehicle_repository.dart';

part 'dossier_controller.g.dart';

// ignore: library_private_types_in_public_api
class DossierController = _DossierControllerBase with _$DossierController;

abstract class _DossierControllerBase with Store {
  final VehicleRepository _repository;

  _DossierControllerBase({VehicleRepository? repository})
      : _repository = repository ?? Locator.vehicleRepository;

  @observable
  bool includePartBoxPhotos = true;

  @observable
  bool includeCostTotals = true;

  @observable
  bool watermarkWithVin = true;

  @computed
  VehiclePassportModel? get activeVehicle => _repository.activeVehicle;

  @computed
  bool get hasActiveVehicle => activeVehicle != null;

  @computed
  String get publicUrl {
    final v = activeVehicle;
    if (v == null) return 'autopassport.am/v/dossier';
    final yearStr = v.year.toString();
    final yearSuffix = yearStr.length >= 2 ? yearStr.substring(yearStr.length - 2) : yearStr;
    return 'autopassport.am/v/${v.make.toLowerCase()}-$yearSuffix';
  }

  @action
  void toggleIncludePartBoxPhotos(bool? val) {
    includePartBoxPhotos = val ?? true;
  }

  @action
  void toggleIncludeCostTotals(bool? val) {
    includeCostTotals = val ?? true;
  }

  @action
  void toggleWatermarkWithVin(bool? val) {
    watermarkWithVin = val ?? true;
  }
}
