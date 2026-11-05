import 'package:mobx/mobx.dart';
import '../di/locator.dart';
import '../enums/service_category.dart';
import '../models/service_record_model.dart';
import '../services/local_database_service.dart';
import 'vehicle_repository.dart';

part 'service_record_repository.g.dart';

// ignore: library_private_types_in_public_api
class ServiceRecordRepository = _ServiceRecordRepositoryBase
    with _$ServiceRecordRepository;

abstract class _ServiceRecordRepositoryBase with Store {
  final VehicleRepository vehicleRepository;
  final LocalDatabaseService databaseService;

  _ServiceRecordRepositoryBase({
    required this.vehicleRepository,
    LocalDatabaseService? databaseService,
  }) : databaseService = databaseService ?? Locator.databaseService;

  /// Retrieves records for a specific vehicle, or the active vehicle if vehicleId is null.
  List<ServiceRecordModel> getRecordsForVehicle({String? vehicleId}) {
    final vehicle = vehicleId != null
        ? vehicleRepository.vehicles.where((v) => v.id == vehicleId).firstOrNull
        : vehicleRepository.activeVehicle;
    return vehicle?.serviceRecords ?? const [];
  }

  /// Filters a list of service records by category pill.
  List<ServiceRecordModel> filterRecords(
    List<ServiceRecordModel> records,
    String categoryFilter,
  ) {
    if (categoryFilter == 'All') return records;
    return records.where((r) {
      if (categoryFilter == 'Suspension') {
        return r.category == ServiceCategory.suspension;
      } else if (categoryFilter == 'Brakes') {
        return r.category == ServiceCategory.brakes;
      } else if (categoryFilter == 'Oil & Filter') {
        return r.category == ServiceCategory.oilFilter;
      } else if (categoryFilter == 'Engine') {
        return r.category == ServiceCategory.engine;
      } else if (categoryFilter == 'Transmission') {
        return r.category == ServiceCategory.transmission;
      }
      return true;
    }).toList();
  }

  /// Appends a new service record and updates stats and persistence.
  @action
  void addRecord(String vehicleId, ServiceRecordModel record) {
    final index = vehicleRepository.vehicles.indexWhere(
      (v) => v.id == vehicleId,
    );
    if (index != -1) {
      final vehicle = vehicleRepository.vehicles[index];
      final updatedList = List<ServiceRecordModel>.from(vehicle.serviceRecords)
        ..insert(0, record);
      final newSpent = vehicle.lifetimeTotalSpentOverride != null
          ? vehicle.lifetimeTotalSpentOverride! + record.totalCost
          : null;
      final newCount = vehicle.totalVerifiedRecordsOverride != null
          ? vehicle.totalVerifiedRecordsOverride! + (record.isVerified ? 1 : 0)
          : null;

      final updated = vehicle.copyWith(
        serviceRecords: updatedList,
        lifetimeTotalSpentOverride: newSpent,
        totalVerifiedRecordsOverride: newCount,
      );
      vehicleRepository.vehicles[index] = updated;
      databaseService.saveVehicle(updated);
    }
  }

  /// Removes a service record and recalculates stats and persistence.
  @action
  void deleteRecord(String vehicleId, String recordId) {
    final index = vehicleRepository.vehicles.indexWhere(
      (v) => v.id == vehicleId,
    );
    if (index != -1) {
      final vehicle = vehicleRepository.vehicles[index];
      final recordToRemove = vehicle.serviceRecords
          .where((r) => r.id == recordId)
          .firstOrNull;
      if (recordToRemove == null) return;

      final updatedList = vehicle.serviceRecords
          .where((r) => r.id != recordId)
          .toList();
      final newSpent = vehicle.lifetimeTotalSpentOverride != null
          ? vehicle.lifetimeTotalSpentOverride! - recordToRemove.totalCost
          : null;
      final newCount = vehicle.totalVerifiedRecordsOverride != null
          ? vehicle.totalVerifiedRecordsOverride! -
                (recordToRemove.isVerified ? 1 : 0)
          : null;

      final updated = vehicle.copyWith(
        serviceRecords: updatedList,
        lifetimeTotalSpentOverride: newSpent,
        totalVerifiedRecordsOverride: newCount,
      );
      vehicleRepository.vehicles[index] = updated;
      databaseService.saveVehicle(updated);
    }
  }
}
