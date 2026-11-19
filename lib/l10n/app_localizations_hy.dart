// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get appTitle => 'AutoPassport';

  @override
  String get dashboard => 'Գլխավոր';

  @override
  String get myVehicles => 'Իմ մեքենաները';

  @override
  String get addVehicle => 'Ավելացնել մեքենա';

  @override
  String get vehicleDetails => 'Մեքենայի տվյալներ';

  @override
  String get digitalPassport => 'Թվային Ավտոանձնագիր';

  @override
  String get passportId => 'Անձնագրի ID';

  @override
  String get vin => 'VIN համար';

  @override
  String get make => 'Մակնիշ';

  @override
  String get model => 'Մոդել';

  @override
  String get year => 'Տարեթիվ';

  @override
  String get plateNumber => 'Պետհամարանիշ';

  @override
  String get mileage => 'Վազք';

  @override
  String get status => 'Կարգավիճակ';

  @override
  String get verified => 'Հաստատված է';

  @override
  String get pending => 'Սպասման մեջ է';

  @override
  String get expired => 'Ժամկետանց է';

  @override
  String get valid => 'Վավեր է';

  @override
  String get serviceHistory => 'Սպասարկման պատմություն';

  @override
  String get addServiceRecord => 'Ավելացնել սպասարկում';

  @override
  String get technicalInspection => 'Տեխզննում';

  @override
  String get insurance => 'ԱՊՊԱ / ԿԱՍԿՈ';

  @override
  String get ownerInformation => 'Սեփականատիրոջ տվյալներ';

  @override
  String get searchVehicles => 'Որոնել ըստ մակնիշի, մոդելի կամ VIN-ի...';

  @override
  String get noVehiclesFound => 'Գրանցված մեքենաներ չկան';

  @override
  String get themeMode => 'Թեմայի ռեժիմ';

  @override
  String get language => 'Լեզու';

  @override
  String get save => 'Պահպանել';

  @override
  String get cancel => 'Չեղարկել';

  @override
  String get delete => 'Ջնջել';

  @override
  String get edit => 'Խմբագրել';

  @override
  String get confirm => 'Հաստատել';

  @override
  String get done => 'Պատրաստ է';

  @override
  String get back => 'Հետ';

  @override
  String get specifications => 'Տեխնիկական բնութագիր';

  @override
  String get fuelType => 'Վառելիքի տեսակ';

  @override
  String get transmission => 'Փոխանցման տուփ';

  @override
  String get engineCapacity => 'Շարժիչի ծավալ';

  @override
  String get color => 'Գույն';

  @override
  String get navTimeline => 'Պատմություն';

  @override
  String get navScan => 'Սկան';

  @override
  String get navDossier => 'Դոսյե';

  @override
  String get navSettings => 'Կարգավորումներ';

  @override
  String garageCarsCount(int count) {
    return 'Ավտոտնակ ($count մեքենա)';
  }

  @override
  String get proBadge => 'PRO';

  @override
  String trackedSummary(String mileage, String spent) {
    return '$mileage • $spent հաշվառված';
  }

  @override
  String get carOptionsTooltip => 'Մեքենայի ընտրանքներ';

  @override
  String get removeCar => 'Հեռացնել մեքենան';

  @override
  String get editCar => 'Խմբագրել մեքենան';

  @override
  String filterAll(int count) {
    return 'Բոլորը ($count)';
  }

  @override
  String get filterSuspension => 'Կախոց';

  @override
  String get filterBrakes => 'Արգելակներ';

  @override
  String get filterOilFilter => 'Յուղ և Զտիչներ';

  @override
  String get noServiceRecordsInCategory =>
      'Այս բաժնում սպասարկման գրառումներ չկան';

  @override
  String get deleteServiceRecordTitle => 'Ջնջել սպասարկման գրառումը';

  @override
  String deleteServiceRecordMessage(String title) {
    return 'Վստա՞հ եք, որ ցանկանում եք ջնջել «$title» գրառումը։ Այս գործողությունը հնարավոր չէ հետարկել։';
  }

  @override
  String get serviceRecordDeletedToast =>
      '✓ Սպասարկման գրառումը հաջողությամբ ջնջվեց';

  @override
  String get logService => 'Գրանցել սպասարկում';

  @override
  String get removeCarDialogTitle => 'Հեռացնել մեքենան ավտոտնակից';

  @override
  String removeCarDialogMessage(String vehicleName) {
    return 'Վստա՞հ եք, որ ցանկանում եք հեռացնել «$vehicleName»-ը։ Այս մեքենայի բոլոր սպասարկման գրառումները կջնջվեն։';
  }

  @override
  String carRemovedFromGarageToast(String vehicleName) {
    return '✓ $vehicleName-ը հեռացվեց ավտոտնակից';
  }

  @override
  String get editRecordTooltip => 'Խմբագրել գրառումը';

  @override
  String get deleteRecordTooltip => 'Ջնջել գրառումը';

  @override
  String get viewBreakdown => 'Մանրամասներ';

  @override
  String get yourGarageIsEmpty => 'Ձեր ավտոտնակը դատարկ է';

  @override
  String get emptyGarageSubtitle =>
      'Գրանցեք ձեր առաջին մեքենան՝ թվային ավտոանձնագիր ստեղծելու և սպասարկման պատմությունը վարելու համար։';

  @override
  String get registerFirstVehicle => 'Գրանցել առաջին մեքենան';

  @override
  String get registerAnotherVehicle => 'Գրանցել մեկ այլ մեքենա';

  @override
  String get registerCardSubtitle =>
      'Գրանցեք վերանորոգումները, պահեստամասերը և բարձրացրեք վաճառքի արժեքը';

  @override
  String myGarageTitle(int count) {
    return 'Իմ Ավտոտնակը ($count)';
  }

  @override
  String get activeBadge => 'ԱԿՏԻՎ';

  @override
  String get selectButton => 'Ընտրել';

  @override
  String get removeCarTooltip => 'Հեռացնել մեքենան';

  @override
  String vinPrefix(String vin) {
    return 'VIN: $vin';
  }

  @override
  String get odometerLabel => 'Վազք';

  @override
  String get recordsLabel => 'Գրառումներ';

  @override
  String verifiedCount(int count) {
    return '$count Հաստատված';
  }

  @override
  String get totalSpentLabel => 'Ընդհանուր ծախս';

  @override
  String get logServiceProofTitle => 'Գրանցել սպասարկում';

  @override
  String get logServiceProofSubtitle => 'Ընտրեք սպասարկման գրանցման եղանակը՝';

  @override
  String get intakeVoiceLogTitle => 'Ձայնային արագ գրանցում';

  @override
  String get intakeVoiceLogSubtitle =>
      'Խոսեք վերանորոգման մասին — ավտոմատ կլրացվեն ծառայությունը, արժեքը և վազքը';

  @override
  String get intakeVoiceLogBadge => 'Ձայնից տեքստ';

  @override
  String get intakeManualEntryTitle => 'Ձեռքով գրանցում';

  @override
  String get intakeManualEntrySubtitle =>
      'Մուտքագրեք վերանորոգման տվյալները, արժեքը, վազքը և կցեք լուսանկարներ';

  @override
  String get voiceSheetSubtitle =>
      'Նկարագրեք վերանորոգումը (աշխատանք, վազք, արժեք և վարպետ)';

  @override
  String get initializingMicrophone => 'Միկրոֆոնի միացում...';

  @override
  String get listeningTapToStop => 'Լսում եմ... Սեղմեք կանգնեցնելու համար';

  @override
  String get tapToSpeakServiceDetails =>
      'Սեղմեք՝ սպասարկման տվյալները խոսելու համար';

  @override
  String get speechUnavailableMessage =>
      'Ձայնի ճանաչումը հասանելի չէ այս սարքում։ Կարող եք մուտքագրել տեքստը ստորև։';

  @override
  String get microphoneAccessErrorMessage =>
      'Չհաջողվեց միանալ միկրոֆոնին։ Ստուգեք թույլտվությունները կամ մուտքագրեք ստորև։';

  @override
  String microphonePausedMessage(String error) {
    return 'Միկրոֆոնը դադարեցված է ($error)։ Սեղմեք միկրոֆոնին կամ մուտքագրեք ստորև։';
  }

  @override
  String get voiceTranscriptHint =>
      'օր.՝ «Փոխեցի առջևի արգելակման կոճղակները 185,000 կմ-ին 45,000 դրամով վարպետ Կարենի մոտ»';

  @override
  String get autoParsedPreviewHeader => 'ԱՎՏՈՄԱՏ ՎԵՐԼՈՒԾՎԱԾ ԳՐԱՌՄԱՆ ՆԱԽԱԴԻՏՈՒՄ';

  @override
  String get costLabel => 'Արժեք';

  @override
  String get workshopLabel => 'Արհեստանոց';

  @override
  String get editInForm => 'Խմբագրել ձևում';

  @override
  String get confirmAndAddLog => 'Հաստատել և Ավելացնել';

  @override
  String get serviceLogAddedTitle => 'Գրառումն ավելացվեց պատմության մեջ!';

  @override
  String get serviceLogAddedSubtitle =>
      'Ձեր ձայնային նշումը վերլուծվեց և պահպանվեց մեքենայի պատմության մեջ՝';

  @override
  String get newServiceRecordTitle => 'Նոր սպասարկման գրառում';

  @override
  String get editServiceRecordTitle => 'Խմբագրել սպասարկման գրառումը';

  @override
  String get proofVerificationClassification => 'Ապացույցի հաստատման տեսակը';

  @override
  String get informalMasterProof => 'Վարպետի ապացույց';

  @override
  String get formalStoreReceipt => 'Պաշտոնական կտրոն';

  @override
  String get informalMasterDescription =>
      'Մասնավոր վարպետի վերանորոգում. հաստատվում է պահեստամասի տուփի, ամբարձիչի վրա մեքենայի կամ փոխանցման սքրինշոթի միջոցով։';

  @override
  String get formalStoreDescription =>
      'Պաշտոնական սերվիս կամ խանութ. հաստատվում է տպագիր հաշիվ-ապրանքագրով, OEM համարով կամ երաշխիքային կնիքով։';

  @override
  String get serviceItemDescriptionLabel =>
      'Կատարված աշխատանք / Նկարագրություն';

  @override
  String get serviceItemHint => 'օր.՝ Առջևի շարժաբեր և լծակներ';

  @override
  String get serviceDescriptionRequiredError =>
      'Աշխատանքի նկարագրությունը պարտադիր է';

  @override
  String get oemPartOrInvoiceLabel =>
      'OEM պահեստամասի # / Հաշիվ-ապրանքագրի № (Ոչ պարտադիր)';

  @override
  String get oemPartOrInvoiceHint => 'օր.՝ OEM 31126794203 կամ INV-2048';

  @override
  String get repairMaintenanceCategoryLabel => 'Սպասարկման կատեգորիա';

  @override
  String get serviceDateLabel => 'Ամսաթիվ';

  @override
  String get odometerKmLabel => 'Վազք (կմ)';

  @override
  String get odometerRequiredError => 'Վազքը պարտադիր է';

  @override
  String get enterValidKmError => 'Մուտքագրեք ճիշտ կմ';

  @override
  String get partsCostLabel => 'Պահեստամասերի արժեք';

  @override
  String get partsCostRequiredError => 'Պահեստամասերի արժեքը պարտադիր է';

  @override
  String get enterValidCostError => 'Մուտքագրեք ճիշտ գումար';

  @override
  String get totalMustBeGreaterThanZeroError => 'Ընդհանուրը պետք է լինի > 0';

  @override
  String get laborCostLabel => 'Աշխատանքի արժեք';

  @override
  String get laborCostRequiredError => 'Աշխատանքի արժեքը պարտադիր է';

  @override
  String get autoCalculatedTotalCost => 'Ավտոմատ հաշվարկված ընդհանուր արժեք';

  @override
  String get serviceCenterStoreNameLabel =>
      'Սերվիս կենտրոնի / Խանութի անվանում';

  @override
  String get mechanicMasterNameLabel => 'Վարպետի / Արհեստանոցի անուն';

  @override
  String get serviceCenterHint => 'օր.՝ Liqui Moly կենտրոն / Պաշտոնական սերվիս';

  @override
  String get mechanicNameHint => 'օր.՝ Գագո Վարպետ';

  @override
  String get serviceCenterRequiredError =>
      'Սերվիս կենտրոնի կամ խանութի անունը պարտադիր է';

  @override
  String get mechanicNameRequiredError => 'Վարպետի անունը պարտադիր է';

  @override
  String get proofAttachmentsLabel =>
      'Կցված ապացույցներ (Լուսանկարներ / Սքրինշոթեր)';

  @override
  String get formalProofAttachmentsInfo =>
      'Կցեք պաշտոնական խանութի կտրոնների, հաշիվ-ապրանքագրերի, երաշխիքային քարտերի կամ յուղի փոխման պիտակների լուսանկարներ։';

  @override
  String get informalProofAttachmentsInfo =>
      'Կցեք նոր պահեստամասի տուփի, ամբարձիչի վրա մեքենայի կամ վճարման սքրինշոթի (Idram, Telcell, բանկային հավելված) լուսանկարներ։';

  @override
  String get photoProofAttachedToast => 'Լուսանկարը կցվեց';

  @override
  String get addPhotoLabel => '+ Նկար';

  @override
  String get updateServiceRecordButton => '✓ Թարմացնել գրառումը';

  @override
  String get saveToTimelineFeedButton => '✓ Պահպանել պատմության մեջ';

  @override
  String get serviceRecordUpdatedToast => '✓ Սպասարկման գրառումը թարմացվեց';

  @override
  String get serviceRecordSavedToast => '✓ Սպասարկման գրառումը պահպանվեց';

  @override
  String get serviceBreakdownTitle => 'Սպասարկման մանրամասներ';

  @override
  String get deleteRecordConfirmButton => 'Ջնջել գրառումը';

  @override
  String deleteRecordLongMessage(String title) {
    return 'Վստա՞հ եք, որ ցանկանում եք ջնջել «$title»-ը։ Այս գործողությունը հնարավոր չէ հետարկել և կթարմացնի մեքենայի ընդհանուր ծախսերը։';
  }

  @override
  String get officialStoreReceiptBadge => 'ՊԱՇՏՈՆԱԿԱՆ ԿՏՐՈՆ';

  @override
  String get photoVerifiedPartBadge => 'ԼՈՒՍԱՆԿԱՐՈՎ ՀԱՍՏԱՏՎԱԾ';

  @override
  String odometerValueBadge(String mileage) {
    return 'Վազք՝ $mileage';
  }

  @override
  String get totalInvestment => 'Ընդհանուր ներդրում';

  @override
  String partsBreakdownLine(String title, String oem) {
    return 'Պահեստամասեր՝ $title ($oem)';
  }

  @override
  String laborBreakdownLine(String facility, String type) {
    return 'Աշխատանք՝ $facility ($type)';
  }

  @override
  String get serviceFacilityHeader => 'ՍՊԱՍԱՐԿՄԱՆ ՎԱՅՐ';

  @override
  String get dossierVerificationStatus => 'Դոսյեի հաստատման կարգավիճակ';

  @override
  String get includedInResaleDossier => '✓ Ներառված է վաճառքի դոսյեում';

  @override
  String get includeInResaleDossier => 'Ներառել վաճառքի դոսյեում';

  @override
  String get verifiedAndLinkedToDossierToast =>
      '✓ Հաստատված է և կցված հանրային դոսյեին';

  @override
  String get excludedFromDossierToast => 'Հանված է հանրային դոսյեից';

  @override
  String get cancelClose => '✕ Չեղարկել';

  @override
  String get editVehicleTitle => 'Խմբագրել մեքենան';

  @override
  String get newVehicleSetupTitle => 'Նոր մեքենայի գրանցում';

  @override
  String vehicleAddedToGarageToast(String vehicleName) {
    return '✓ $vehicleName-ը ավելացվեց ձեր ավտոտնակում';
  }

  @override
  String vehicleUpdatedInGarageToast(String make) {
    return '✓ $make-ը թարմացվեց ձեր ավտոտնակում';
  }

  @override
  String get cameraPermissionRequiredTitle =>
      'Պահանջվում է տեսախցիկի թույլտվություն';

  @override
  String get cameraPermissionRequiredMessage =>
      'Տեսախցիկի հասանելիությունն անհրաժեշտ է 17-նիշ VIN համարը սկանավորելու և մեքենայի լուսանկարներ անելու համար։ Միացրեք տեսախցիկի թույլտվությունը Կարգավորումներում։';

  @override
  String get openSettings => 'Բացել Կարգավորումները';

  @override
  String get scanVehicleVinTitle => 'Սկանավորել մեքենայի VIN-ը (OCR)';

  @override
  String get scanVehicleVinSubtitle =>
      'Ուղղեք տեսախցիկը դիմապակու VIN-ի, դռան պիտակի կամ տեխանձնագրի վրա';

  @override
  String get scanVinWithCamera => 'Սկանավորել VIN-ը տեսախցիկով';

  @override
  String get scanVinFromPhotoLibrary => 'Ընտրել լուսանկար պատկերասրահից';

  @override
  String vinDetectedToast(String vin) {
    return '✓ Հայտնաբերվեց VIN՝ $vin';
  }

  @override
  String get noVinDetectedToast =>
      '17-նիշ VIN չհայտնաբերվեց։ Փորձեք ավելի լավ լուսավորությամբ կամ մոտիկից։';

  @override
  String get selectDetectedVinTitle => 'Ընտրեք հայտնաբերված VIN / թափքի համարը';

  @override
  String get isoVinSubtitle => '17-նիշ ISO VIN';

  @override
  String chassisCodeSubtitle(int count) {
    return 'Թափքի կոդ ($count նիշ)';
  }

  @override
  String vinAppliedToast(String vin) {
    return '✓ VIN-ը կիրառվեց՝ $vin';
  }

  @override
  String get vehiclePhotoSheetTitle => 'Մեքենայի լուսանկար';

  @override
  String get takePhoto => 'Լուսանկարել';

  @override
  String get chooseFromGallery => 'Ընտրել պատկերասրահից';

  @override
  String get removePhoto => 'Հեռացնել լուսանկարը';

  @override
  String get frontAnglePhotoCapturedToast => 'Լուսանկարը պահպանվեց';

  @override
  String get frontAnglePhotoAttachedToast => 'Լուսանկարը կցվեց';

  @override
  String get photoRemovedToast => 'Լուսանկարը հեռացվեց';

  @override
  String get vinChassisNumberLabel => 'VIN / Թափքի համար';

  @override
  String get vinHint => 'օր.՝ WBA5A7C52FD129482';

  @override
  String get vinRequiredError => 'VIN / թափքի համարը պարտադիր է';

  @override
  String get enterValidVinError => 'Մուտքագրեք վավեր VIN / թափքի համար';

  @override
  String get scannedVinWarningInfo =>
      'Խնդրում ենք ուշադիր ստուգել սկանավորված VIN-ի նիշերը։ Տեսախցիկի OCR-ը երբեմն կարող է շփոթել նման նիշերը (օրինակ՝ 0/O, 1/I, 5/S կամ 8/B)։';

  @override
  String get makeRequiredError => 'Մակնիշը պարտադիր է';

  @override
  String get modelRequiredError => 'Մոդելը պարտադիր է';

  @override
  String get yearRequiredError => 'Տարեթիվը պարտադիր է';

  @override
  String get enterValidYearError => 'Մուտքագրեք վավեր տարեթիվ';

  @override
  String get fuelPowertrainLabel => 'Վառելիք / Շարժիչ';

  @override
  String get bodyTypeLabel => 'Թափքի տեսակ';

  @override
  String get currentMileageLabel => 'Ընթացիկ վազք';

  @override
  String get mileageRequiredError => 'Վազքը պարտադիր է';

  @override
  String get enterValidMileageError => 'Մուտքագրեք վավեր վազք';

  @override
  String get distanceUnitLabel => 'Չափման միավոր';

  @override
  String get kmUnit => 'կմ';

  @override
  String get milesUnit => 'մղոն';

  @override
  String get vehicleCostTrackingCurrency => 'Ծախսերի հաշվառման արժույթ';

  @override
  String get vehiclePhotoOptionalLabel => 'Մեքենայի լուսանկար (Ոչ պարտադիր)';

  @override
  String get frontAnglePhotoAttachedTapToChange =>
      'Լուսանկարը կցված է ✓ (Սեղմեք՝ փոխելու համար)';

  @override
  String get addFrontAnglePhoto => 'Ավելացնել մեքենայի լուսանկար';

  @override
  String get stampedOnBuyerPdfCover => 'Կտեղադրվի գնորդի PDF դոսյեի շապիկին';

  @override
  String get saveAndOpenPassportTimeline => 'Պահպանել և Բացել պատմությունը →';

  @override
  String get buyerResaleDossierTitle => 'Գնորդի Վաճառքի Դոսյե';

  @override
  String get readyBadge => 'ՊԱՏՐԱՍՏ Է';

  @override
  String get lifetimeVehiclePass => 'Մեքենայի Անժամկետ Փաթեթ';

  @override
  String get unlimitedPdfExports =>
      'Անսահմանափակ PDF արտահանում այս մեքենայի համար';

  @override
  String get downloadCertifiedPdfDossier => 'Ներբեռնել հավաստագրված PDF դոսյեն';

  @override
  String get certifiedPdfGeneratedToast =>
      '✓ Հավաստագրված PDF դոսյեն ստեղծվեց և ներբեռնվեց';

  @override
  String get publicBuyerLinkHeader => 'ՀԱՆՐԱՅԻՆ ՀՂՈՒՄ ԳՆՈՐԴԻ ՀԱՄԱՐ';

  @override
  String get copyButton => 'Պատճենել';

  @override
  String get linkCopiedToast => '✓ Հղումը պատճենվեց';

  @override
  String get attachLinkHint =>
      'Կցեք հղումը Auto.am կամ List.am հայտարարությանը՝ գնորդի վստահությունը բարձրացնելու համար։';

  @override
  String get officialVehicleHealthPassportHeader =>
      'ՄԵՔԵՆԱՅԻ ՊԱՇՏՈՆԱԿԱՆ ԱՆՁՆԱԳԻՐ';

  @override
  String verifiedEntriesBadge(int count) {
    return 'ՀԱՍՏԱՏՎԱԾ ($count ԳՐԱՌՈՒՄ)';
  }

  @override
  String vinAndMileageSummary(String vin, String mileage) {
    return 'VIN: $vin  •  Վազք՝ $mileage';
  }

  @override
  String get loggedFallbackBadge => 'Գրանցված';

  @override
  String get includePartBoxPhotos =>
      'Ներառել պահեստամասերի տուփերի լուսանկարները';

  @override
  String get includeCostCurrencyTotals =>
      'Ներառել ծախսերի ընդհանուր գումարները';

  @override
  String get watermarkWithVin => 'Ավելացնել VIN ջրանիշ (Watermark)';

  @override
  String get noVehicleSelectedTitle => 'Մեքենա ընտրված չէ';

  @override
  String get noVehicleSelectedSubtitle =>
      'Ավելացրեք մեքենա ձեր ավտոտնակում՝ հավաստագրված դոսյե և հանրային հղում ստանալու համար։';

  @override
  String get addVehicleToGarage => 'Ավելացնել մեքենա ավտոտնակում';

  @override
  String get settingsAndPreferencesTitle =>
      'Կարգավորումներ և Նախընտրություններ';

  @override
  String get planStatusHeader => 'ՓԱԹԵԹԻ ԿԱՐԳԱՎԻՃԱԿ';

  @override
  String get proLifetimeMember => 'Pro Անժամկետ Անդամ';

  @override
  String get allVehiclesAndExportsUnlocked =>
      'Բոլոր մեքենաները և PDF արտահանումները բաց են';

  @override
  String get appLanguageLabel => 'Հավելվածի լեզու (Language)';

  @override
  String get defaultDisplayCurrencyLabel => 'Հիմնական արժույթ';

  @override
  String get distanceAndSpeedUnitLabel => 'Հեռավորության չափման միավոր';

  @override
  String get kilometersOption => 'Կիլոմետր (կմ)';

  @override
  String get milesOption => 'Մղոն (mi)';

  @override
  String get cloudBackupLabel => 'Ամպային պահուստավորում (Supabase)';

  @override
  String get syncedStatus => 'Սինխրոնացված է';

  @override
  String get rawRecordsExportedToast =>
      '✓ Գրառումներն արտահանվեցին JSON/CSV ձևաչափով';

  @override
  String get exportRawRecordsLabel => 'Արտահանել գրառումները (JSON / CSV)';

  @override
  String get resetLocalDatabaseTitle => 'Մաքրել տեղային տվյալների բազան';

  @override
  String get resetLocalDatabaseMessage =>
      'Վստա՞հ եք, որ ցանկանում եք ջնջել բոլոր տվյալները։ Բոլոր գրանցված մեքենաները և սպասարկման գրառումները կջնջվեն։';

  @override
  String get resetAllConfirmButton => 'Ջնջել բոլորը';

  @override
  String get localDatabaseClearedToast => '✓ Տեղային տվյալների բազան մաքրվեց';

  @override
  String get clearLocalStorageLabel =>
      'Մաքրել տեղային հիշողությունը (Սկսել զրոյից)';

  @override
  String servicedAtSummary(String facility, String mileage) {
    return 'Սպասարկվել է՝ $facility ($mileage)։';
  }
}
