import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/repository/settings_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../../../core/services/dossier_pdf_service/dossier_pdf_service.dart';

part 'dossier_controller.g.dart';

// ignore: library_private_types_in_public_api
class DossierController = _DossierControllerBase with _$DossierController;

abstract class _DossierControllerBase with Store {
  final VehicleRepository _repository;
  final SettingsRepository _settingsRepository;
  final DossierPdfService _dossierPdfService;

  _DossierControllerBase({
    VehicleRepository? repository,
    SettingsRepository? settingsRepository,
    DossierPdfService? dossierPdfService,
  })  : _repository = repository ?? Locator.vehicleRepository,
        _settingsRepository = settingsRepository ?? Locator.settingsRepository,
        _dossierPdfService = dossierPdfService ?? Locator.dossierPdfService;

  DistanceUnit get distanceUnit => _settingsRepository.distanceUnit;

  Currency get displayCurrency => _settingsRepository.displayCurrency;

  @observable
  bool includePartBoxPhotos = true;

  @observable
  bool includeCostTotals = true;

  @observable
  bool watermarkWithVin = true;

  @observable
  bool isGeneratingPdf = false;

  @computed
  VehiclePassportModel? get activeVehicle => _repository.activeVehicle;

  @computed
  bool get hasActiveVehicle => activeVehicle != null;

  @computed
  String get publicUrl {
    final v = activeVehicle;
    if (v == null) return 'autopassport.am/v/dossier';
    final yearStr = v.year.toString();
    final yearSuffix = yearStr.length >= 2 ? yearStr.substring(yearStr.length - 2) : yearStr;
    return 'autopassport.am/v/${v.make.toLowerCase()}-$yearSuffix';
  }

  List<ServiceRecordModel> get includedRecords =>
      activeVehicle?.serviceRecords.where((r) => r.includeInDossier).toList() ??
      const [];

  String get pdfFilename {
    final v = activeVehicle;
    if (v == null) return 'AutoPassport_Dossier.pdf';
    final safeName = '${v.year}_${v.make}_${v.model}'
        .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    return 'AutoPassport_${safeName}_Dossier.pdf';
  }

  @action
  void toggleIncludePartBoxPhotos(bool? val) {
    includePartBoxPhotos = val ?? true;
  }

  @action
  void toggleIncludeCostTotals(bool? val) {
    includeCostTotals = val ?? true;
  }

  @action
  void toggleWatermarkWithVin(bool? val) {
    watermarkWithVin = val ?? true;
  }

  @action
  Future<Uint8List?> generateDossierPdfBytes() async {
    final vehicle = activeVehicle;
    if (vehicle == null) return null;

    isGeneratingPdf = true;
    try {
      return await _dossierPdfService.generateDossierPdf(
        vehicle: vehicle,
        options: DossierPdfOptions(
          includePartBoxPhotos: includePartBoxPhotos,
          includeCostTotals: includeCostTotals,
          watermarkWithVin: watermarkWithVin,
          displayCurrency: displayCurrency,
          distanceUnit: distanceUnit,
          publicUrl: publicUrl,
        ),
      );
    } finally {
      isGeneratingPdf = false;
    }
  }
}
