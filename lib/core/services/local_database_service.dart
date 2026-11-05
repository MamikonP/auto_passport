import '../models/vehicle_passport_model.dart';

/// Abstract contract for high-performance local storage.
abstract class LocalDatabaseService {
  bool get isInitialized;

  /// Initializes local storage and opens database partitions.
  Future<void> init({String? subDir});

  /// Retrieves all vehicles currently persisted in local DB.
  Future<List<VehiclePassportModel>> getAllVehicles();

  /// Retrieves a single vehicle by its ID.
  Future<VehiclePassportModel?> getVehicle(String id);

  /// Inserts or updates a vehicle in local storage.
  Future<void> saveVehicle(VehiclePassportModel vehicle);

  /// Saves multiple vehicles in a batch for high throughput.
  Future<void> saveVehicles(List<VehiclePassportModel> vehicles);

  /// Deletes a vehicle by its ID.
  Future<void> deleteVehicle(String id);

  /// Wipes all vehicles from local storage (clean slate).
  Future<void> clearVehicles();

  /// Returns the saved active vehicle ID, if any.
  Future<String?> getActiveVehicleId();

  /// Persists the active vehicle ID.
  Future<void> setActiveVehicleId(String? id);

  /// Saves a general setting key-value pair.
  Future<void> saveSetting(String key, dynamic value);

  /// Retrieves a saved setting value.
  Future<T?> getSetting<T>(String key, [T? defaultValue]);
}
