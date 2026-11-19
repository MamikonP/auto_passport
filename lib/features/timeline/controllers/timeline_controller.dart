import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/enums/currency.dart';
import '../../../core/models/vehicle_passport_model.dart';
import '../../../core/repository/service_record_repository.dart';
import '../../../core/repository/settings_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../models/timeline_models.dart';

part 'timeline_controller.g.dart';

// ignore: library_private_types_in_public_api
class TimelineController = _TimelineControllerBase with _$TimelineController;

abstract class _TimelineControllerBase with Store {
  final VehicleRepository _vehicleRepository;
  final ServiceRecordRepository _serviceRecordRepository;
  final SettingsRepository _settingsRepository;

  _TimelineControllerBase({
    VehicleRepository? vehicleRepository,
    ServiceRecordRepository? serviceRecordRepository,
    SettingsRepository? settingsRepository,
  })  : _vehicleRepository = vehicleRepository ?? Locator.vehicleRepository,
        _serviceRecordRepository = serviceRecordRepository ?? Locator.serviceRecordRepository,
        _settingsRepository = settingsRepository ?? Locator.settingsRepository;

  @observable
  String selectedCategoryFilter = 'All';

  Currency get displayCurrency => _settingsRepository.displayCurrency;

  @computed
  VehiclePassportModel? get activeVehicle => _vehicleRepository.activeVehicle;

  @computed
  bool get hasActiveVehicle => activeVehicle != null;

  @computed
  int get totalVehiclesCount => _vehicleRepository.totalVehiclesCount;

  @computed
  List<TimelineEntryModel> get timelineEntries {
    final vehicle = activeVehicle;
    if (vehicle == null) return const [];

    final targetCurrency = _settingsRepository.displayCurrency;
    final records = _serviceRecordRepository.getRecordsForVehicle(vehicleId: vehicle.id);
    final filtered = _serviceRecordRepository.filterRecords(records, selectedCategoryFilter);

    return List.generate(filtered.length, (index) {
      return TimelineEntryModel(
        record: filtered[index],
        currency: targetCurrency,
        isLast: index == filtered.length - 1,
      );
    });
  }

  @action
  void setCategoryFilter(String category) {
    selectedCategoryFilter = category;
  }

  @action
  void deleteRecord(String recordId) {
    final vehicle = activeVehicle;
    if (vehicle != null) {
      _serviceRecordRepository.deleteRecord(vehicle.id, recordId);
    }
  }

  @action
  void deleteVehicle(String id) {
    _vehicleRepository.deleteVehicle(id);
  }

  @action
  void deleteActiveVehicle() {
    final vehicle = activeVehicle;
    if (vehicle != null) {
      _vehicleRepository.deleteVehicle(vehicle.id);
    }
  }
}
