import 'package:get_it/get_it.dart';

import '../controllers/image_picker_controller.dart';
import '../repository/service_record_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/vehicle_repository.dart';
import '../services/hive_local_database_service.dart';
import '../services/local_database_service.dart';
import '../services/media_service.dart';
import '../theme/theme_controller.dart';
import '../../features/add_vehicle/controllers/add_vehicle_controller.dart';
import '../../features/dossier/controllers/dossier_controller.dart';
import '../../features/garage/controllers/garage_controller.dart';
import '../../features/intake/controllers/intake_controller.dart';
import '../../features/manual_entry/controllers/manual_entry_controller.dart';
import '../../features/record_detail/controllers/record_detail_controller.dart';
import '../../features/settings/controllers/settings_controller.dart';
import '../../features/shell/controllers/shell_controller.dart';
import '../../features/timeline/controllers/timeline_controller.dart';

/// Global GetIt service locator instance.
final GetIt getIt = GetIt.instance;

/// Service locator and dependency provider for MVC controllers and repositories using GetIt.
class Locator {
  Locator._();

  /// Returns the underlying GetIt container.
  static GetIt get instance => getIt;

  /// Registers all repositories and feature controllers into GetIt.
  static void setup() {
    if (!getIt.isRegistered<LocalDatabaseService>()) {
      getIt.registerLazySingleton<LocalDatabaseService>(
        () => HiveLocalDatabaseService(),
      );
    }
    if (!getIt.isRegistered<MediaService>()) {
      getIt.registerLazySingleton<MediaService>(() => MediaService());
    }
    if (!getIt.isRegistered<ImagePickerController>()) {
      getIt.registerFactory<ImagePickerController>(
        () => ImagePickerController(mediaService: getIt<MediaService>()),
      );
    }
    if (!getIt.isRegistered<VehicleRepository>()) {
      getIt.registerLazySingleton<VehicleRepository>(
        () => VehicleRepository(databaseService: getIt<LocalDatabaseService>()),
      );
    }
    if (!getIt.isRegistered<ServiceRecordRepository>()) {
      getIt.registerLazySingleton<ServiceRecordRepository>(
        () => ServiceRecordRepository(
          vehicleRepository: getIt<VehicleRepository>(),
          databaseService: getIt<LocalDatabaseService>(),
        ),
      );
    }
    if (!getIt.isRegistered<SettingsRepository>()) {
      getIt.registerLazySingleton<SettingsRepository>(
        () =>
            SettingsRepository(databaseService: getIt<LocalDatabaseService>()),
      );
    }
    if (!getIt.isRegistered<ThemeController>()) {
      getIt.registerLazySingleton<ThemeController>(() => ThemeController());
    }

    if (!getIt.isRegistered<ShellController>()) {
      getIt.registerLazySingleton<ShellController>(() => ShellController());
    }
    if (!getIt.isRegistered<GarageController>()) {
      getIt.registerLazySingleton<GarageController>(
        () => GarageController(repository: getIt<VehicleRepository>()),
      );
    }
    if (!getIt.isRegistered<AddVehicleController>()) {
      getIt.registerFactory<AddVehicleController>(
        () => AddVehicleController(
          repository: getIt<VehicleRepository>(),
          mediaService: getIt<MediaService>(),
          imagePickerController: getIt<ImagePickerController>(),
        ),
      );
    }
    if (!getIt.isRegistered<TimelineController>()) {
      getIt.registerLazySingleton<TimelineController>(
        () => TimelineController(
          vehicleRepository: getIt<VehicleRepository>(),
          serviceRecordRepository: getIt<ServiceRecordRepository>(),
        ),
      );
    }
    if (!getIt.isRegistered<RecordDetailController>()) {
      getIt.registerLazySingleton<RecordDetailController>(
        () => RecordDetailController(
          vehicleRepository: getIt<VehicleRepository>(),
          serviceRecordRepository: getIt<ServiceRecordRepository>(),
        ),
      );
    }
    if (!getIt.isRegistered<IntakeController>()) {
      getIt.registerLazySingleton<IntakeController>(
        () => IntakeController(repository: getIt<VehicleRepository>()),
      );
    }
    if (!getIt.isRegistered<ManualEntryController>()) {
      getIt.registerLazySingleton<ManualEntryController>(
        () => ManualEntryController(
          serviceRecordRepository: getIt<ServiceRecordRepository>(),
          vehicleRepository: getIt<VehicleRepository>(),
        ),
      );
    }
    if (!getIt.isRegistered<DossierController>()) {
      getIt.registerLazySingleton<DossierController>(
        () => DossierController(repository: getIt<VehicleRepository>()),
      );
    }
    if (!getIt.isRegistered<SettingsController>()) {
      getIt.registerLazySingleton<SettingsController>(
        () => SettingsController(
          settingsRepository: getIt<SettingsRepository>(),
          vehicleRepository: getIt<VehicleRepository>(),
        ),
      );
    }
  }

  static T _get<T extends Object>() {
    setup();
    return getIt<T>();
  }

  // GetIt-backed static accessors for backward-compatible and type-safe dependency resolution
  static LocalDatabaseService get databaseService =>
      _get<LocalDatabaseService>();
  static MediaService get mediaService => _get<MediaService>();
  static ImagePickerController get imagePickerController =>
      _get<ImagePickerController>();
  static VehicleRepository get vehicleRepository => _get<VehicleRepository>();
  static ServiceRecordRepository get serviceRecordRepository =>
      _get<ServiceRecordRepository>();
  static SettingsRepository get settingsRepository =>
      _get<SettingsRepository>();
  static ThemeController get themeController => _get<ThemeController>();

  static ShellController get shellController => _get<ShellController>();
  static GarageController get garageController => _get<GarageController>();
  static AddVehicleController get addVehicleController =>
      _get<AddVehicleController>();
  static TimelineController get timelineController =>
      _get<TimelineController>();
  static RecordDetailController get recordDetailController =>
      _get<RecordDetailController>();
  static IntakeController get intakeController => _get<IntakeController>();
  static ManualEntryController get manualEntryController =>
      _get<ManualEntryController>();
  static DossierController get dossierController => _get<DossierController>();
  static SettingsController get settingsController =>
      _get<SettingsController>();

  /// Initializes asynchronous dependencies like local database loading.
  static Future<void> init() async {
    setup();
    await databaseService.init();
    await settingsRepository.loadSettings();
    await vehicleRepository.loadFromDatabase();
  }

  /// Resets GetIt registrations.
  static Future<void> reset() async {
    await getIt.reset();
  }
}
