import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hy'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AutoPassport'**
  String get appTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get myVehicles;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// No description provided for @vehicleDetails.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Details'**
  String get vehicleDetails;

  /// No description provided for @digitalPassport.
  ///
  /// In en, this message translates to:
  /// **'Digital Auto Passport'**
  String get digitalPassport;

  /// No description provided for @passportId.
  ///
  /// In en, this message translates to:
  /// **'Passport ID'**
  String get passportId;

  /// No description provided for @vin.
  ///
  /// In en, this message translates to:
  /// **'VIN Number'**
  String get vin;

  /// No description provided for @make.
  ///
  /// In en, this message translates to:
  /// **'Make'**
  String get make;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get plateNumber;

  /// No description provided for @mileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get mileage;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending Verification'**
  String get pending;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @valid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get valid;

  /// No description provided for @serviceHistory.
  ///
  /// In en, this message translates to:
  /// **'Service History'**
  String get serviceHistory;

  /// No description provided for @addServiceRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Service Record'**
  String get addServiceRecord;

  /// No description provided for @technicalInspection.
  ///
  /// In en, this message translates to:
  /// **'Technical Inspection'**
  String get technicalInspection;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance Policy'**
  String get insurance;

  /// No description provided for @ownerInformation.
  ///
  /// In en, this message translates to:
  /// **'Owner Information'**
  String get ownerInformation;

  /// No description provided for @searchVehicles.
  ///
  /// In en, this message translates to:
  /// **'Search vehicles by make, model or VIN...'**
  String get searchVehicles;

  /// No description provided for @noVehiclesFound.
  ///
  /// In en, this message translates to:
  /// **'No vehicles registered yet'**
  String get noVehiclesFound;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @specifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specifications;

  /// No description provided for @fuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get fuelType;

  /// No description provided for @transmission.
  ///
  /// In en, this message translates to:
  /// **'Transmission'**
  String get transmission;

  /// No description provided for @engineCapacity.
  ///
  /// In en, this message translates to:
  /// **'Engine Capacity'**
  String get engineCapacity;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @navTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get navTimeline;

  /// No description provided for @navScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get navScan;

  /// No description provided for @navDossier.
  ///
  /// In en, this message translates to:
  /// **'Dossier'**
  String get navDossier;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @garageCarsCount.
  ///
  /// In en, this message translates to:
  /// **'Garage ({count} cars)'**
  String garageCarsCount(int count);

  /// No description provided for @proBadge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get proBadge;

  /// No description provided for @trackedSummary.
  ///
  /// In en, this message translates to:
  /// **'{mileage} • {spent} tracked'**
  String trackedSummary(String mileage, String spent);

  /// No description provided for @carOptionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Car options'**
  String get carOptionsTooltip;

  /// No description provided for @removeCar.
  ///
  /// In en, this message translates to:
  /// **'Remove Car'**
  String get removeCar;

  /// No description provided for @editCar.
  ///
  /// In en, this message translates to:
  /// **'Edit Car'**
  String get editCar;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All ({count})'**
  String filterAll(int count);

  /// No description provided for @filterSuspension.
  ///
  /// In en, this message translates to:
  /// **'Suspension'**
  String get filterSuspension;

  /// No description provided for @filterBrakes.
  ///
  /// In en, this message translates to:
  /// **'Brakes'**
  String get filterBrakes;

  /// No description provided for @filterOilFilter.
  ///
  /// In en, this message translates to:
  /// **'Oil & Filter'**
  String get filterOilFilter;

  /// No description provided for @noServiceRecordsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No service records found in this category'**
  String get noServiceRecordsInCategory;

  /// No description provided for @deleteServiceRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Service Record'**
  String get deleteServiceRecordTitle;

  /// No description provided for @deleteServiceRecordMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? This action cannot be undone.'**
  String deleteServiceRecordMessage(String title);

  /// No description provided for @serviceRecordDeletedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Service record deleted successfully'**
  String get serviceRecordDeletedToast;

  /// No description provided for @logService.
  ///
  /// In en, this message translates to:
  /// **'Log Service'**
  String get logService;

  /// No description provided for @removeCarDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Car from Garage'**
  String get removeCarDialogTitle;

  /// No description provided for @removeCarDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove \"{vehicleName}\"? All logged service records and passport history for this vehicle will be deleted.'**
  String removeCarDialogMessage(String vehicleName);

  /// No description provided for @carRemovedFromGarageToast.
  ///
  /// In en, this message translates to:
  /// **'✓ {vehicleName} removed from garage'**
  String carRemovedFromGarageToast(String vehicleName);

  /// No description provided for @editRecordTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit record'**
  String get editRecordTooltip;

  /// No description provided for @deleteRecordTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete record'**
  String get deleteRecordTooltip;

  /// No description provided for @viewBreakdown.
  ///
  /// In en, this message translates to:
  /// **'View Breakdown'**
  String get viewBreakdown;

  /// No description provided for @yourGarageIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your Garage is Empty'**
  String get yourGarageIsEmpty;

  /// No description provided for @emptyGarageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Register your first vehicle to generate its immutable digital passport and start logging service records.'**
  String get emptyGarageSubtitle;

  /// No description provided for @registerFirstVehicle.
  ///
  /// In en, this message translates to:
  /// **'Register First Vehicle'**
  String get registerFirstVehicle;

  /// No description provided for @registerAnotherVehicle.
  ///
  /// In en, this message translates to:
  /// **'Register Another Vehicle'**
  String get registerAnotherVehicle;

  /// No description provided for @registerCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track DIY repairs, parts, and increase resale value'**
  String get registerCardSubtitle;

  /// No description provided for @myGarageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Garage ({count})'**
  String myGarageTitle(int count);

  /// No description provided for @activeBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get activeBadge;

  /// No description provided for @selectButton.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectButton;

  /// No description provided for @removeCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove car'**
  String get removeCarTooltip;

  /// No description provided for @vinPrefix.
  ///
  /// In en, this message translates to:
  /// **'VIN: {vin}'**
  String vinPrefix(String vin);

  /// No description provided for @odometerLabel.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get odometerLabel;

  /// No description provided for @recordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get recordsLabel;

  /// No description provided for @verifiedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Verified'**
  String verifiedCount(int count);

  /// No description provided for @totalSpentLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get totalSpentLabel;

  /// No description provided for @logServiceProofTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Service Proof'**
  String get logServiceProofTitle;

  /// No description provided for @logServiceProofSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to document this repair:'**
  String get logServiceProofSubtitle;

  /// No description provided for @intakeVoiceLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Voice Quick Log'**
  String get intakeVoiceLogTitle;

  /// No description provided for @intakeVoiceLogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speak repair details — auto-extracts service, cost & mileage'**
  String get intakeVoiceLogSubtitle;

  /// No description provided for @intakeVoiceLogBadge.
  ///
  /// In en, this message translates to:
  /// **'Speech-to-Text'**
  String get intakeVoiceLogBadge;

  /// No description provided for @intakeManualEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual Service Entry'**
  String get intakeManualEntryTitle;

  /// No description provided for @intakeManualEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter repair details, cost, mileage & attach photo or receipt proofs'**
  String get intakeManualEntrySubtitle;

  /// No description provided for @voiceSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speak your repair details (service, mileage, cost & master)'**
  String get voiceSheetSubtitle;

  /// No description provided for @initializingMicrophone.
  ///
  /// In en, this message translates to:
  /// **'Initializing microphone...'**
  String get initializingMicrophone;

  /// No description provided for @listeningTapToStop.
  ///
  /// In en, this message translates to:
  /// **'Listening... Tap to stop'**
  String get listeningTapToStop;

  /// No description provided for @tapToSpeakServiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap to speak service details'**
  String get tapToSpeakServiceDetails;

  /// No description provided for @speechUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition is unavailable on this device. You can type or tap a sample phrase below.'**
  String get speechUnavailableMessage;

  /// No description provided for @microphoneAccessErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not access microphone. Check microphone permissions or type below.'**
  String get microphoneAccessErrorMessage;

  /// No description provided for @microphonePausedMessage.
  ///
  /// In en, this message translates to:
  /// **'Microphone paused ({error}). Tap mic to resume or type below.'**
  String microphonePausedMessage(String error);

  /// No description provided for @voiceTranscriptHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. \"Changed front brake pads at 185,000 km for 45,000 dram with Master Karen\"'**
  String get voiceTranscriptHint;

  /// No description provided for @autoParsedPreviewHeader.
  ///
  /// In en, this message translates to:
  /// **'AUTO-PARSED SERVICE LOG PREVIEW'**
  String get autoParsedPreviewHeader;

  /// No description provided for @costLabel.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get costLabel;

  /// No description provided for @workshopLabel.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get workshopLabel;

  /// No description provided for @editInForm.
  ///
  /// In en, this message translates to:
  /// **'Edit in Form'**
  String get editInForm;

  /// No description provided for @confirmAndAddLog.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Add Log'**
  String get confirmAndAddLog;

  /// No description provided for @serviceLogAddedTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Log Added to Timeline!'**
  String get serviceLogAddedTitle;

  /// No description provided for @serviceLogAddedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your voice note was parsed and saved to your vehicle history:'**
  String get serviceLogAddedSubtitle;

  /// No description provided for @newServiceRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'New Service Record'**
  String get newServiceRecordTitle;

  /// No description provided for @editServiceRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Service Record'**
  String get editServiceRecordTitle;

  /// No description provided for @proofVerificationClassification.
  ///
  /// In en, this message translates to:
  /// **'Proof Verification Classification'**
  String get proofVerificationClassification;

  /// No description provided for @informalMasterProof.
  ///
  /// In en, this message translates to:
  /// **'Informal Master Proof'**
  String get informalMasterProof;

  /// No description provided for @formalStoreReceipt.
  ///
  /// In en, this message translates to:
  /// **'Formal Store Receipt'**
  String get formalStoreReceipt;

  /// No description provided for @informalMasterDescription.
  ///
  /// In en, this message translates to:
  /// **'Private Mechanic / Master Repair: Verified through part box photos, car on a lift, or mobile transfer screenshots.'**
  String get informalMasterDescription;

  /// No description provided for @formalStoreDescription.
  ///
  /// In en, this message translates to:
  /// **'Official Service / Store Receipt: Verified through printed store invoices, OEM part numbers, or official service stamps.'**
  String get formalStoreDescription;

  /// No description provided for @serviceItemDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Item / Description'**
  String get serviceItemDescriptionLabel;

  /// No description provided for @serviceItemHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Front CV Joint & Control Arms'**
  String get serviceItemHint;

  /// No description provided for @serviceDescriptionRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Service description is required'**
  String get serviceDescriptionRequiredError;

  /// No description provided for @oemPartOrInvoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'OEM Part # / Store Invoice No. (Optional)'**
  String get oemPartOrInvoiceLabel;

  /// No description provided for @oemPartOrInvoiceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. OEM 31126794203 or INV-2048'**
  String get oemPartOrInvoiceHint;

  /// No description provided for @repairMaintenanceCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Repair / Maintenance Category'**
  String get repairMaintenanceCategoryLabel;

  /// No description provided for @serviceDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Date'**
  String get serviceDateLabel;

  /// No description provided for @odometerKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Odometer (km)'**
  String get odometerKmLabel;

  /// No description provided for @odometerRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Odometer is required'**
  String get odometerRequiredError;

  /// No description provided for @enterValidKmError.
  ///
  /// In en, this message translates to:
  /// **'Enter valid km'**
  String get enterValidKmError;

  /// No description provided for @partsCostLabel.
  ///
  /// In en, this message translates to:
  /// **'Parts Cost'**
  String get partsCostLabel;

  /// No description provided for @partsCostRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Parts cost is required'**
  String get partsCostRequiredError;

  /// No description provided for @enterValidCostError.
  ///
  /// In en, this message translates to:
  /// **'Enter valid cost'**
  String get enterValidCostError;

  /// No description provided for @totalMustBeGreaterThanZeroError.
  ///
  /// In en, this message translates to:
  /// **'Total must be > 0'**
  String get totalMustBeGreaterThanZeroError;

  /// No description provided for @laborCostLabel.
  ///
  /// In en, this message translates to:
  /// **'Labor Cost'**
  String get laborCostLabel;

  /// No description provided for @laborCostRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Labor cost is required'**
  String get laborCostRequiredError;

  /// No description provided for @autoCalculatedTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Auto-Calculated Total Cost'**
  String get autoCalculatedTotalCost;

  /// No description provided for @serviceCenterStoreNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Center / Store Name'**
  String get serviceCenterStoreNameLabel;

  /// No description provided for @mechanicMasterNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Mechanic / Master Name'**
  String get mechanicMasterNameLabel;

  /// No description provided for @serviceCenterHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Liqui Moly Center / Official Service'**
  String get serviceCenterHint;

  /// No description provided for @mechanicNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Gago Varpet'**
  String get mechanicNameHint;

  /// No description provided for @serviceCenterRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Service center or store name is required'**
  String get serviceCenterRequiredError;

  /// No description provided for @mechanicNameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Mechanic / master name is required'**
  String get mechanicNameRequiredError;

  /// No description provided for @proofAttachmentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Proof Attachments (Photos / Screenshots)'**
  String get proofAttachmentsLabel;

  /// No description provided for @formalProofAttachmentsInfo.
  ///
  /// In en, this message translates to:
  /// **'Upload photos of official store receipts, printed tax invoices, warranty cards, or oil change door stickers.'**
  String get formalProofAttachmentsInfo;

  /// No description provided for @informalProofAttachmentsInfo.
  ///
  /// In en, this message translates to:
  /// **'Upload photos of new part boxes or labels, the car on a service lift, or payment transfer screenshots (Idram, Telcell, bank app).'**
  String get informalProofAttachmentsInfo;

  /// No description provided for @photoProofAttachedToast.
  ///
  /// In en, this message translates to:
  /// **'Photo proof attached'**
  String get photoProofAttachedToast;

  /// No description provided for @addPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'+ Photo'**
  String get addPhotoLabel;

  /// No description provided for @updateServiceRecordButton.
  ///
  /// In en, this message translates to:
  /// **'✓ Update Service Record'**
  String get updateServiceRecordButton;

  /// No description provided for @saveToTimelineFeedButton.
  ///
  /// In en, this message translates to:
  /// **'✓ Save to Timeline Feed'**
  String get saveToTimelineFeedButton;

  /// No description provided for @serviceRecordUpdatedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Service record updated'**
  String get serviceRecordUpdatedToast;

  /// No description provided for @serviceRecordSavedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Service record saved to timeline feed'**
  String get serviceRecordSavedToast;

  /// No description provided for @serviceBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Breakdown'**
  String get serviceBreakdownTitle;

  /// No description provided for @deleteRecordConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Record'**
  String get deleteRecordConfirmButton;

  /// No description provided for @deleteRecordLongMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? This action cannot be undone and will update your vehicle lifetime totals.'**
  String deleteRecordLongMessage(String title);

  /// No description provided for @officialStoreReceiptBadge.
  ///
  /// In en, this message translates to:
  /// **'OFFICIAL STORE RECEIPT'**
  String get officialStoreReceiptBadge;

  /// No description provided for @photoVerifiedPartBadge.
  ///
  /// In en, this message translates to:
  /// **'PHOTO-VERIFIED PART'**
  String get photoVerifiedPartBadge;

  /// No description provided for @odometerValueBadge.
  ///
  /// In en, this message translates to:
  /// **'Odometer: {mileage}'**
  String odometerValueBadge(String mileage);

  /// No description provided for @totalInvestment.
  ///
  /// In en, this message translates to:
  /// **'Total Investment'**
  String get totalInvestment;

  /// No description provided for @partsBreakdownLine.
  ///
  /// In en, this message translates to:
  /// **'Parts: {title} ({oem})'**
  String partsBreakdownLine(String title, String oem);

  /// No description provided for @laborBreakdownLine.
  ///
  /// In en, this message translates to:
  /// **'Labor: {facility} ({type})'**
  String laborBreakdownLine(String facility, String type);

  /// No description provided for @serviceFacilityHeader.
  ///
  /// In en, this message translates to:
  /// **'SERVICE FACILITY'**
  String get serviceFacilityHeader;

  /// No description provided for @dossierVerificationStatus.
  ///
  /// In en, this message translates to:
  /// **'Dossier Verification Status'**
  String get dossierVerificationStatus;

  /// No description provided for @includedInResaleDossier.
  ///
  /// In en, this message translates to:
  /// **'✓ Included in Resale Dossier'**
  String get includedInResaleDossier;

  /// No description provided for @includeInResaleDossier.
  ///
  /// In en, this message translates to:
  /// **'Include in Resale Dossier'**
  String get includeInResaleDossier;

  /// No description provided for @verifiedAndLinkedToDossierToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Verified and linked to public dossier certificate'**
  String get verifiedAndLinkedToDossierToast;

  /// No description provided for @excludedFromDossierToast.
  ///
  /// In en, this message translates to:
  /// **'Excluded from public dossier certificate'**
  String get excludedFromDossierToast;

  /// No description provided for @cancelClose.
  ///
  /// In en, this message translates to:
  /// **'✕ Cancel'**
  String get cancelClose;

  /// No description provided for @editVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Vehicle'**
  String get editVehicleTitle;

  /// No description provided for @newVehicleSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'New Vehicle Setup'**
  String get newVehicleSetupTitle;

  /// No description provided for @vehicleAddedToGarageToast.
  ///
  /// In en, this message translates to:
  /// **'✓ {vehicleName} added to your Garage'**
  String vehicleAddedToGarageToast(String vehicleName);

  /// No description provided for @vehicleUpdatedInGarageToast.
  ///
  /// In en, this message translates to:
  /// **'✓ {make} updated in your Garage'**
  String vehicleUpdatedInGarageToast(String make);

  /// No description provided for @cameraPermissionRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera Permission Required'**
  String get cameraPermissionRequiredTitle;

  /// No description provided for @cameraPermissionRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Camera access is needed to scan 17-character VIN plates and capture vehicle photos. Please enable Camera permission in Settings.'**
  String get cameraPermissionRequiredMessage;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @scanVehicleVinTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Vehicle VIN (OCR)'**
  String get scanVehicleVinTitle;

  /// No description provided for @scanVehicleVinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Point camera at windshield VIN plate, door jamb sticker, or registration card'**
  String get scanVehicleVinSubtitle;

  /// No description provided for @scanVinWithCamera.
  ///
  /// In en, this message translates to:
  /// **'Scan VIN with Camera'**
  String get scanVinWithCamera;

  /// No description provided for @scanVinFromPhotoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Scan VIN from Photo Library'**
  String get scanVinFromPhotoLibrary;

  /// No description provided for @vinDetectedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ VIN detected: {vin}'**
  String vinDetectedToast(String vin);

  /// No description provided for @noVinDetectedToast.
  ///
  /// In en, this message translates to:
  /// **'No 17-character VIN detected. Try closer lighting or a clearer angle.'**
  String get noVinDetectedToast;

  /// No description provided for @selectDetectedVinTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Detected VIN / Chassis Number'**
  String get selectDetectedVinTitle;

  /// No description provided for @isoVinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'17-Character ISO VIN'**
  String get isoVinSubtitle;

  /// No description provided for @chassisCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chassis / Frame Code ({count} chars)'**
  String chassisCodeSubtitle(int count);

  /// No description provided for @vinAppliedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ VIN applied: {vin}'**
  String vinAppliedToast(String vin);

  /// No description provided for @vehiclePhotoSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Photo'**
  String get vehiclePhotoSheetTitle;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get removePhoto;

  /// No description provided for @frontAnglePhotoCapturedToast.
  ///
  /// In en, this message translates to:
  /// **'Front angle photo captured'**
  String get frontAnglePhotoCapturedToast;

  /// No description provided for @frontAnglePhotoAttachedToast.
  ///
  /// In en, this message translates to:
  /// **'Front angle photo attached'**
  String get frontAnglePhotoAttachedToast;

  /// No description provided for @photoRemovedToast.
  ///
  /// In en, this message translates to:
  /// **'Photo removed'**
  String get photoRemovedToast;

  /// No description provided for @vinChassisNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'VIN / Chassis Number'**
  String get vinChassisNumberLabel;

  /// No description provided for @vinHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. WBA5A7C52FD129482'**
  String get vinHint;

  /// No description provided for @vinRequiredError.
  ///
  /// In en, this message translates to:
  /// **'VIN / Chassis number is required'**
  String get vinRequiredError;

  /// No description provided for @enterValidVinError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid VIN / chassis number'**
  String get enterValidVinError;

  /// No description provided for @scannedVinWarningInfo.
  ///
  /// In en, this message translates to:
  /// **'Please double-check the scanned VIN characters carefully. Camera OCR may occasionally misread similar symbols (such as 0/O, 1/I, 5/S, or 8/B).'**
  String get scannedVinWarningInfo;

  /// No description provided for @makeRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Make is required'**
  String get makeRequiredError;

  /// No description provided for @modelRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Model is required'**
  String get modelRequiredError;

  /// No description provided for @yearRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Year is required'**
  String get yearRequiredError;

  /// No description provided for @enterValidYearError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid year'**
  String get enterValidYearError;

  /// No description provided for @fuelPowertrainLabel.
  ///
  /// In en, this message translates to:
  /// **'Fuel / Powertrain'**
  String get fuelPowertrainLabel;

  /// No description provided for @bodyTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Body Type'**
  String get bodyTypeLabel;

  /// No description provided for @currentMileageLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Mileage'**
  String get currentMileageLabel;

  /// No description provided for @mileageRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Mileage is required'**
  String get mileageRequiredError;

  /// No description provided for @enterValidMileageError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mileage'**
  String get enterValidMileageError;

  /// No description provided for @distanceUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance Unit'**
  String get distanceUnitLabel;

  /// No description provided for @kmUnit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get kmUnit;

  /// No description provided for @milesUnit.
  ///
  /// In en, this message translates to:
  /// **'miles'**
  String get milesUnit;

  /// No description provided for @vehicleCostTrackingCurrency.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Cost Tracking Currency'**
  String get vehicleCostTrackingCurrency;

  /// No description provided for @vehiclePhotoOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Photo (Optional)'**
  String get vehiclePhotoOptionalLabel;

  /// No description provided for @frontAnglePhotoAttachedTapToChange.
  ///
  /// In en, this message translates to:
  /// **'Front Angle Photo Attached ✓ (Tap to change)'**
  String get frontAnglePhotoAttachedTapToChange;

  /// No description provided for @addFrontAnglePhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Front / Angle Photo'**
  String get addFrontAnglePhoto;

  /// No description provided for @stampedOnBuyerPdfCover.
  ///
  /// In en, this message translates to:
  /// **'Will be stamped on the exported buyer PDF cover'**
  String get stampedOnBuyerPdfCover;

  /// No description provided for @saveAndOpenPassportTimeline.
  ///
  /// In en, this message translates to:
  /// **'Save & Open Passport Timeline →'**
  String get saveAndOpenPassportTimeline;

  /// No description provided for @buyerResaleDossierTitle.
  ///
  /// In en, this message translates to:
  /// **'Buyer Resale Dossier'**
  String get buyerResaleDossierTitle;

  /// No description provided for @readyBadge.
  ///
  /// In en, this message translates to:
  /// **'READY'**
  String get readyBadge;

  /// No description provided for @lifetimeVehiclePass.
  ///
  /// In en, this message translates to:
  /// **'Lifetime Vehicle Pass'**
  String get lifetimeVehiclePass;

  /// No description provided for @unlimitedPdfExports.
  ///
  /// In en, this message translates to:
  /// **'Unlimited PDF exports for this car'**
  String get unlimitedPdfExports;

  /// No description provided for @downloadCertifiedPdfDossier.
  ///
  /// In en, this message translates to:
  /// **'Download Certified PDF Dossier'**
  String get downloadCertifiedPdfDossier;

  /// No description provided for @certifiedPdfGeneratedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Certified PDF Dossier generated and downloaded'**
  String get certifiedPdfGeneratedToast;

  /// No description provided for @publicBuyerLinkHeader.
  ///
  /// In en, this message translates to:
  /// **'PUBLIC BUYER LINK'**
  String get publicBuyerLinkHeader;

  /// No description provided for @copyButton.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyButton;

  /// No description provided for @linkCopiedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Link copied to clipboard'**
  String get linkCopiedToast;

  /// No description provided for @attachLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Attach link to Auto.am or list.am listing for instant buyer credibility.'**
  String get attachLinkHint;

  /// No description provided for @officialVehicleHealthPassportHeader.
  ///
  /// In en, this message translates to:
  /// **'OFFICIAL VEHICLE HEALTH PASSPORT'**
  String get officialVehicleHealthPassportHeader;

  /// No description provided for @verifiedEntriesBadge.
  ///
  /// In en, this message translates to:
  /// **'VERIFIED ({count} ENTRIES)'**
  String verifiedEntriesBadge(int count);

  /// No description provided for @vinAndMileageSummary.
  ///
  /// In en, this message translates to:
  /// **'VIN: {vin}  •  Mileage: {mileage}'**
  String vinAndMileageSummary(String vin, String mileage);

  /// No description provided for @loggedFallbackBadge.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get loggedFallbackBadge;

  /// No description provided for @includePartBoxPhotos.
  ///
  /// In en, this message translates to:
  /// **'Include Part Box Photos'**
  String get includePartBoxPhotos;

  /// No description provided for @includeCostCurrencyTotals.
  ///
  /// In en, this message translates to:
  /// **'Include Cost / Currency Totals'**
  String get includeCostCurrencyTotals;

  /// No description provided for @watermarkWithVin.
  ///
  /// In en, this message translates to:
  /// **'Watermark with VIN'**
  String get watermarkWithVin;

  /// No description provided for @noVehicleSelectedTitle.
  ///
  /// In en, this message translates to:
  /// **'No Vehicle Selected'**
  String get noVehicleSelectedTitle;

  /// No description provided for @noVehicleSelectedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a car to your garage to generate a certified buyer dossier and shareable public link.'**
  String get noVehicleSelectedSubtitle;

  /// No description provided for @addVehicleToGarage.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle to Garage'**
  String get addVehicleToGarage;

  /// No description provided for @settingsAndPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get settingsAndPreferencesTitle;

  /// No description provided for @planStatusHeader.
  ///
  /// In en, this message translates to:
  /// **'PLAN STATUS'**
  String get planStatusHeader;

  /// No description provided for @proLifetimeMember.
  ///
  /// In en, this message translates to:
  /// **'Pro Lifetime Member'**
  String get proLifetimeMember;

  /// No description provided for @allVehiclesAndExportsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'All vehicles & PDF exports unlocked'**
  String get allVehiclesAndExportsUnlocked;

  /// No description provided for @appLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'App Language (Լեզու)'**
  String get appLanguageLabel;

  /// No description provided for @defaultDisplayCurrencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Default Display Currency'**
  String get defaultDisplayCurrencyLabel;

  /// No description provided for @distanceAndSpeedUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance & Speed Unit'**
  String get distanceAndSpeedUnitLabel;

  /// No description provided for @kilometersOption.
  ///
  /// In en, this message translates to:
  /// **'Kilometers (km)'**
  String get kilometersOption;

  /// No description provided for @milesOption.
  ///
  /// In en, this message translates to:
  /// **'Miles (mi)'**
  String get milesOption;

  /// No description provided for @cloudBackupLabel.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup (Supabase)'**
  String get cloudBackupLabel;

  /// No description provided for @syncedStatus.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get syncedStatus;

  /// No description provided for @rawRecordsExportedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Raw records exported as JSON/CSV'**
  String get rawRecordsExportedToast;

  /// No description provided for @exportRawRecordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Export Raw Records (JSON / CSV)'**
  String get exportRawRecordsLabel;

  /// No description provided for @resetLocalDatabaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Local Database'**
  String get resetLocalDatabaseTitle;

  /// No description provided for @resetLocalDatabaseMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all data? All registered vehicles and service records will be erased.'**
  String get resetLocalDatabaseMessage;

  /// No description provided for @resetAllConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get resetAllConfirmButton;

  /// No description provided for @localDatabaseClearedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Local database cleared (Clean slate)'**
  String get localDatabaseClearedToast;

  /// No description provided for @clearLocalStorageLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear Local Storage (Reset to Empty)'**
  String get clearLocalStorageLabel;

  /// No description provided for @servicedAtSummary.
  ///
  /// In en, this message translates to:
  /// **'Serviced at {facility} ({mileage}).'**
  String servicedAtSummary(String facility, String mileage);

  /// No description provided for @exportEncryptedBackupLabel.
  ///
  /// In en, this message translates to:
  /// **'Export Encrypted Backup (Sync)'**
  String get exportEncryptedBackupLabel;

  /// No description provided for @importEncryptedBackupLabel.
  ///
  /// In en, this message translates to:
  /// **'Import Encrypted Backup'**
  String get importEncryptedBackupLabel;

  /// No description provided for @exportBackupSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Encrypted Sync Backup'**
  String get exportBackupSheetTitle;

  /// No description provided for @exportBackupSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All {vehiclesCount} vehicle(s) and {recordsCount} service record(s) are compressed and encrypted so they cannot be opened externally.'**
  String exportBackupSheetSubtitle(int vehiclesCount, int recordsCount);

  /// No description provided for @noVehiclesToExportToast.
  ///
  /// In en, this message translates to:
  /// **'No vehicles in your garage to export'**
  String get noVehiclesToExportToast;

  /// No description provided for @copySyncCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Copy Encrypted Sync Code'**
  String get copySyncCodeButton;

  /// No description provided for @syncCodeCopiedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Encrypted sync code copied to clipboard'**
  String get syncCodeCopiedToast;

  /// No description provided for @importBackupSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Encrypted Sync Backup'**
  String get importBackupSheetTitle;

  /// No description provided for @importBackupSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paste an encrypted AutoPassport sync code exported from another device.'**
  String get importBackupSheetSubtitle;

  /// No description provided for @pasteFromClipboardButton.
  ///
  /// In en, this message translates to:
  /// **'Paste from Clipboard'**
  String get pasteFromClipboardButton;

  /// No description provided for @syncCodeFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Paste APSYNC1:... code here'**
  String get syncCodeFieldHint;

  /// No description provided for @mergeWithGarageOption.
  ///
  /// In en, this message translates to:
  /// **'Merge with Garage'**
  String get mergeWithGarageOption;

  /// No description provided for @replaceGarageOption.
  ///
  /// In en, this message translates to:
  /// **'Replace All'**
  String get replaceGarageOption;

  /// No description provided for @importVehiclesButton.
  ///
  /// In en, this message translates to:
  /// **'Import Vehicles'**
  String get importVehiclesButton;

  /// No description provided for @vehiclesImportedToast.
  ///
  /// In en, this message translates to:
  /// **'✓ Imported {count} vehicle(s) successfully'**
  String vehiclesImportedToast(int count);

  /// No description provided for @invalidSyncCodeError.
  ///
  /// In en, this message translates to:
  /// **'Invalid or corrupted encrypted sync code'**
  String get invalidSyncCodeError;

  /// No description provided for @failedToExportPdfDossierToast.
  ///
  /// In en, this message translates to:
  /// **'Could not generate or share the PDF dossier. Please try again.'**
  String get failedToExportPdfDossierToast;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hy', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hy':
      return AppLocalizationsHy();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
