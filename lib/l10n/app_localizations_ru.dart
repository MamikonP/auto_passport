// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'AutoPassport';

  @override
  String get dashboard => 'Главная';

  @override
  String get myVehicles => 'Мои автомобили';

  @override
  String get addVehicle => 'Добавить автомобиль';

  @override
  String get vehicleDetails => 'Данные автомобиля';

  @override
  String get digitalPassport => 'Цифровой Автопаспорт';

  @override
  String get passportId => 'ID паспорта';

  @override
  String get vin => 'VIN номер';

  @override
  String get make => 'Марка';

  @override
  String get model => 'Модель';

  @override
  String get year => 'Год выпуска';

  @override
  String get plateNumber => 'Госномер';

  @override
  String get mileage => 'Пробег';

  @override
  String get status => 'Статус';

  @override
  String get verified => 'Подтверждено';

  @override
  String get pending => 'На проверке';

  @override
  String get expired => 'Истек';

  @override
  String get valid => 'Действителен';

  @override
  String get serviceHistory => 'История обслуживания';

  @override
  String get addServiceRecord => 'Добавить запись ТО';

  @override
  String get technicalInspection => 'Техосмотр';

  @override
  String get insurance => 'Страховой полис';

  @override
  String get ownerInformation => 'Данные владельца';

  @override
  String get searchVehicles => 'Поиск по марке, модели или VIN...';

  @override
  String get noVehiclesFound => 'Нет зарегистрированных автомобилей';

  @override
  String get themeMode => 'Тема оформления';

  @override
  String get language => 'Язык';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Изменить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get done => 'Готово';

  @override
  String get back => 'Назад';

  @override
  String get specifications => 'Характеристики';

  @override
  String get fuelType => 'Тип топлива';

  @override
  String get transmission => 'Трансмиссия';

  @override
  String get engineCapacity => 'Объем двигателя';

  @override
  String get color => 'Цвет';

  @override
  String get navTimeline => 'История';

  @override
  String get navScan => 'Скан';

  @override
  String get navDossier => 'Досье';

  @override
  String get navSettings => 'Настройки';

  @override
  String garageCarsCount(int count) {
    return 'Гараж ($count авто)';
  }

  @override
  String get proBadge => 'PRO';

  @override
  String trackedSummary(String mileage, String spent) {
    return '$mileage • $spent учтено';
  }

  @override
  String get carOptionsTooltip => 'Опции автомобиля';

  @override
  String get removeCar => 'Удалить авто';

  @override
  String get editCar => 'Изменить авто';

  @override
  String filterAll(int count) {
    return 'Все ($count)';
  }

  @override
  String get filterSuspension => 'Подвеска';

  @override
  String get filterBrakes => 'Тормоза';

  @override
  String get filterOilFilter => 'Масло и фильтры';

  @override
  String get noServiceRecordsInCategory =>
      'В этой категории нет записей обслуживания';

  @override
  String get deleteServiceRecordTitle => 'Удалить запись обслуживания';

  @override
  String deleteServiceRecordMessage(String title) {
    return 'Вы уверены, что хотите удалить «$title»? Это действие нельзя отменить.';
  }

  @override
  String get serviceRecordDeletedToast =>
      '✓ Запись обслуживания успешно удалена';

  @override
  String get logService => 'Записать ТО';

  @override
  String get removeCarDialogTitle => 'Удалить авто из гаража';

  @override
  String removeCarDialogMessage(String vehicleName) {
    return 'Вы уверены, что хотите удалить «$vehicleName»? Все записи обслуживания и история паспорта будут удалены.';
  }

  @override
  String carRemovedFromGarageToast(String vehicleName) {
    return '✓ $vehicleName удален из гаража';
  }

  @override
  String get editRecordTooltip => 'Изменить запись';

  @override
  String get deleteRecordTooltip => 'Удалить запись';

  @override
  String get viewBreakdown => 'Подробнее';

  @override
  String get yourGarageIsEmpty => 'Ваш гараж пуст';

  @override
  String get emptyGarageSubtitle =>
      'Зарегистрируйте первый автомобиль, чтобы создать цифровой автопаспорт и вести историю ТО.';

  @override
  String get registerFirstVehicle => 'Добавить первый автомобиль';

  @override
  String get registerAnotherVehicle => 'Добавить еще автомобиль';

  @override
  String get registerCardSubtitle =>
      'Фиксируйте ремонты, запчасти и повышайте стоимость при продаже';

  @override
  String myGarageTitle(int count) {
    return 'Мой Гараж ($count)';
  }

  @override
  String get activeBadge => 'АКТИВНЫЙ';

  @override
  String get selectButton => 'Выбрать';

  @override
  String get removeCarTooltip => 'Удалить авто';

  @override
  String vinPrefix(String vin) {
    return 'VIN: $vin';
  }

  @override
  String get odometerLabel => 'Пробег';

  @override
  String get recordsLabel => 'Записи';

  @override
  String verifiedCount(int count) {
    return '$count подтв.';
  }

  @override
  String get totalSpentLabel => 'Всего затрат';

  @override
  String get logServiceProofTitle => 'Записать обслуживание';

  @override
  String get logServiceProofSubtitle => 'Выберите способ фиксации ремонта:';

  @override
  String get intakeVoiceLogTitle => 'Голосовая запись';

  @override
  String get intakeVoiceLogSubtitle =>
      'Продиктуйте детали ремонта — авто-разбор работы, цены и пробега';

  @override
  String get intakeVoiceLogBadge => 'Голос в текст';

  @override
  String get intakeManualEntryTitle => 'Ручной ввод записи';

  @override
  String get intakeManualEntrySubtitle =>
      'Введите детали ремонта, стоимость, пробег и прикрепите фото или чеки';

  @override
  String get voiceSheetSubtitle =>
      'Опишите ремонт (работа, пробег, стоимость и мастер)';

  @override
  String get initializingMicrophone => 'Инициализация микрофона...';

  @override
  String get listeningTapToStop => 'Слушаю... Нажмите, чтобы остановить';

  @override
  String get tapToSpeakServiceDetails => 'Нажмите и продиктуйте детали ТО';

  @override
  String get speechUnavailableMessage =>
      'Распознавание речи недоступно на устройстве. Вы можете ввести текст ниже.';

  @override
  String get microphoneAccessErrorMessage =>
      'Нет доступа к микрофону. Проверьте разрешения или введите текст ниже.';

  @override
  String microphonePausedMessage(String error) {
    return 'Микрофон на паузе ($error). Нажмите на микрофон или введите текст ниже.';
  }

  @override
  String get voiceTranscriptHint =>
      'напр. «Поменял передние колодки на 185 000 км за 45 000 драм у мастера Карена»';

  @override
  String get autoParsedPreviewHeader => 'ПРЕДПРОСМОТР РАСПОЗНАННОЙ ЗАПИСИ';

  @override
  String get costLabel => 'Сумма';

  @override
  String get workshopLabel => 'Мастерская';

  @override
  String get editInForm => 'В форму';

  @override
  String get confirmAndAddLog => 'Подтвердить и добавить';

  @override
  String get serviceLogAddedTitle => 'Запись добавлена в историю!';

  @override
  String get serviceLogAddedSubtitle =>
      'Ваша голосовая заметка распознана и сохранена в истории автомобиля:';

  @override
  String get newServiceRecordTitle => 'Новая запись ТО';

  @override
  String get editServiceRecordTitle => 'Редактировать запись ТО';

  @override
  String get proofVerificationClassification =>
      'Тип подтверждения обслуживания';

  @override
  String get informalMasterProof => 'У частного мастера';

  @override
  String get formalStoreReceipt => 'Официальный чек';

  @override
  String get informalMasterDescription =>
      'Ремонт у частного мастера: подтверждается фото коробки запчасти, авто на подъемнике или скриншотом перевода.';

  @override
  String get formalStoreDescription =>
      'Официальный сервис или магазин: подтверждается печатным чеком, OEM-номером детали или гарантийным штампом.';

  @override
  String get serviceItemDescriptionLabel => 'Выполненная работа / Описание';

  @override
  String get serviceItemHint => 'напр. Передний ШРУС и рычаги';

  @override
  String get serviceDescriptionRequiredError => 'Укажите описание работы';

  @override
  String get oemPartOrInvoiceLabel =>
      'OEM номер детали / № накладной (необязательно)';

  @override
  String get oemPartOrInvoiceHint => 'напр. OEM 31126794203 или INV-2048';

  @override
  String get repairMaintenanceCategoryLabel => 'Категория ремонта / ТО';

  @override
  String get serviceDateLabel => 'Дата сервиса';

  @override
  String get odometerKmLabel => 'Пробег (км)';

  @override
  String get odometerRequiredError => 'Укажите пробег';

  @override
  String get enterValidKmError => 'Введите корректный пробег';

  @override
  String get partsCostLabel => 'Стоимость запчастей';

  @override
  String get partsCostRequiredError => 'Укажите стоимость запчастей';

  @override
  String get enterValidCostError => 'Введите корректную сумму';

  @override
  String get totalMustBeGreaterThanZeroError => 'Итог должен быть > 0';

  @override
  String get laborCostLabel => 'Стоимость работы';

  @override
  String get laborCostRequiredError => 'Укажите стоимость работы';

  @override
  String get autoCalculatedTotalCost => 'Автоматический расчет общей суммы';

  @override
  String get serviceCenterStoreNameLabel => 'Название сервиса / магазина';

  @override
  String get mechanicMasterNameLabel => 'Имя мастера / название бокса';

  @override
  String get serviceCenterHint =>
      'напр. Liqui Moly Center / Официальный сервис';

  @override
  String get mechanicNameHint => 'напр. Мастер Гаго';

  @override
  String get serviceCenterRequiredError =>
      'Укажите название сервиса или магазина';

  @override
  String get mechanicNameRequiredError => 'Укажите имя мастера';

  @override
  String get proofAttachmentsLabel => 'Подтверждающие фото / скриншоты';

  @override
  String get formalProofAttachmentsInfo =>
      'Загрузите фото кассовых чеков, товарных накладных, гарантийных талонов или сервисных бирок замены масла.';

  @override
  String get informalProofAttachmentsInfo =>
      'Загрузите фото коробок новых запчастей, автомобиля на подъемнике или скриншоты переводов (Idram, Telcell, банк).';

  @override
  String get photoProofAttachedToast => 'Фото-подтверждение прикреплено';

  @override
  String get addPhotoLabel => '+ Фото';

  @override
  String get updateServiceRecordButton => '✓ Обновить запись ТО';

  @override
  String get saveToTimelineFeedButton => '✓ Сохранить в историю';

  @override
  String get serviceRecordUpdatedToast => '✓ Запись обслуживания обновлена';

  @override
  String get serviceRecordSavedToast =>
      '✓ Запись сохранена в историю обслуживания';

  @override
  String get serviceBreakdownTitle => 'Детали обслуживания';

  @override
  String get deleteRecordConfirmButton => 'Удалить запись';

  @override
  String deleteRecordLongMessage(String title) {
    return 'Вы уверены, что хотите удалить «$title»? Это действие нельзя отменить, общие затраты по авто будут пересчитаны.';
  }

  @override
  String get officialStoreReceiptBadge => 'ОФИЦИАЛЬНЫЙ ЧЕК';

  @override
  String get photoVerifiedPartBadge => 'ФОТО-ПОДТВЕРЖДЕНИЕ';

  @override
  String odometerValueBadge(String mileage) {
    return 'Пробег: $mileage';
  }

  @override
  String get totalInvestment => 'Общая стоимость';

  @override
  String partsBreakdownLine(String title, String oem) {
    return 'Запчасти: $title ($oem)';
  }

  @override
  String laborBreakdownLine(String facility, String type) {
    return 'Работа: $facility ($type)';
  }

  @override
  String get serviceFacilityHeader => 'МЕСТО ОБСЛУЖИВАНИЯ';

  @override
  String get dossierVerificationStatus => 'Статус верификации в досье';

  @override
  String get includedInResaleDossier => '✓ Включено в досье для продажи';

  @override
  String get includeInResaleDossier => 'Включить в досье для продажи';

  @override
  String get verifiedAndLinkedToDossierToast =>
      '✓ Подтверждено и добавлено в публичное досье';

  @override
  String get excludedFromDossierToast => 'Исключено из публичного досье';

  @override
  String get cancelClose => '✕ Отмена';

  @override
  String get editVehicleTitle => 'Изменить автомобиль';

  @override
  String get newVehicleSetupTitle => 'Новый автомобиль';

  @override
  String vehicleAddedToGarageToast(String vehicleName) {
    return '✓ $vehicleName добавлен в ваш гараж';
  }

  @override
  String vehicleUpdatedInGarageToast(String make) {
    return '✓ $make обновлен в вашем гараже';
  }

  @override
  String get cameraPermissionRequiredTitle => 'Требуется доступ к камере';

  @override
  String get cameraPermissionRequiredMessage =>
      'Доступ к камере необходим для сканирования 17-значного VIN-кода и фотографирования автомобиля. Разрешите доступ в Настройках.';

  @override
  String get openSettings => 'Открыть Настройки';

  @override
  String get scanVehicleVinTitle => 'Сканировать VIN автомобиля (OCR)';

  @override
  String get scanVehicleVinSubtitle =>
      'Наведите камеру на VIN под лобовым стеклом, табличку на стойке двери или техпаспорт';

  @override
  String get scanVinWithCamera => 'Сканировать VIN камерой';

  @override
  String get scanVinFromPhotoLibrary => 'Выбрать фото из галереи';

  @override
  String vinDetectedToast(String vin) {
    return '✓ VIN распознан: $vin';
  }

  @override
  String get noVinDetectedToast =>
      '17-значный VIN не найден. Попробуйте при лучшем освещении или ближе.';

  @override
  String get selectDetectedVinTitle =>
      'Выберите распознанный VIN / номер кузова';

  @override
  String get isoVinSubtitle => '17-значный ISO VIN';

  @override
  String chassisCodeSubtitle(int count) {
    return 'Код кузова / рамы ($count симв.)';
  }

  @override
  String vinAppliedToast(String vin) {
    return '✓ VIN применен: $vin';
  }

  @override
  String get vehiclePhotoSheetTitle => 'Фото автомобиля';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get removePhoto => 'Удалить фото';

  @override
  String get frontAnglePhotoCapturedToast => 'Фото автомобиля сделано';

  @override
  String get frontAnglePhotoAttachedToast => 'Фото автомобиля прикреплено';

  @override
  String get photoRemovedToast => 'Фото удалено';

  @override
  String get vinChassisNumberLabel => 'VIN / Номер кузова';

  @override
  String get vinHint => 'напр. WBA5A7C52FD129482';

  @override
  String get vinRequiredError => 'Укажите VIN или номер кузова';

  @override
  String get enterValidVinError => 'Введите корректный VIN / номер кузова';

  @override
  String get scannedVinWarningInfo =>
      'Пожалуйста, внимательно проверьте распознанные символы VIN. Камера (OCR) иногда может путать похожие символы (например, 0/O, 1/I, 5/S или 8/B).';

  @override
  String get makeRequiredError => 'Укажите марку';

  @override
  String get modelRequiredError => 'Укажите модель';

  @override
  String get yearRequiredError => 'Укажите год выпуска';

  @override
  String get enterValidYearError => 'Введите корректный год';

  @override
  String get fuelPowertrainLabel => 'Топливо / Двигатель';

  @override
  String get bodyTypeLabel => 'Тип кузова';

  @override
  String get currentMileageLabel => 'Текущий пробег';

  @override
  String get mileageRequiredError => 'Укажите пробег';

  @override
  String get enterValidMileageError => 'Введите корректный пробег';

  @override
  String get distanceUnitLabel => 'Единица измерения';

  @override
  String get kmUnit => 'км';

  @override
  String get milesUnit => 'мили';

  @override
  String get vehicleCostTrackingCurrency => 'Валюта учета расходов';

  @override
  String get vehiclePhotoOptionalLabel => 'Фото автомобиля (необязательно)';

  @override
  String get frontAnglePhotoAttachedTapToChange =>
      'Фото прикреплено ✓ (Нажмите, чтобы изменить)';

  @override
  String get addFrontAnglePhoto => 'Добавить фото автомобиля';

  @override
  String get stampedOnBuyerPdfCover =>
      'Будет размещено на обложке PDF-досье для покупателя';

  @override
  String get saveAndOpenPassportTimeline => 'Сохранить и открыть историю →';

  @override
  String get buyerResaleDossierTitle => 'Досье для покупателя';

  @override
  String get readyBadge => 'ГОТОВО';

  @override
  String get lifetimeVehiclePass => 'Пожизненный паспорт авто';

  @override
  String get unlimitedPdfExports =>
      'Безлимитный экспорт PDF для этого автомобиля';

  @override
  String get downloadCertifiedPdfDossier =>
      'Скачать сертифицированное PDF-досье';

  @override
  String get certifiedPdfGeneratedToast =>
      '✓ Сертифицированное PDF-досье создано и скачано';

  @override
  String get publicBuyerLinkHeader => 'ПУБЛИЧНАЯ ССЫЛКА ДЛЯ ПОКУПАТЕЛЯ';

  @override
  String get copyButton => 'Копировать';

  @override
  String get linkCopiedToast => '✓ Ссылка скопирована в буфер обмена';

  @override
  String get attachLinkHint =>
      'Прикрепите ссылку к объявлению на Auto.am или List.am для мгновенного доверия покупателей.';

  @override
  String get officialVehicleHealthPassportHeader =>
      'ОФИЦИАЛЬНЫЙ ПАСПОРТ ОБСЛУЖИВАНИЯ АВТО';

  @override
  String verifiedEntriesBadge(int count) {
    return 'ПОДТВЕРЖДЕНО ($count ЗАПИСЕЙ)';
  }

  @override
  String vinAndMileageSummary(String vin, String mileage) {
    return 'VIN: $vin  •  Пробег: $mileage';
  }

  @override
  String get loggedFallbackBadge => 'Записано';

  @override
  String get includePartBoxPhotos => 'Включить фото коробок запчастей';

  @override
  String get includeCostCurrencyTotals => 'Включить суммы затрат и валюту';

  @override
  String get watermarkWithVin => 'Водяной знак с VIN-кодом';

  @override
  String get noVehicleSelectedTitle => 'Автомобиль не выбран';

  @override
  String get noVehicleSelectedSubtitle =>
      'Добавьте автомобиль в гараж, чтобы сформировать сертифицированное досье и публичную ссылку.';

  @override
  String get addVehicleToGarage => 'Добавить авто в гараж';

  @override
  String get settingsAndPreferencesTitle => 'Настройки и предпочтения';

  @override
  String get planStatusHeader => 'СТАТУС ТАРИФА';

  @override
  String get proLifetimeMember => 'Pro Пожизненный доступ';

  @override
  String get allVehiclesAndExportsUnlocked =>
      'Все авто и экспорт PDF разблокированы';

  @override
  String get appLanguageLabel => 'Язык приложения (Լեզու)';

  @override
  String get defaultDisplayCurrencyLabel => 'Валюта отображения по умолчанию';

  @override
  String get distanceAndSpeedUnitLabel => 'Единицы расстояния';

  @override
  String get kilometersOption => 'Километры (km)';

  @override
  String get milesOption => 'Мили (mi)';

  @override
  String get cloudBackupLabel => 'Облачный бэкап (Supabase)';

  @override
  String get syncedStatus => 'Синхронизировано';

  @override
  String get rawRecordsExportedToast => '✓ Записи экспортированы в JSON/CSV';

  @override
  String get exportRawRecordsLabel => 'Экспорт всех записей (JSON / CSV)';

  @override
  String get resetLocalDatabaseTitle => 'Сбросить локальную базу данных';

  @override
  String get resetLocalDatabaseMessage =>
      'Вы уверены, что хотите очистить все данные? Все автомобили и записи обслуживания будут удалены.';

  @override
  String get resetAllConfirmButton => 'Сбросить все';

  @override
  String get localDatabaseClearedToast => '✓ Локальная база данных очищена';

  @override
  String get clearLocalStorageLabel => 'Очистить хранилище (Сброс до пустого)';

  @override
  String servicedAtSummary(String facility, String mileage) {
    return 'Обслужено в $facility ($mileage).';
  }
}
