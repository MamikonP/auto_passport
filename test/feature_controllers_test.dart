import 'package:flutter_test/flutter_test.dart';
import 'package:auto_passport/core/di/locator.dart';
import 'package:auto_passport/core/models/vehicle_model.dart';
import 'package:auto_passport/core/repository/service_record_repository.dart';
import 'package:auto_passport/core/repository/settings_repository.dart';
import 'package:auto_passport/core/repository/vehicle_repository.dart';
import 'package:auto_passport/core/services/hive_local_database_service.dart';
import 'package:auto_passport/core/services/local_database_service.dart';
import 'package:auto_passport/features/add_vehicle/controllers/add_vehicle_controller.dart';
import 'package:auto_passport/features/dossier/controllers/dossier_controller.dart';
import 'package:auto_passport/features/garage/controllers/garage_controller.dart';
import 'package:auto_passport/features/intake/controllers/intake_controller.dart';
import 'package:auto_passport/features/manual_entry/controllers/manual_entry_controller.dart';
import 'package:auto_passport/features/record_detail/controllers/record_detail_controller.dart';
import 'package:auto_passport/features/settings/controllers/settings_controller.dart';
import 'package:auto_passport/features/shell/controllers/shell_controller.dart';
import 'package:auto_passport/features/shell/models/shell_navigation_model.dart';
import 'package:auto_passport/features/timeline/controllers/timeline_controller.dart';

VehiclePassportModel createTestVehicle({
  String id = 'veh-01',
  String make = 'VW',
  String model = 'Touareg 3.0 TDI',
  int year = 2017,
  String vin = 'WVWZZZ7PZHD012345',
  int mileage = 184250,
  List<ServiceRecordModel>? serviceRecords,
}) {
  return VehiclePassportModel(
    id: id,
    make: make,
    model: model,
    year: year,
    vin: vin,
    currentMileage: mileage,
    fuelPowertrain: 'Diesel 3.0 V6',
    bodyType: 'SUV',
    currency: Currency.amd,
    serviceRecords: serviceRecords ?? [
      ServiceRecordModel(
        id: 'rec-01',
        title: 'Front CV Joint & Control Arms',
        description: 'Replaced torn outer CV boot and lower control arm bushings.',
        date: DateTime(2026, 10, 24),
        mileageKm: 184250,
        partsCost: 45000,
        laborCost: 20000,
        totalCost: 65000,
        facilityName: 'Garage Pro Yerevan',
        category: ServiceCategory.suspension,
      ),
      ServiceRecordModel(
        id: 'rec-02',
        title: 'Brembo Front Brake Rotors & Pads',
        description: 'New ceramic pads & ventilated discs.',
        date: DateTime(2026, 8, 15),
        mileageKm: 180100,
        partsCost: 85000,
        laborCost: 15000,
        totalCost: 100000,
        facilityName: 'Master Auto',
        category: ServiceCategory.brakes,
      ),
      ServiceRecordModel(
        id: 'rec-03',
        title: 'Motul 8100 X-clean+ 5W30 & Mann Filter',
        description: 'Engine oil and OEM filter replacement.',
        date: DateTime(2026, 6, 10),
        mileageKm: 175000,
        partsCost: 35000,
        laborCost: 5000,
        totalCost: 40000,
        facilityName: 'Liqui Moly Service',
        category: ServiceCategory.oilFilter,
      ),
    ],
  );
}

VehiclePassportModel createSecondTestVehicle() {
  return const VehiclePassportModel(
    id: 'veh-bmw-02',
    make: 'BMW',
    model: '528i xDrive',
    year: 2015,
    vin: 'WBAXG5C54FD123456',
    fuelPowertrain: 'Petrol 2.0 Turbo',
    bodyType: 'Sedan',
    currentMileage: 142000,
    currency: Currency.amd,
  );
}

