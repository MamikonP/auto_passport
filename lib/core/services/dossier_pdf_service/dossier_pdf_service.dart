import 'dart:typed_data';

import '../../enums/currency.dart';
import '../../enums/distance_unit.dart';
import '../../models/vehicle_passport_model.dart';

class DossierPdfOptions {
  final bool includePartBoxPhotos;
  final bool includeCostTotals;
  final bool watermarkWithVin;
  final Currency displayCurrency;
  final DistanceUnit distanceUnit;
  final String publicUrl;

  const DossierPdfOptions({
    this.includePartBoxPhotos = true,
    this.includeCostTotals = true,
    this.watermarkWithVin = true,
    this.displayCurrency = Currency.amd,
    this.distanceUnit = DistanceUnit.km,
    this.publicUrl = 'autopassport.am/v/dossier',
  });
}

/// Service contract for generating certified Vehicle Health Dossier PDFs.
abstract interface class DossierPdfService {
  /// Generates the multi-page A4 PDF bytes for [vehicle] using [options].
  Future<Uint8List> generateDossierPdf({
    required VehiclePassportModel vehicle,
    required DossierPdfOptions options,
  });

  /// Formats monetary values using ASCII currency codes for PDF compatibility.
  String formatPdfCurrency(double amount, Currency currency);
}
