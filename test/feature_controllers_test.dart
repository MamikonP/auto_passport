import 'package:flutter_test/flutter_test.dart';
import 'package:auto_passport/core/controllers/billing_controller.dart';
import 'package:auto_passport/core/di/locator.dart';
import 'package:auto_passport/core/models/vehicle_model.dart';
import 'package:auto_passport/core/repository/service_record_repository.dart';
import 'package:auto_passport/core/repository/settings_repository.dart';
import 'package:auto_passport/core/repository/vehicle_repository.dart';
import 'package:auto_passport/core/services/billing_service/billing_service_imp.dart';
import 'package:auto_passport/core/services/dossier_pdf_service/dossier_pdf_service_imp.dart';
import 'package:auto_passport/core/services/hive_database/hive_local_database_service.dart';
import 'package:auto_passport/core/services/local_database_service.dart';
import 'package:auto_passport/core/services/vehicle_sync_codec.dart';
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
        partsCost: 40000,
        laborCost: 5000,
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
      expect(controller.intakeMethods.length, 2);
      expect(controller.intakeMethods.first.title, contains('Voice Quick Log'));
    });
  });

  group('Currency Conversion & Settings Display Currency Tests', () {
    test('converts user specified AMD amount to EUR and formats accordingly', () {
      final settingsRepo = SettingsRepository();
      final vehicleRepo = VehicleRepository();
      final serviceRecordRepo = ServiceRecordRepository(
        vehicleRepository: vehicleRepo,
      );
      final timelineController = TimelineController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: serviceRecordRepo,
        settingsRepository: settingsRepo,
      );
      final garageController = GarageController(
        repository: vehicleRepo,
        settingsRepository: settingsRepo,
      );
      final recordDetailController = RecordDetailController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: serviceRecordRepo,
        settingsRepository: settingsRepo,
      );

      final record100kAmd = ServiceRecordModel(
        id: 'rec-curr-1',
        title: 'Major Service',
        date: DateTime(2026, 11, 19),
        mileageKm: 120000,
        partsCost: 70000,
        laborCost: 30000,
        totalCost: 100000,
        currency: Currency.amd,
        facilityName: 'Yerevan Motors',
        category: ServiceCategory.engine,
      );

      final vehicle = VehiclePassportModel(
        id: 'veh-curr-1',
        make: 'Toyota',
        model: 'Camry',
        year: 2022,
        vin: '4T1BF1FK0CU123456',
        fuelPowertrain: 'Hybrid 2.5',
        bodyType: 'Sedan',
        currentMileage: 120000,
        currency: Currency.amd,
        isActive: true,
        serviceRecords: [record100kAmd],
      );

      vehicleRepo.addVehicle(vehicle);
      vehicleRepo.setActiveVehicle(vehicle.id);

      // Default display currency is AMD
      expect(settingsRepo.displayCurrency, Currency.amd);
      expect(timelineController.timelineEntries.first.formattedCost, '֏ 100,000');
      expect(garageController.garageItems.first.formattedTotalSpent, '֏ 100,000');
      expect(
        recordDetailController.getRecordDetail('rec-curr-1').formattedTotalCost,
        '֏ 100,000',
      );

      // Change Settings display currency to EUR (1 EUR = 425 AMD -> 100,000 AMD = 235.29 EUR)
      settingsRepo.setDisplayCurrency(Currency.eur);
      expect(timelineController.displayCurrency, Currency.eur);
      expect(timelineController.timelineEntries.first.formattedCost, '€ 235.29');
      expect(garageController.garageItems.first.formattedTotalSpent, '€ 235.29');

      final breakdownEur = recordDetailController.getRecordDetail('rec-curr-1');
      expect(breakdownEur.formattedTotalCost, '€ 235.29');
      expect(breakdownEur.formattedPartsCost, '€ 164.71');
      expect(breakdownEur.formattedLaborCost, '€ 70.59');

      // Change Settings display currency to USD (1 USD = 390 AMD -> 100,000 AMD = 256.41 USD)
      settingsRepo.setDisplayCurrency(Currency.usd);
      expect(timelineController.timelineEntries.first.formattedCost, '\$ 256.41');
      expect(garageController.garageItems.first.formattedTotalSpent, '\$ 256.41');

      // Change Settings display currency to RUB (1 RUB = 4.2 AMD -> 100,000 AMD = 23,810 RUB)
      settingsRepo.setDisplayCurrency(Currency.rub);
      expect(timelineController.timelineEntries.first.formattedCost, '₽ 23,810');
      expect(garageController.garageItems.first.formattedTotalSpent, '₽ 23,810');
    });

    test('converts user specified KM and Miles distances based on Settings distance unit', () {
      final settingsRepo = SettingsRepository();
      final vehicleRepo = VehicleRepository();
      final serviceRecordRepo = ServiceRecordRepository(
        vehicleRepository: vehicleRepo,
      );
      final timelineController = TimelineController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: serviceRecordRepo,
        settingsRepository: settingsRepo,
      );
      final garageController = GarageController(
        repository: vehicleRepo,
        settingsRepository: settingsRepo,
      );
      final recordDetailController = RecordDetailController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: serviceRecordRepo,
        settingsRepository: settingsRepo,
      );

      final recordKm = ServiceRecordModel(
        id: 'rec-dist-1',
        title: 'Brake Service',
        date: DateTime(2026, 11, 19),
        mileageKm: 100000,
        distanceUnit: DistanceUnit.km,
        partsCost: 50000,
        laborCost: 20000,
        totalCost: 70000,
        facilityName: 'AutoMaster',
        category: ServiceCategory.brakes,
      );

      final vehicle = VehiclePassportModel(
        id: 'veh-dist-1',
        make: 'BMW',
        model: 'X5',
        year: 2021,
        vin: '5UXCR6C09M9D12345',
        fuelPowertrain: 'Petrol 3.0',
        bodyType: 'SUV',
        currentMileage: 100000,
        distanceUnit: DistanceUnit.km,
        isActive: true,
        serviceRecords: [recordKm],
      );

      vehicleRepo.addVehicle(vehicle);
      vehicleRepo.setActiveVehicle(vehicle.id);

      // Default Settings unit is KM
      expect(settingsRepo.distanceUnit, DistanceUnit.km);
      expect(timelineController.timelineEntries.first.formattedMileage, '100,000 km');
      expect(garageController.garageItems.first.formattedMileage, '100,000 km');
      expect(
        recordDetailController.getRecordDetail('rec-dist-1').formattedMileage,
        '100,000 km',
      );

      // Switch Settings unit to Miles (100,000 km / 1.609344 = 62,137 miles)
      settingsRepo.setDistanceUnit(DistanceUnit.miles);
      expect(timelineController.distanceUnit, DistanceUnit.miles);
      expect(timelineController.timelineEntries.first.formattedMileage, '62,137 miles');
      expect(garageController.garageItems.first.formattedMileage, '62,137 miles');
      expect(
        recordDetailController.getRecordDetail('rec-dist-1').formattedMileage,
        '62,137 miles',
      );

      // Check Miles -> KM conversion (100,000 miles * 1.609344 = 160,934 km)
      expect(
        DistanceUnit.miles.convertToInt(100000, to: DistanceUnit.km),
        160934,
      );
      expect(
        DistanceUnit.km.format(
          DistanceUnit.miles.convertToInt(100000, to: DistanceUnit.km),
        ),
        '160,934 km',
      );
    });
  });

  group('Encrypted Vehicle Sync Export & Import Tests', () {
    test('encodes vehicles into opaque encrypted token and decodes back accurately', () {
      final v1 = createTestVehicle(id: 'veh-sync-1', make: 'Porsche', model: 'Cayenne');
      final v2 = createSecondTestVehicle();

      final encoded1 = VehicleSyncCodec.encode(
        vehicles: [v1, v2],
        activeVehicleId: v2.id,
      );
      final encoded2 = VehicleSyncCodec.encode(
        vehicles: [v1, v2],
        activeVehicleId: v2.id,
      );

      // Must start with APSYNC1: and not expose plaintext VIN/make/JSON
      expect(encoded1.startsWith('APSYNC1:'), isTrue);
      expect(encoded1.contains('Porsche'), isFalse);
      expect(encoded1.contains('Cayenne'), isFalse);
      expect(encoded1.contains('WBAXG5C54FD123456'), isFalse);
      expect(encoded1.contains('"vehicles"'), isFalse);

      // Randomized nonce produces different ciphertexts for identical payloads
      expect(encoded1, isNot(equals(encoded2)));

      final decoded = VehicleSyncCodec.decode(encoded1);
      expect(decoded.vehicles.length, 2);
      expect(decoded.activeVehicleId, v2.id);
      expect(decoded.vehicles.first.make, 'Porsche');
      expect(decoded.vehicles.first.serviceRecords.length, v1.serviceRecords.length);
      expect(decoded.vehicles.last.vin, v2.vin);
    });

    test('rejects tampered or malformed sync tokens', () {
      final v1 = createTestVehicle(id: 'veh-tamper-1');
      final encoded = VehicleSyncCodec.encode(vehicles: [v1]);

      // Flip a character in the middle of the payload
      final mid = encoded.length ~/ 2;
      final flippedChar = encoded[mid] == 'A' ? 'B' : 'A';
      final tampered =
          '${encoded.substring(0, mid)}$flippedChar${encoded.substring(mid + 1)}';

      expect(
        () => VehicleSyncCodec.decode(tampered),
        throwsA(isA<VehicleSyncException>()),
      );
      expect(
        () => VehicleSyncCodec.decode('not-a-valid-token'),
        throwsA(isA<VehicleSyncException>()),
      );
      expect(
        () => VehicleSyncCodec.decode('{"vehicles":[]}'),
        throwsA(isA<VehicleSyncException>()),
      );
    });

    test('SettingsController exports from device A and imports to device B (merge & replace)', () async {
      final vehicleRepoA = VehicleRepository();
      final settingsRepoA = SettingsRepository();
      final controllerA = SettingsController(
        settingsRepository: settingsRepoA,
        vehicleRepository: vehicleRepoA,
      );

      final v1 = createTestVehicle(id: 'veh-a-1', make: 'Audi', model: 'Q7');
      final v2 = createSecondTestVehicle();
      vehicleRepoA.addVehicle(v1);
      vehicleRepoA.addVehicle(v2);

      // Export from Device A
      final syncCode = controllerA.exportEncryptedVehicles();

      // Device B starts with one different vehicle
      final vehicleRepoB = VehicleRepository();
      final settingsRepoB = SettingsRepository();
      final controllerB = SettingsController(
        settingsRepository: settingsRepoB,
        vehicleRepository: vehicleRepoB,
      );
      final existingOnB = const VehiclePassportModel(
        id: 'veh-b-only',
        make: 'Lexus',
        model: 'RX 350',
        year: 2020,
        vin: '2T2HZMDA0LC999999',
        fuelPowertrain: 'Petrol 3.5 V6',
        bodyType: 'SUV',
        currentMileage: 85000,
      );
      vehicleRepoB.addVehicle(existingOnB);

      // Merge mode keeps Device B's vehicle and adds Device A's 2 vehicles
      final mergedCount = await controllerB.importEncryptedVehicles(
        syncCode,
        replaceExisting: false,
      );
      expect(mergedCount, 2);
      expect(vehicleRepoB.vehicles.length, 3);
      expect(vehicleRepoB.vehicles.any((v) => v.id == 'veh-b-only'), isTrue);
      expect(vehicleRepoB.vehicles.any((v) => v.make == 'Audi'), isTrue);

      // Replace mode replaces Device B's garage with only Device A's 2 vehicles
      final replacedCount = await controllerB.importEncryptedVehicles(
        syncCode,
        replaceExisting: true,
      );
      expect(replacedCount, 2);
      expect(vehicleRepoB.vehicles.length, 2);
      expect(vehicleRepoB.vehicles.any((v) => v.id == 'veh-b-only'), isFalse);
      expect(vehicleRepoB.vehicles.any((v) => v.make == 'Audi'), isTrue);
    });
  });

  group('Certified PDF Dossier Export Tests', () {
    test('generates valid PDF honoring includeInDossier and all dossier options', () async {
      final vehicleRepo = VehicleRepository();
      final serviceRecordRepo = ServiceRecordRepository(
        vehicleRepository: vehicleRepo,
      );
      final settingsRepo = SettingsRepository();
      final dossierController = DossierController(
        repository: vehicleRepo,
        settingsRepository: settingsRepo,
      );
      final detailController = RecordDetailController(
        vehicleRepository: vehicleRepo,
        serviceRecordRepository: serviceRecordRepo,
        settingsRepository: settingsRepo,
      );

      final vehicle = createTestVehicle(id: 'veh-pdf-1');
      vehicleRepo.addVehicle(vehicle);
      vehicleRepo.setActiveVehicle(vehicle.id);

      // Initially all 3 records are included in dossier
      expect(dossierController.includedRecords.length, 3);

      // Exclude rec-02 from resale dossier via RecordDetailController
      detailController.toggleIncludedInDossier(
        recordId: 'rec-02',
        vehicleId: vehicle.id,
      );
      expect(dossierController.includedRecords.length, 2);
      expect(
        dossierController.includedRecords.any((r) => r.id == 'rec-02'),
        isFalse,
      );

      // Generate PDF with all options enabled
      final fullPdf = await dossierController.generateDossierPdfBytes();
      expect(fullPdf, isNotNull);
      expect(fullPdf!.length, greaterThan(1000));
      // Verify PDF magic header "%PDF-"
      expect(String.fromCharCodes(fullPdf.take(5)), '%PDF-');

      // Generate PDF with cost totals, part box photos, and VIN watermark turned off
      dossierController.toggleIncludePartBoxPhotos(false);
      dossierController.toggleIncludeCostTotals(false);
      dossierController.toggleWatermarkWithVin(false);

      final minimalPdf = await dossierController.generateDossierPdfBytes();
      expect(minimalPdf, isNotNull);
      expect(String.fromCharCodes(minimalPdf!.take(5)), '%PDF-');
      expect(minimalPdf.length, lessThan(fullPdf.length));

      // Verify formatPdfCurrency formats ASCII currency codes cleanly
      final pdfService = DossierPdfServiceImp();
      expect(
        pdfService.formatPdfCurrency(100000, Currency.amd),
        'AMD 100,000',
      );
      expect(
        pdfService.formatPdfCurrency(235.294, Currency.eur),
        'EUR 235.29',
      );
    });
  });

  group('BillingController & MobX Dossier PDF Download Tests', () {
    test('one-time pass unlocks PDF only for the purchased car, Pro unlocks multi-car and all PDFs', () async {
      final db = HiveLocalDatabaseService();
      await db.init();
      final billingService = BillingServiceImp(
        databaseService: db,
        enableDevFallback: true,
      );
      final billingController = BillingController(
        billingService: billingService,
      );
      await billingController.init();
      addTearDown(billingController.dispose);
      addTearDown(billingService.dispose);

      final vehicleRepo = VehicleRepository(databaseService: db);
      final settingsRepo = SettingsRepository(databaseService: db);
      final dossierController = DossierController(
        repository: vehicleRepo,
        settingsRepository: settingsRepo,
        dossierPdfService: DossierPdfServiceImp(),
        billingController: billingController,
      );

      final car1 = createTestVehicle(id: 'car-1');
      final car2 = createSecondTestVehicle();
      vehicleRepo.addVehicle(car1);
      vehicleRepo.addVehicle(car2);
      vehicleRepo.setActiveVehicle(car1.id);

      // Free tier: 1 car allowed, 2nd car requires Pro subscription
      expect(billingController.canAddVehicle(0), isTrue);
      expect(billingController.canAddVehicle(1), isFalse);
      expect(billingController.isDossierUnlockedForVehicle(car1.id), isFalse);
      expect(billingController.isDossierUnlockedForVehicle(car2.id), isFalse);
      expect(dossierController.isDossierUnlockedForActiveVehicle, isFalse);

      // Downloading PDF before purchasing fails cleanly
      final blockedDownload = await dossierController.downloadDossierPdf(
        shareHandler: (_, _) async => true,
      );
      expect(blockedDownload, isFalse);

      // Buy one-time Lifetime Pass for car1 ONLY
      final boughtCar1 = await billingController.purchaseVehiclePass(car1.id);
      expect(boughtCar1, isTrue);
      expect(billingController.isDossierUnlockedForVehicle(car1.id), isTrue);
      expect(billingController.isDossierUnlockedForVehicle(car2.id), isFalse);
      expect(dossierController.isDossierUnlockedForActiveVehicle, isTrue);
      // Multi-car still requires Pro subscription
      expect(billingController.canAddVehicle(1), isFalse);

      // Downloading PDF for car1 now succeeds via MobX DossierController
      int sharedBytesLength = 0;
      final car1Download = await dossierController.downloadDossierPdf(
        shareHandler: (bytes, _) async {
          sharedBytesLength = bytes.length;
          return true;
        },
      );
      expect(car1Download, isTrue);
      expect(sharedBytesLength, greaterThan(1000));

      // Switch active car to car2 -> downloading PDF for car2 is still blocked
      vehicleRepo.setActiveVehicle(car2.id);
      expect(dossierController.isDossierUnlockedForActiveVehicle, isFalse);
      final car2Blocked = await dossierController.downloadDossierPdf(
        shareHandler: (_, _) async => true,
      );
      expect(car2Blocked, isFalse);

      // Subscribe to Pro -> unlocks multi-car garage AND all car dossiers
      final subscribed = await billingController.purchaseProSubscription(
        yearly: true,
      );
      expect(subscribed, isTrue);
      expect(billingController.isProSubscribed, isTrue);
      expect(billingController.canAddVehicle(1), isTrue);
      expect(billingController.canAddVehicle(5), isTrue);
      expect(dossierController.isDossierUnlockedForActiveVehicle, isTrue);
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
