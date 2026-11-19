import 'package:mobx/mobx.dart';

import '../di/locator.dart';
import '../models/service_record_model.dart';
import '../models/vehicle_passport_model.dart';
import '../services/local_database_service.dart';

part 'vehicle_repository.g.dart';

// ignore: library_private_types_in_public_api
class VehicleRepository = _VehicleRepositoryBase with _$VehicleRepository;

abstract class _VehicleRepositoryBase with Store {
  final LocalDatabaseService _databaseService;

  _VehicleRepositoryBase({
    LocalDatabaseService? databaseService,
    List<VehiclePassportModel>? initialVehicles,
    String? initialActiveVehicleId,
  }) : _databaseService = databaseService ?? Locator.databaseService {
    if (initialVehicles != null) {
      vehicles.addAll(initialVehicles);
      activeVehicleId =
          initialActiveVehicleId ??
          (initialVehicles.isNotEmpty ? initialVehicles.first.id : null);
    }
  }

  @observable
  ObservableList<VehiclePassportModel> vehicles =
      ObservableList<VehiclePassportModel>();

  @observable
  String? activeVehicleId;

  @observable
  bool isLoading = false;

  @computed
  VehiclePassportModel? get activeVehicle {
    if (vehicles.isEmpty) return null;
    if (activeVehicleId != null) {
      final found = vehicles.where((v) => v.id == activeVehicleId).firstOrNull;
      if (found != null) return found;
    }
    return vehicles.first;
  }

  @computed
  bool get hasVehicles => vehicles.isNotEmpty;

  @computed
  int get totalVehiclesCount => vehicles.length;

  /// Loads vehicles and active selection from local Hive database.
  @action
  Future<void> loadFromDatabase() async {
    isLoading = true;
    try {
      final savedVehicles = await _databaseService.getAllVehicles();
      final savedActiveId = await _databaseService.getActiveVehicleId();

      vehicles.clear();
      vehicles.addAll(savedVehicles);

      if (savedActiveId != null && vehicles.any((v) => v.id == savedActiveId)) {
        activeVehicleId = savedActiveId;
      } else {
        activeVehicleId = vehicles.isNotEmpty ? vehicles.first.id : null;
      }
    } finally {
      isLoading = false;
    }
  }

  /// Wipes all vehicles from local storage and memory (clean empty state).
  @action
  Future<void> clearAll() async {
    vehicles.clear();
    activeVehicleId = null;
    await _databaseService.clearVehicles();
    await _databaseService.setActiveVehicleId(null);
  }

  @action
  void setActiveVehicle(String id) {
    activeVehicleId = id;
    for (int i = 0; i < vehicles.length; i++) {
      vehicles[i] = vehicles[i].copyWith(isActive: vehicles[i].id == id);
    }
    _databaseService.setActiveVehicleId(id);
    _databaseService.saveVehicles(vehicles.toList());
  }

  @action
  void addVehicle(VehiclePassportModel vehicle) {
    vehicles.add(vehicle);
    setActiveVehicle(vehicle.id);
    _databaseService.saveVehicle(vehicle);
  }

  @action
  void updateVehicle(VehiclePassportModel vehicle) {
    final index = vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index != -1) {
      vehicles[index] = vehicle;
      _databaseService.saveVehicle(vehicle);
    }
  }

  @action
  void deleteVehicle(String id) {
    vehicles.removeWhere((v) => v.id == id);
    _databaseService.deleteVehicle(id);
    if (activeVehicleId == id) {
      if (vehicles.isNotEmpty) {
        setActiveVehicle(vehicles.first.id);
      } else {
        activeVehicleId = null;
        _databaseService.setActiveVehicleId(null);
      }
    }
  }

  /// Imports vehicles from an encrypted sync backup.
  /// When [replaceExisting] is true, replaces the local garage completely.
  /// Otherwise merges matching vehicles (by ID or VIN) and adds new ones.
  @action
  Future<int> importVehicles(
    List<VehiclePassportModel> incomingVehicles, {
    String? preferredActiveVehicleId,
    bool replaceExisting = false,
  }) async {
    if (replaceExisting) {
      vehicles.clear();
      await _databaseService.clearVehicles();
      vehicles.addAll(incomingVehicles);
    } else {
      for (final incoming in incomingVehicles) {
        final existingIndex = vehicles.indexWhere(
          (v) =>
              v.id == incoming.id ||
              (v.vin.trim().isNotEmpty &&
                  v.vin.trim().toUpperCase() ==
                      incoming.vin.trim().toUpperCase()),
        );
        if (existingIndex == -1) {
          vehicles.add(incoming);
        } else {
          final existing = vehicles[existingIndex];
          final mergedRecordsMap = <String, ServiceRecordModel>{
            for (final r in existing.serviceRecords) r.id: r,
            for (final r in incoming.serviceRecords) r.id: r,
          };
          final mergedRecords = mergedRecordsMap.values.toList()
            ..sort((a, b) => b.date.compareTo(a.date));

          vehicles[existingIndex] = incoming.copyWith(
            id: existing.id,
            serviceRecords: mergedRecords,
          );
        }
      }
    }

    String? nextActiveId = activeVehicleId;
    if (replaceExisting || nextActiveId == null || !vehicles.any((v) => v.id == nextActiveId)) {
      if (preferredActiveVehicleId != null &&
          vehicles.any((v) => v.id == preferredActiveVehicleId)) {
        nextActiveId = preferredActiveVehicleId;
      } else {
        nextActiveId = vehicles.isNotEmpty ? vehicles.first.id : null;
      }
    }

    activeVehicleId = nextActiveId;
    for (int i = 0; i < vehicles.length; i++) {
      vehicles[i] = vehicles[i].copyWith(
        isActive: vehicles[i].id == nextActiveId,
      );
    }

    await _databaseService.saveVehicles(vehicles.toList());
    await _databaseService.setActiveVehicleId(nextActiveId);
    return incomingVehicles.length;
  }
}
