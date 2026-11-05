import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_passport/core/di/locator.dart';
import 'package:auto_passport/core/models/vehicle_model.dart';
import 'package:auto_passport/main.dart';

void main() {
  setUp(() {
    Locator.shellController.closeGarage();
    Locator.shellController.setIndex(0);
  });

  testWidgets('AutoPassport handles clean empty app state gracefully', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await Locator.vehicleRepository.clearAll();

    await tester.pumpWidget(const AutoPassportApp());
    await tester.pumpAndSettle();

    // Verify empty state is displayed properly without errors and without mock data button
    expect(find.text('Your Garage is Empty'), findsOneWidget);
    expect(find.text('Register First Vehicle'), findsOneWidget);
    expect(find.text('Load Sample Vehicle Dossier'), findsNothing);
    // Log Service button is hidden when there is no active vehicle
    expect(find.text('Log Service'), findsNothing);

    // Switch to Dossier tab
    await tester.tap(find.text('Dossier'));
    await tester.pumpAndSettle();

    // Verify Dossier empty state and that Download Dossier button is hidden
    expect(find.text('No Vehicle Selected'), findsOneWidget);
    expect(find.text('READY'), findsNothing);
    expect(find.text('Download Certified PDF Dossier'), findsNothing);
  });

  testWidgets('AutoPassport renders bottom navigation and navigates between tabs', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Populate with registered vehicles for tab navigation testing
    final touareg = VehiclePassportModel(
      id: 'veh-touareg-01',
      make: 'VW',
      model: 'Touareg 3.0 TDI',
      year: 2017,
      vin: 'WVWZZZ7PZHD012345',
      fuelPowertrain: 'Diesel 3.0 V6',
      bodyType: 'SUV',
      currentMileage: 184250,
      currency: Currency.amd,
      serviceRecords: [
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
      ],
    );
    const bmw = VehiclePassportModel(
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

    await Locator.vehicleRepository.clearAll();
    Locator.vehicleRepository.addVehicle(touareg);
    Locator.vehicleRepository.addVehicle(bmw);
    Locator.vehicleRepository.setActiveVehicle('veh-touareg-01');

    await tester.pumpWidget(const AutoPassportApp());
    await tester.pumpAndSettle();

    // Verify Screen 03 (TimelineFeed) is loaded by default
    expect(find.text('VW Touareg 3.0 TDI'), findsOneWidget);
    expect(find.text('PRO'), findsOneWidget);
    expect(find.text('Front CV Joint & Control Arms'), findsOneWidget);
    expect(find.text('Log Service'), findsOneWidget);

    // Verify Bottom Navigation items are present
    expect(find.text('Timeline'), findsOneWidget);
    expect(find.text('Scan'), findsOneWidget);
    expect(find.text('Dossier'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Tap on Dossier tab (Screen 07)
    await tester.tap(find.text('Dossier'));
    await tester.pumpAndSettle();

    expect(find.text('Buyer Resale Dossier'), findsOneWidget);
    expect(find.text('READY'), findsOneWidget);
    expect(find.text('PUBLIC BUYER LINK'), findsOneWidget);
    expect(find.text('Download Certified PDF Dossier'), findsOneWidget);

    // Tap on Settings tab (Screen 08)
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings & Preferences'), findsOneWidget);
    expect(find.text('Pro Lifetime Member'), findsOneWidget);
    expect(find.text('Cloud Backup (Supabase)'), findsOneWidget);

    // Return to Timeline tab (Screen 03)
    await tester.tap(find.text('Timeline'));
    await tester.pumpAndSettle();

    expect(find.text('VW Touareg 3.0 TDI'), findsOneWidget);

    // Tap on Garage Switcher to open Garage Manager (Screen 01)
    await tester.tap(find.textContaining('Garage ('));
    await tester.pumpAndSettle();

    expect(find.textContaining('My Garage ('), findsOneWidget);
    expect(find.text('BMW 528i xDrive'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Register Another Vehicle'), findsOneWidget);
  });

  testWidgets('Delete service record shows generic confirmation popup and deletes on confirm', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final vehicle = VehiclePassportModel(
      id: 'veh-test-del',
      make: 'VW',
      model: 'Touareg 3.0 TDI',
      year: 2017,
      vin: 'WVWZZZ7PZHD012345',
      fuelPowertrain: 'Diesel 3.0 V6',
      bodyType: 'SUV',
      currentMileage: 184250,
      currency: Currency.amd,
      serviceRecords: [
        ServiceRecordModel(
          id: 'rec-del-01',
          title: 'Transmission Fluid Flush',
          description: 'Replaced ATF fluid and filter.',
          date: DateTime(2026, 10, 24),
          mileageKm: 184250,
          partsCost: 50000,
          laborCost: 20000,
          totalCost: 70000,
          facilityName: 'Garage Pro Yerevan',
          category: ServiceCategory.transmission,
        ),
      ],
    );

    await Locator.vehicleRepository.clearAll();
    Locator.vehicleRepository.addVehicle(vehicle);
    Locator.vehicleRepository.setActiveVehicle('veh-test-del');

    await tester.pumpWidget(const AutoPassportApp());
    await tester.pumpAndSettle();

    // Verify record exists on timeline
    expect(find.text('Transmission Fluid Flush'), findsOneWidget);

    // Find and tap the trash icon button
    final deleteButton = find.byTooltip('Delete record');
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Verify generic confirmation popup dialog appears
    expect(find.text('Delete Service Record'), findsOneWidget);
    expect(find.text('Are you sure you want to delete "Transmission Fluid Flush"? This action cannot be undone.'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);

    // Tap Delete to confirm
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Record should be removed and success SnackBar shown
    expect(find.text('Transmission Fluid Flush'), findsNothing);
    expect(find.text('✓ Service record deleted successfully'), findsOneWidget);
  });

  testWidgets('Remove car in GarageManagerView displays confirmation popup and removes vehicle', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const touareg = VehiclePassportModel(
      id: 'veh-01',
      make: 'VW',
      model: 'Touareg 3.0 TDI',
      year: 2017,
      vin: 'WVWZZZ7PZHD012345',
      fuelPowertrain: 'Diesel 3.0 V6',
      bodyType: 'SUV',
      currentMileage: 184250,
      currency: Currency.amd,
    );
    const bmw = VehiclePassportModel(
      id: 'veh-02',
      make: 'BMW',
      model: '528i xDrive',
      year: 2015,
      vin: 'WBAXG5C54FD123456',
      fuelPowertrain: 'Petrol 2.0 Turbo',
      bodyType: 'Sedan',
      currentMileage: 142000,
      currency: Currency.amd,
    );

    await Locator.vehicleRepository.clearAll();
    Locator.vehicleRepository.addVehicle(touareg);
    Locator.vehicleRepository.addVehicle(bmw);
    Locator.vehicleRepository.setActiveVehicle('veh-01');

    await tester.pumpWidget(const AutoPassportApp());
    await tester.pumpAndSettle();

    // Open Garage
    await tester.tap(find.textContaining('Garage ('));
    await tester.pumpAndSettle();

    expect(find.text('BMW 528i xDrive'), findsOneWidget);
    expect(find.text('VW Touareg 3.0 TDI'), findsOneWidget);

    // Find remove car buttons
    final removeCarButtons = find.byTooltip('Remove car');
    expect(removeCarButtons, findsNWidgets(2));

    // Tap remove on the BMW
    await tester.tap(removeCarButtons.last);
    await tester.pumpAndSettle();

    // Verify confirmation popup appears
    expect(find.text('Remove Car from Garage'), findsOneWidget);
    expect(find.text('Are you sure you want to remove "BMW 528i xDrive"? All logged service records and passport history for this vehicle will be deleted.'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Remove Car'), findsOneWidget);

    // Tap Remove Car to confirm
    await tester.tap(find.text('Remove Car'));
    await tester.pumpAndSettle();

    // BMW should be removed from the garage list
    expect(find.text('BMW 528i xDrive'), findsNothing);
    expect(find.text('VW Touareg 3.0 TDI'), findsOneWidget);
    expect(find.text('✓ BMW 528i xDrive removed from garage'), findsOneWidget);
  });
}
