import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/enums/currency.dart';
import '../../../core/enums/service_category.dart';
import '../../../core/models/service_record_model.dart';
import '../../../core/repository/service_record_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../models/record_detail_model.dart';

part 'record_detail_controller.g.dart';

// ignore: library_private_types_in_public_api
class RecordDetailController = _RecordDetailControllerBase with _$RecordDetailController;

abstract class _RecordDetailControllerBase with Store {
  final VehicleRepository _vehicleRepository;
  final ServiceRecordRepository _serviceRecordRepository;

  _RecordDetailControllerBase({
    VehicleRepository? vehicleRepository,
    ServiceRecordRepository? serviceRecordRepository,
  })  : _vehicleRepository = vehicleRepository ?? Locator.vehicleRepository,
        _serviceRecordRepository = serviceRecordRepository ?? Locator.serviceRecordRepository;

  @observable
  bool isIncludedInDossier = true;

  @observable
  bool isEditMode = false;

  @action
  void toggleIncludedInDossier() {
    isIncludedInDossier = !isIncludedInDossier;
  }

  @action
  void toggleEditMode() {
    isEditMode = !isEditMode;
  }

  RecordBreakdownModel getRecordDetail(String recordId, {String? vehicleId}) {
    final vehicle = (vehicleId != null)
        ? (_vehicleRepository.vehicles.where((v) => v.id == vehicleId).firstOrNull ?? _vehicleRepository.activeVehicle)
        : _vehicleRepository.activeVehicle;

    final records = _serviceRecordRepository.getRecordsForVehicle(vehicleId: vehicle?.id);
    final record = records.where((r) => r.id == recordId).firstOrNull ??
        (records.isNotEmpty
            ? records.first
            : ServiceRecordModel(
                id: recordId,
                title: 'Service Record #$recordId',
                description: 'Service log details.',
                date: DateTime.now(),
                mileageKm: vehicle?.currentMileage ?? 0,
                totalCost: 0,
                facilityName: 'Service Facility',
                category: ServiceCategory.oilFilter,
              ));

    return RecordBreakdownModel(
      record: record,
      currency: vehicle?.currency ?? Currency.amd,
    );
  }

  @action
  void deleteRecord(String recordId, {String? vehicleId}) {
    final vehicle = (vehicleId != null)
        ? (_vehicleRepository.vehicles.where((v) => v.id == vehicleId).firstOrNull ?? _vehicleRepository.activeVehicle)
        : _vehicleRepository.activeVehicle;
    if (vehicle != null) {
      _serviceRecordRepository.deleteRecord(vehicle.id, recordId);
    }
  }
}
