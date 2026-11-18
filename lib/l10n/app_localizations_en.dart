// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AutoPassport';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get myVehicles => 'My Vehicles';

  @override
  String get addVehicle => 'Add Vehicle';

  @override
  String get vehicleDetails => 'Vehicle Details';

  @override
  String get digitalPassport => 'Digital Auto Passport';

  @override
  String get passportId => 'Passport ID';

  @override
  String get vin => 'VIN Number';

  @override
  String get make => 'Make';

  @override
  String get model => 'Model';

  @override
  String get year => 'Year';

  @override
  String get plateNumber => 'License Plate';

  @override
  String get mileage => 'Mileage';

  @override
  String get status => 'Status';

  @override
  String get verified => 'Verified';

  @override
  String get pending => 'Pending Verification';

  @override
  String get expired => 'Expired';

  @override
  String get valid => 'Valid';

  @override
  String get serviceHistory => 'Service History';

  @override
  String get addServiceRecord => 'Add Service Record';

  @override
  String get technicalInspection => 'Technical Inspection';

  @override
  String get insurance => 'Insurance Policy';

  @override
  String get ownerInformation => 'Owner Information';

  @override
  String get searchVehicles => 'Search vehicles by make, model or VIN...';

  @override
  String get noVehiclesFound => 'No vehicles registered yet';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get language => 'Language';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get confirm => 'Confirm';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get specifications => 'Specifications';

  @override
  String get fuelType => 'Fuel Type';

  @override
  String get transmission => 'Transmission';

  @override
  String get engineCapacity => 'Engine Capacity';

  @override
  String get color => 'Color';

  @override
  String get navTimeline => 'Timeline';

  @override
  String get navScan => 'Scan';

  @override
  String get navDossier => 'Dossier';

  @override
  String get navSettings => 'Settings';

  @override
  String garageCarsCount(int count) {
    return 'Garage ($count cars)';
  }

  @override
  String get proBadge => 'PRO';

  @override
  String trackedSummary(String mileage, String spent) {
    return '$mileage • $spent tracked';
  }

  @override
  String get carOptionsTooltip => 'Car options';

  @override
  String get removeCar => 'Remove Car';

  @override
  String get editCar => 'Edit Car';

  @override
  String filterAll(int count) {
    return 'All ($count)';
  }

  @override
  String get filterSuspension => 'Suspension';

  @override
  String get filterBrakes => 'Brakes';

  @override
  String get filterOilFilter => 'Oil & Filter';

  @override
  String get noServiceRecordsInCategory =>
      'No service records found in this category';

  @override
  String get deleteServiceRecordTitle => 'Delete Service Record';

  @override
  String deleteServiceRecordMessage(String title) {
    return 'Are you sure you want to delete \"$title\"? This action cannot be undone.';
  }

  @override
  String get serviceRecordDeletedToast =>
      '✓ Service record deleted successfully';

  @override
  String get logService => 'Log Service';

  @override
  String get removeCarDialogTitle => 'Remove Car from Garage';

  @override
  String removeCarDialogMessage(String vehicleName) {
    return 'Are you sure you want to remove \"$vehicleName\"? All logged service records and passport history for this vehicle will be deleted.';
  }

  @override
  String carRemovedFromGarageToast(String vehicleName) {
    return '✓ $vehicleName removed from garage';
  }

  @override
  String get editRecordTooltip => 'Edit record';

  @override
  String get deleteRecordTooltip => 'Delete record';

  @override
  String get viewBreakdown => 'View Breakdown';

  @override
  String get yourGarageIsEmpty => 'Your Garage is Empty';

  @override
  String get emptyGarageSubtitle =>
      'Register your first vehicle to generate its immutable digital passport and start logging service records.';

  @override
  String get registerFirstVehicle => 'Register First Vehicle';

  @override
  String get registerAnotherVehicle => 'Register Another Vehicle';

  @override
  String get registerCardSubtitle =>
      'Track DIY repairs, parts, and increase resale value';

  @override
  String myGarageTitle(int count) {
    return 'My Garage ($count)';
  }

  @override
  String get activeBadge => 'ACTIVE';

  @override
  String get selectButton => 'Select';

  @override
  String get removeCarTooltip => 'Remove car';

  @override
  String vinPrefix(String vin) {
    return 'VIN: $vin';
  }

  @override
  String get odometerLabel => 'Odometer';

  @override
  String get recordsLabel => 'Records';

  @override
  String verifiedCount(int count) {
    return '$count Verified';
  }

  @override
  String get totalSpentLabel => 'Total Spent';

  @override
  String get logServiceProofTitle => 'Log Service Proof';

  @override
  String get logServiceProofSubtitle =>
      'Choose how you want to document this repair:';

  @override
  String get intakeVoiceLogTitle => 'Voice Quick Log';

  @override
  String get intakeVoiceLogSubtitle =>
      'Speak repair details — auto-extracts service, cost & mileage';

  @override
  String get intakeVoiceLogBadge => 'Speech-to-Text';

  @override
  String get intakeManualEntryTitle => 'Manual Service Entry';

  @override
  String get intakeManualEntrySubtitle =>
      'Enter repair details, cost, mileage & attach photo or receipt proofs';

  @override
  String get voiceSheetSubtitle =>
      'Speak your repair details (service, mileage, cost & master)';

  @override
  String get initializingMicrophone => 'Initializing microphone...';

  @override
  String get listeningTapToStop => 'Listening... Tap to stop';

  @override
  String get tapToSpeakServiceDetails => 'Tap to speak service details';

  @override
  String get speechUnavailableMessage =>
      'Speech recognition is unavailable on this device. You can type or tap a sample phrase below.';

  @override
  String get microphoneAccessErrorMessage =>
      'Could not access microphone. Check microphone permissions or type below.';

  @override
  String microphonePausedMessage(String error) {
    return 'Microphone paused ($error). Tap mic to resume or type below.';
  }

  @override
  String get voiceTranscriptHint =>
      'e.g. \"Changed front brake pads at 185,000 km for 45,000 dram with Master Karen\"';

  @override
  String get autoParsedPreviewHeader => 'AUTO-PARSED SERVICE LOG PREVIEW';

  @override
  String get costLabel => 'Cost';

  @override
  String get workshopLabel => 'Workshop';

  @override
  String get editInForm => 'Edit in Form';

  @override
  String get confirmAndAddLog => 'Confirm & Add Log';

  @override
  String get serviceLogAddedTitle => 'Service Log Added to Timeline!';

  @override
  String get serviceLogAddedSubtitle =>
      'Your voice note was parsed and saved to your vehicle history:';

  @override
  String get newServiceRecordTitle => 'New Service Record';

  @override
  String get editServiceRecordTitle => 'Edit Service Record';

  @override
  String get proofVerificationClassification =>
      'Proof Verification Classification';

  @override
  String get informalMasterProof => 'Informal Master Proof';

  @override
  String get formalStoreReceipt => 'Formal Store Receipt';

  @override
  String get informalMasterDescription =>
      'Private Mechanic / Master Repair: Verified through part box photos, car on a lift, or mobile transfer screenshots.';

  @override
  String get formalStoreDescription =>
      'Official Service / Store Receipt: Verified through printed store invoices, OEM part numbers, or official service stamps.';

  @override
  String get serviceItemDescriptionLabel => 'Service Item / Description';

  @override
  String get serviceItemHint => 'e.g. Front CV Joint & Control Arms';

  @override
  String get serviceDescriptionRequiredError =>
      'Service description is required';

  @override
  String get oemPartOrInvoiceLabel =>
      'OEM Part # / Store Invoice No. (Optional)';

  @override
  String get oemPartOrInvoiceHint => 'e.g. OEM 31126794203 or INV-2048';

  @override
  String get repairMaintenanceCategoryLabel => 'Repair / Maintenance Category';

  @override
  String get serviceDateLabel => 'Service Date';

  @override
  String get odometerKmLabel => 'Odometer (km)';

  @override
  String get odometerRequiredError => 'Odometer is required';

  @override
  String get enterValidKmError => 'Enter valid km';

  @override
  String get partsCostLabel => 'Parts Cost';

  @override
  String get partsCostRequiredError => 'Parts cost is required';

  @override
  String get enterValidCostError => 'Enter valid cost';

  @override
  String get totalMustBeGreaterThanZeroError => 'Total must be > 0';

  @override
  String get laborCostLabel => 'Labor Cost';

  @override
  String get laborCostRequiredError => 'Labor cost is required';

  @override
  String get autoCalculatedTotalCost => 'Auto-Calculated Total Cost';

  @override
  String get serviceCenterStoreNameLabel => 'Service Center / Store Name';

  @override
  String get mechanicMasterNameLabel => 'Mechanic / Master Name';

  @override
  String get serviceCenterHint => 'e.g. Liqui Moly Center / Official Service';

  @override
  String get mechanicNameHint => 'e.g. Gago Varpet';

  @override
  String get serviceCenterRequiredError =>
      'Service center or store name is required';

  @override
  String get mechanicNameRequiredError => 'Mechanic / master name is required';

  @override
  String get proofAttachmentsLabel =>
      'Proof Attachments (Photos / Screenshots)';

  @override
  String get formalProofAttachmentsInfo =>
      'Upload photos of official store receipts, printed tax invoices, warranty cards, or oil change door stickers.';

  @override
  String get informalProofAttachmentsInfo =>
      'Upload photos of new part boxes or labels, the car on a service lift, or payment transfer screenshots (Idram, Telcell, bank app).';

  @override
  String get photoProofAttachedToast => 'Photo proof attached';

  @override
  String get addPhotoLabel => '+ Photo';

  @override
  String get updateServiceRecordButton => '✓ Update Service Record';

  @override
  String get saveToTimelineFeedButton => '✓ Save to Timeline Feed';

  @override
  String get serviceRecordUpdatedToast => '✓ Service record updated';

  @override
  String get serviceRecordSavedToast =>
      '✓ Service record saved to timeline feed';

  @override
  String get serviceBreakdownTitle => 'Service Breakdown';

  @override
  String get deleteRecordConfirmButton => 'Delete Record';

  @override
  String deleteRecordLongMessage(String title) {
    return 'Are you sure you want to delete \"$title\"? This action cannot be undone and will update your vehicle lifetime totals.';
  }

  @override
  String get officialStoreReceiptBadge => 'OFFICIAL STORE RECEIPT';

  @override
  String get photoVerifiedPartBadge => 'PHOTO-VERIFIED PART';

  @override
  String odometerValueBadge(String mileage) {
    return 'Odometer: $mileage km';
  }

  @override
  String get totalInvestment => 'Total Investment';

  @override
  String partsBreakdownLine(String title, String oem) {
    return 'Parts: $title ($oem)';
  }

  @override
  String laborBreakdownLine(String facility, String type) {
    return 'Labor: $facility ($type)';
  }

  @override
  String get serviceFacilityHeader => 'SERVICE FACILITY';

  @override
  String get dossierVerificationStatus => 'Dossier Verification Status';

  @override
  String get includedInResaleDossier => '✓ Included in Resale Dossier';

  @override
  String get includeInResaleDossier => 'Include in Resale Dossier';

  @override
  String get verifiedAndLinkedToDossierToast =>
      '✓ Verified and linked to public dossier certificate';

  @override
  String get excludedFromDossierToast =>
      'Excluded from public dossier certificate';

  @override
  String get cancelClose => '✕ Cancel';

  @override
  String get editVehicleTitle => 'Edit Vehicle';

  @override
  String get newVehicleSetupTitle => 'New Vehicle Setup';

  @override
  String vehicleAddedToGarageToast(String vehicleName) {
    return '✓ $vehicleName added to your Garage';
  }

  @override
  String vehicleUpdatedInGarageToast(String make) {
    return '✓ $make updated in your Garage';
  }

  @override
  String get cameraPermissionRequiredTitle => 'Camera Permission Required';

  @override
  String get cameraPermissionRequiredMessage =>
      'Camera access is needed to scan 17-character VIN plates and capture vehicle photos. Please enable Camera permission in Settings.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get scanVehicleVinTitle => 'Scan Vehicle VIN (OCR)';

  @override
  String get scanVehicleVinSubtitle =>
      'Point camera at windshield VIN plate, door jamb sticker, or registration card';

  @override
  String get scanVinWithCamera => 'Scan VIN with Camera';

  @override
  String get scanVinFromPhotoLibrary => 'Scan VIN from Photo Library';

  @override
  String vinDetectedToast(String vin) {
    return '✓ VIN detected: $vin';
  }

  @override
  String get noVinDetectedToast =>
      'No 17-character VIN detected. Try closer lighting or a clearer angle.';

  @override
  String get selectDetectedVinTitle => 'Select Detected VIN / Chassis Number';

  @override
  String get isoVinSubtitle => '17-Character ISO VIN';

  @override
  String chassisCodeSubtitle(int count) {
    return 'Chassis / Frame Code ($count chars)';
  }

  @override
  String vinAppliedToast(String vin) {
    return '✓ VIN applied: $vin';
  }

  @override
  String get vehiclePhotoSheetTitle => 'Vehicle Photo';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get removePhoto => 'Remove Photo';

  @override
  String get frontAnglePhotoCapturedToast => 'Front angle photo captured';

  @override
  String get frontAnglePhotoAttachedToast => 'Front angle photo attached';

  @override
  String get photoRemovedToast => 'Photo removed';

  @override
  String get vinChassisNumberLabel => 'VIN / Chassis Number';

  @override
  String get vinHint => 'e.g. WBA5A7C52FD129482';

  @override
  String get vinRequiredError => 'VIN / Chassis number is required';

  @override
  String get enterValidVinError => 'Enter a valid VIN / chassis number';

  @override
  String get scannedVinWarningInfo =>
      'Please double-check the scanned VIN characters carefully. Camera OCR may occasionally misread similar symbols (such as 0/O, 1/I, 5/S, or 8/B).';

  @override
  String get makeRequiredError => 'Make is required';

  @override
  String get modelRequiredError => 'Model is required';

  @override
  String get yearRequiredError => 'Year is required';

  @override
  String get enterValidYearError => 'Enter a valid year';

  @override
  String get fuelPowertrainLabel => 'Fuel / Powertrain';

  @override
  String get bodyTypeLabel => 'Body Type';

  @override
  String get currentMileageLabel => 'Current Mileage';

  @override
  String get mileageRequiredError => 'Mileage is required';

  @override
  String get enterValidMileageError => 'Enter a valid mileage';

  @override
  String get distanceUnitLabel => 'Distance Unit';

  @override
  String get kmUnit => 'km';

  @override
  String get milesUnit => 'miles';

  @override
  String get vehicleCostTrackingCurrency => 'Vehicle Cost Tracking Currency';

  @override
  String get vehiclePhotoOptionalLabel => 'Vehicle Photo (Optional)';

  @override
  String get frontAnglePhotoAttachedTapToChange =>
      'Front Angle Photo Attached ✓ (Tap to change)';

  @override
  String get addFrontAnglePhoto => 'Add Front / Angle Photo';

  @override
  String get stampedOnBuyerPdfCover =>
      'Will be stamped on the exported buyer PDF cover';

  @override
  String get saveAndOpenPassportTimeline => 'Save & Open Passport Timeline →';

  @override
  String get buyerResaleDossierTitle => 'Buyer Resale Dossier';

  @override
  String get readyBadge => 'READY';

  @override
  String get lifetimeVehiclePass => 'Lifetime Vehicle Pass';

  @override
  String get unlimitedPdfExports => 'Unlimited PDF exports for this car';

  @override
  String get downloadCertifiedPdfDossier => 'Download Certified PDF Dossier';

  @override
  String get certifiedPdfGeneratedToast =>
      '✓ Certified PDF Dossier generated and downloaded';

  @override
  String get publicBuyerLinkHeader => 'PUBLIC BUYER LINK';

  @override
  String get copyButton => 'Copy';

  @override
  String get linkCopiedToast => '✓ Link copied to clipboard';

  @override
  String get attachLinkHint =>
      'Attach link to Auto.am or list.am listing for instant buyer credibility.';

  @override
  String get officialVehicleHealthPassportHeader =>
      'OFFICIAL VEHICLE HEALTH PASSPORT';

  @override
  String verifiedEntriesBadge(int count) {
    return 'VERIFIED ($count ENTRIES)';
  }

  @override
  String vinAndMileageSummary(String vin, String mileage) {
    return 'VIN: $vin  •  Mileage: $mileage';
  }

  @override
  String get loggedFallbackBadge => 'Logged';

  @override
  String get includePartBoxPhotos => 'Include Part Box Photos';

  @override
  String get includeCostCurrencyTotals => 'Include Cost / Currency Totals';

  @override
  String get watermarkWithVin => 'Watermark with VIN';

  @override
  String get noVehicleSelectedTitle => 'No Vehicle Selected';

  @override
  String get noVehicleSelectedSubtitle =>
      'Add a car to your garage to generate a certified buyer dossier and shareable public link.';

  @override
  String get addVehicleToGarage => 'Add Vehicle to Garage';

  @override
  String get settingsAndPreferencesTitle => 'Settings & Preferences';

  @override
  String get planStatusHeader => 'PLAN STATUS';

  @override
  String get proLifetimeMember => 'Pro Lifetime Member';

  @override
  String get allVehiclesAndExportsUnlocked =>
      'All vehicles & PDF exports unlocked';

  @override
  String get appLanguageLabel => 'App Language (Լեզու)';

  @override
  String get defaultDisplayCurrencyLabel => 'Default Display Currency';

  @override
  String get distanceAndSpeedUnitLabel => 'Distance & Speed Unit';

  @override
  String get kilometersOption => 'Kilometers (km)';

  @override
  String get milesOption => 'Miles (mi)';

  @override
  String get cloudBackupLabel => 'Cloud Backup (Supabase)';

  @override
  String get syncedStatus => 'Synced';

  @override
  String get rawRecordsExportedToast => '✓ Raw records exported as JSON/CSV';

  @override
  String get exportRawRecordsLabel => 'Export Raw Records (JSON / CSV)';

  @override
  String get resetLocalDatabaseTitle => 'Reset Local Database';

  @override
  String get resetLocalDatabaseMessage =>
      'Are you sure you want to clear all data? All registered vehicles and service records will be erased.';

  @override
  String get resetAllConfirmButton => 'Reset All';

  @override
  String get localDatabaseClearedToast =>
      '✓ Local database cleared (Clean slate)';

  @override
  String get clearLocalStorageLabel => 'Clear Local Storage (Reset to Empty)';
}