void main() {
  group('VehiclePassportModel & ServiceRecordModel JSON Serialization', () {
    test('ServiceRecordModel roundtrips correctly to and from JSON', () {
      final record = ServiceRecordModel(
        id: 'rec-test-01',
        title: 'New Spark Plugs & Ignition Coils',
        description: 'NGK laser iridium plugs installed.',
        date: DateTime(2026, 11, 1),
        mileageKm: 185000,
        totalCost: 35000,
        partsCost: 25000,
        laborCost: 10000,
        partsOemNumber: 'NGK-94122',
        facilityName: 'Bosch Service',
        facilityType: 'Independent Specialist',
        facilityLocation: 'Yerevan',
        category: ServiceCategory.engine,
        proofClassification: ProofClassification.formalStoreReceipt,
        proofBadges: const ['Store Invoice OCR'],
        isVerified: true,
        verificationNotes: 'Official receipt verified',
      );

      final json = record.toJson();
      final fromJson = ServiceRecordModel.fromJson(json);

      expect(fromJson.id, record.id);
      expect(fromJson.title, record.title);
      expect(fromJson.totalCost, 35000);
      expect(fromJson.partsCost, 25000);
      expect(fromJson.laborCost, 10000);
      expect(fromJson.category, ServiceCategory.engine);
      expect(fromJson.proofClassification, ProofClassification.formalStoreReceipt);
      expect(fromJson.proofBadges, ['Store Invoice OCR']);
      expect(fromJson.isVerified, isTrue);
    });

    test('VehiclePassportModel roundtrips correctly to and from JSON', () {
      final car = createTestVehicle();
      final json = car.toJson();
      final fromJson = VehiclePassportModel.fromJson(json);

      expect(fromJson.id, car.id);
      expect(fromJson.make, car.make);
      expect(fromJson.model, car.model);
      expect(fromJson.year, car.year);
      expect(fromJson.vin, car.vin);
      expect(fromJson.serviceRecords.length, car.serviceRecords.length);
      expect(fromJson.fullName, 'VW Touareg 3.0 TDI');
      expect(fromJson.formattedTotalSpent, '֏ 205,000');
    });
  });

  group('VehicleRepository Tests (Clean Empty State & Local DB Operations)', () {
    late VehicleRepository repository;

    setUp(() {
      repository = VehicleRepository();
    });

    test('Clean initial state starts with empty vehicles list and null active vehicle', () {
      expect(repository.vehicles.isEmpty, isTrue);
      expect(repository.hasVehicles, isFalse);
      expect(repository.activeVehicle, isNull);
      expect(repository.activeVehicleId, isNull);
      expect(repository.totalVehiclesCount, 0);
    });

    test('Adding a new vehicle updates the repository and selects it', () {
      const newCar = VehiclePassportModel(
        id: 'veh-mercedes-03',
        make: 'Mercedes-Benz',
        model: 'E 350',
        year: 2018,
        vin: 'WDB2120561A123456',
        fuelPowertrain: 'Petrol',
        bodyType: 'Sedan',
        currentMileage: 95000,
        currency: Currency.amd,
      );

      repository.addVehicle(newCar);
      expect(repository.vehicles.length, 1);
      expect(repository.hasVehicles, isTrue);
      expect(repository.activeVehicleId, 'veh-mercedes-03');
      expect(repository.activeVehicle?.fullName, 'Mercedes-Benz E 350');
    });

    test('User vehicle registration populates garage with correct data', () async {
      repository.addVehicle(createTestVehicle());
      repository.addVehicle(createSecondTestVehicle());
      repository.setActiveVehicle('veh-01');
      expect(repository.vehicles.length, 2);

      final active = repository.activeVehicle;
      expect(active, isNotNull);
      expect(active!.fullName, 'VW Touareg 3.0 TDI');
      expect(active.currentMileage, 184250);
      expect(active.serviceRecords.length, 3);
      expect(active.formattedTotalSpent, '֏ 205,000');
    });

    test('clearAll wipes vehicles and resets activeVehicle', () async {
      repository.addVehicle(createTestVehicle());
      expect(repository.hasVehicles, isTrue);

      await repository.clearAll();
      expect(repository.vehicles.isEmpty, isTrue);
      expect(repository.activeVehicle, isNull);
      expect(repository.activeVehicleId, isNull);
    });

    test('deleteVehicle removes vehicle and switches active selection to remaining car', () {
      repository.addVehicle(createTestVehicle());
      repository.addVehicle(createSecondTestVehicle());
      expect(repository.vehicles.length, 2);
      expect(repository.activeVehicleId, 'veh-bmw-02');

      repository.deleteVehicle('veh-bmw-02');
      expect(repository.vehicles.length, 1);
      expect(repository.activeVehicleId, 'veh-01');
      expect(repository.activeVehicle?.fullName, 'VW Touareg 3.0 TDI');

      repository.deleteVehicle('veh-01');
      expect(repository.vehicles.isEmpty, isTrue);
      expect(repository.activeVehicle, isNull);
    });

    test('interacts with custom injected LocalDatabaseService instance', () async {
      final customDb = HiveLocalDatabaseService();
      final customRepo = VehicleRepository(databaseService: customDb);

      customRepo.addVehicle(createTestVehicle());
      final savedVehicles = await customDb.getAllVehicles();
      expect(savedVehicles.length, 1);
      expect(savedVehicles.first.fullName, 'VW Touareg 3.0 TDI');

      await customRepo.clearAll();
      final emptyVehicles = await customDb.getAllVehicles();
      expect(emptyVehicles.isEmpty, isTrue);
    });
  });

  group('ServiceRecordRepository Tests', () {
    late VehicleRepository vehicleRepo;
    late ServiceRecordRepository recordRepo;

    setUp(() async {
      vehicleRepo = VehicleRepository(initialVehicles: [createTestVehicle()]);
      recordRepo = ServiceRecordRepository(vehicleRepository: vehicleRepo);
    });

    test('Adding and deleting service records updates records count and total spent', () {
      final initialCount = vehicleRepo.activeVehicle!.serviceRecords.length;
      final initialSpent = vehicleRepo.activeVehicle!.totalSpent;

      final record = ServiceRecordModel(
        id: 'rec-test-01',
        title: 'New Spark Plugs & Ignition Coils',
        description: 'NGK laser iridium plugs installed.',
        date: DateTime(2026, 11, 1),
        mileageKm: 185000,
        totalCost: 35000,
        facilityName: 'Bosch Service',
        category: ServiceCategory.engine,
      );

      recordRepo.addRecord(vehicleRepo.activeVehicleId!, record);
      expect(vehicleRepo.activeVehicle!.serviceRecords.length, initialCount + 1);
      expect(vehicleRepo.activeVehicle!.totalSpent, initialSpent + 35000);

      recordRepo.deleteRecord(vehicleRepo.activeVehicleId!, 'rec-test-01');
      expect(vehicleRepo.activeVehicle!.serviceRecords.length, initialCount);
      expect(vehicleRepo.activeVehicle!.totalSpent, initialSpent);
    });

    test('filterRecords filters service entries accurately', () {
      final records = recordRepo.getRecordsForVehicle();
      expect(recordRepo.filterRecords(records, 'All').length, 3);
      expect(recordRepo.filterRecords(records, 'Suspension').length, 1);
      expect(recordRepo.filterRecords(records, 'Brakes').length, 1);
      expect(recordRepo.filterRecords(records, 'Oil & Filter').length, 1);
    });
  });

  group('SettingsRepository Tests', () {
    late SettingsRepository settingsRepo;

    setUp(() {
      settingsRepo = SettingsRepository();
    });

    test('Default values and setters update observable state', () {
      expect(settingsRepo.appLanguage, 'English');
      expect(settingsRepo.displayCurrency, Currency.amd);
      expect(settingsRepo.distanceUnit, DistanceUnit.km);

      settingsRepo.setAppLanguage('Հայերեն');
      expect(settingsRepo.appLanguage, 'Հայերեն');

      settingsRepo.setDisplayCurrency(Currency.usd);
      expect(settingsRepo.displayCurrency, Currency.usd);

      settingsRepo.setDistanceUnit(DistanceUnit.miles);
      expect(settingsRepo.distanceUnit, DistanceUnit.miles);

      settingsRepo.setNotificationsEnabled(false);
      expect(settingsRepo.notificationsEnabled, isFalse);

      settingsRepo.setCloudSynced(false);
      expect(settingsRepo.isCloudSynced, isFalse);
    });
  });

  group('GarageController Tests', () {
    late VehicleRepository repository;
    late GarageController controller;

    setUp(() {
      repository = VehicleRepository(initialVehicles: [createTestVehicle(), createSecondTestVehicle()]);
      controller = GarageController(repository: repository);
    });

    test('garageItems returns correct items with active status', () {
      expect(controller.garageItems.length, 2);
      expect(controller.garageItems.first.isActive, isTrue);
      expect(controller.garageItems[1].isActive, isFalse);

      controller.selectVehicle('veh-bmw-02');
      expect(controller.garageItems.first.isActive, isFalse);
      expect(controller.garageItems[1].isActive, isTrue);
    });

    test('deleteVehicle removes vehicle through GarageController', () {
      expect(controller.garageItems.length, 2);
      controller.deleteVehicle('veh-bmw-02');
      expect(controller.garageItems.length, 1);
      expect(controller.garageItems.first.fullName, 'VW Touareg 3.0 TDI');
    });
  });

  group('TimelineController Tests', () {
    late VehicleRepository vehicleRepo;
    late ServiceRecordRepository recordRepo;
    late TimelineController controller;

    setUp(() {
      vehicleRepo = VehicleRepository(initialVehicles: [createTestVehicle()]);
      recordRepo = ServiceRecordRepository(vehicleRepository: vehicleRepo);
      controller = TimelineController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: recordRepo,
      );
    });

    test('Category filtering filters timeline records accurately', () {
      controller.setCategoryFilter('All');
      expect(controller.timelineEntries.length, 3);

      controller.setCategoryFilter('Suspension');
      expect(controller.timelineEntries.length, 1);
      expect(controller.timelineEntries.first.record.title, contains('Front CV Joint'));

      controller.setCategoryFilter('Brakes');
      expect(controller.timelineEntries.length, 1);
      expect(controller.timelineEntries.first.record.title, contains('Brembo'));

      controller.setCategoryFilter('Oil & Filter');
      expect(controller.timelineEntries.length, 1);
      expect(controller.timelineEntries.first.record.title, contains('Motul'));
    });

    test('deleteRecord removes record from timeline', () {
      expect(controller.timelineEntries.length, 3);
      controller.deleteRecord('rec-01');
      expect(controller.timelineEntries.length, 2);
      expect(controller.timelineEntries.any((e) => e.id == 'rec-01'), isFalse);
    });

    test('deleteVehicle removes vehicle through TimelineController', () {
      expect(controller.hasActiveVehicle, isTrue);
      controller.deleteVehicle('veh-01');
      expect(controller.hasActiveVehicle, isFalse);
      expect(controller.activeVehicle, isNull);
    });
  });

  group('RecordDetailController Tests', () {
    late VehicleRepository vehicleRepo;
    late ServiceRecordRepository recordRepo;
    late RecordDetailController controller;

    setUp(() {
      vehicleRepo = VehicleRepository(initialVehicles: [createTestVehicle()]);
      recordRepo = ServiceRecordRepository(vehicleRepository: vehicleRepo);
      controller = RecordDetailController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: recordRepo,
      );
    });

    test('getRecordDetail retrieves correct breakdown and costs', () {
      final detail = controller.getRecordDetail('rec-01');
      expect(detail.record.title, contains('Front CV Joint'));
      expect(detail.partsCost, 45000);
      expect(detail.laborCost, 20000);
      expect(detail.formattedTotalCost, '֏ 65,000');
    });

    test('deleteRecord removes record from repository', () {
      final initialCount = vehicleRepo.activeVehicle!.serviceRecords.length;
      controller.deleteRecord('rec-01');
      expect(vehicleRepo.activeVehicle!.serviceRecords.length, initialCount - 1);
      expect(vehicleRepo.activeVehicle!.serviceRecords.any((r) => r.id == 'rec-01'), isFalse);
    });
  });

  group('AddVehicleController Tests', () {
    late VehicleRepository repository;
    late AddVehicleController controller;

    setUp(() {
      repository = VehicleRepository();
      controller = AddVehicleController(repository: repository);
    });

    test('Submit adds vehicle to repository', () {
      controller.setVin('WVWZZZ7PZCD123456');
      controller.setMake('Audi');
      controller.setModel('Q7 3.0 TDI');
      controller.setYear(2021);
      controller.setMileage(45000);

      final created = controller.submitVehicle();
      expect(created, isNotNull);
      expect(repository.vehicles.length, 1);
      expect(repository.activeVehicle?.fullName, 'Audi Q7 3.0 TDI');
    });
  });

  group('ManualEntryController Tests', () {
    late VehicleRepository vehicleRepo;
    late ServiceRecordRepository recordRepo;
    late ManualEntryController controller;

    setUp(() {
      vehicleRepo = VehicleRepository(initialVehicles: [createTestVehicle()]);
      recordRepo = ServiceRecordRepository(vehicleRepository: vehicleRepo);
      controller = ManualEntryController(
        serviceRecordRepository: recordRepo,
        vehicleRepository: vehicleRepo,
      );
    });

    test('Submit adds service record to active vehicle in repository', () {
      controller.setCategory(ServiceCategory.engine);
      final record = controller.saveRecord(
        title: 'New Battery Replacement',
        mechanicName: 'Varta Armenia',
        cost: 45000,
        odometer: 184300,
      );
      expect(record, isNotNull);
      expect(record.title, 'New Battery Replacement');
      expect(vehicleRepo.activeVehicle?.serviceRecords.first.title, 'New Battery Replacement');
    });
  });

  group('DossierController Tests', () {
    late VehicleRepository repository;
    late DossierController controller;

    setUp(() {
      repository = VehicleRepository(initialVehicles: [createTestVehicle(id: 'vw-07')]);
      controller = DossierController(repository: repository);
    });

    test('Dossier sections toggle and metrics format properly', () {
      expect(controller.includePartBoxPhotos, isTrue);
      controller.toggleIncludePartBoxPhotos(false);
      expect(controller.includePartBoxPhotos, isFalse);

      expect(controller.publicUrl, contains('autopassport.am/v/vw-17'));
    });
  });

  group('SettingsController Tests', () {
    late VehicleRepository vehicleRepo;
    late SettingsRepository settingsRepo;
    late SettingsController controller;

    setUp(() {
      vehicleRepo = VehicleRepository();
      settingsRepo = SettingsRepository();
      controller = SettingsController(
        settingsRepository: settingsRepo,
        vehicleRepository: vehicleRepo,
      );
    });

    test('Settings controller updates currency and toggles features', () {
      controller.setDisplayCurrency(Currency.rub);
      expect(controller.displayCurrency, Currency.rub);
      expect(settingsRepo.displayCurrency, Currency.rub);

      expect(controller.notificationsEnabled, isTrue);
      controller.toggleNotifications(false);
      expect(controller.notificationsEnabled, isFalse);
      expect(settingsRepo.notificationsEnabled, isFalse);
    });
  });

  group('ShellController Tests', () {
    late ShellController controller;

    setUp(() {
      controller = ShellController();
    });

    test('Shell navigation handles tabs and garage switcher state', () {
      expect(controller.currentIndex, 0);
      expect(controller.currentTab, ShellTab.timeline);
      expect(controller.showingGarage, isFalse);

      controller.openGarage();
      expect(controller.showingGarage, isTrue);

      controller.closeGarage();
      expect(controller.showingGarage, isFalse);

      controller.setIndex(2);
      expect(controller.currentIndex, 2);
      expect(controller.currentTab, ShellTab.dossier);
    });
  });

  group('IntakeController Tests', () {
    late VehicleRepository repository;
    late IntakeController controller;

    setUp(() {
      repository = VehicleRepository();
      controller = IntakeController(repository: repository);
    });

    test('Intake controller provides methods', () {
      expect(controller.intakeMethods.length, 4);
      expect(controller.intakeMethods.first.title, contains('Photo of Part'));
    });
  });

  group('GetIt Service Locator Tests', () {
    test('getIt resolves registered singletons properly', () {
      Locator.setup();

      expect(getIt<LocalDatabaseService>(), isNotNull);
      expect(getIt<VehicleRepository>(), isNotNull);
      expect(getIt<ServiceRecordRepository>(), isNotNull);
      expect(getIt<SettingsRepository>(), isNotNull);
      expect(getIt<TimelineController>(), isNotNull);
      expect(getIt<SettingsController>(), isNotNull);

      expect(identical(Locator.vehicleRepository, getIt<VehicleRepository>()), isTrue);
      expect(identical(Locator.settingsRepository, getIt<SettingsRepository>()), isTrue);
    });
  });
}
