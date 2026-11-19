import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../enums/currency.dart';
import '../../enums/proof_classification.dart';
import '../../enums/service_category.dart';
import '../../models/service_record_model.dart';
import '../../models/vehicle_passport_model.dart';
import 'dossier_pdf_service.dart';

/// Default implementation of [DossierPdfService] generating a multi-page A4
/// Vehicle Health Dossier PDF honoring all owner customization flags and
/// per-record `includeInDossier` toggles.
class DossierPdfServiceImp implements DossierPdfService {
  static const PdfColor _navyDark = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor _navyMid = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor _primaryBlue = PdfColor.fromInt(0xFF2563EB);
  static const PdfColor _primaryLight = PdfColor.fromInt(0xFF60A5FA);
  static const PdfColor _verifiedGreen = PdfColor.fromInt(0xFF059669);
  static const PdfColor _verifiedBg = PdfColor.fromInt(0xFFECFDF5);
  static const PdfColor _amber = PdfColor.fromInt(0xFFD97706);
  static const PdfColor _amberBg = PdfColor.fromInt(0xFFFFFBEB);
  static const PdfColor _slate900 = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor _slate700 = PdfColor.fromInt(0xFF334155);
  static const PdfColor _slate500 = PdfColor.fromInt(0xFF64748B);
  static const PdfColor _slate200 = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor _slate100 = PdfColor.fromInt(0xFFF1F5F9);
  static const PdfColor _slate50 = PdfColor.fromInt(0xFFF8FAFC);

  @override
  Future<Uint8List> generateDossierPdf({
    required VehiclePassportModel vehicle,
    required DossierPdfOptions options,
  }) async {
    final doc = pw.Document(
      title: '${vehicle.year} ${vehicle.fullName} - AutoPassport Dossier',
      author: 'AutoPassport',
      subject: 'Certified Vehicle Maintenance & Resale Dossier',
    );

    final includedRecords =
        vehicle.serviceRecords.where((r) => r.includeInDossier).toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    pw.MemoryImage? vehiclePhoto;
    if (vehicle.photoUrl != null && vehicle.photoUrl!.isNotEmpty) {
      try {
        final file = File(vehicle.photoUrl!);
        if (await file.exists()) {
          final bytes = await file.readAsBytes();
          if (bytes.isNotEmpty) {
            vehiclePhoto = pw.MemoryImage(bytes);
          }
        }
      } catch (_) {
        vehiclePhoto = null;
      }
    }

    final now = DateTime.now();
    final issuedDate =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}';
    final certCode =
        'AP-${vehicle.vin.length >= 6 ? vehicle.vin.substring(vehicle.vin.length - 6).toUpperCase() : vehicle.id.toUpperCase()}-${now.year}';

    final totalInvestment = includedRecords.fold<double>(
      0.0,
      (sum, r) => sum + r.totalCostIn(options.displayCurrency),
    );
    final formalCount = includedRecords
        .where(
          (r) => r.proofClassification == ProofClassification.formalStoreReceipt,
        )
        .length;
    final informalCount = includedRecords.length - formalCount;

    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(30, 32, 30, 34),
      buildBackground: options.watermarkWithVin
          ? (context) => _buildVinWatermark(vehicle.vin)
          : null,
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        header: (context) => context.pageNumber == 1
            ? pw.SizedBox()
            : _buildRunningHeader(vehicle, certCode),
        footer: (context) => _buildPageFooter(
          context: context,
          vehicle: vehicle,
          publicUrl: options.publicUrl,
          certCode: certCode,
        ),
        build: (context) {
          final widgets = <pw.Widget>[
            _buildHeroBanner(
              vehicle: vehicle,
              vehiclePhoto: vehiclePhoto,
              issuedDate: issuedDate,
              certCode: certCode,
            ),
            pw.SizedBox(height: 16),
            _buildKpiStrip(
              vehicle: vehicle,
              includedRecordsCount: includedRecords.length,
              formalCount: formalCount,
              informalCount: informalCount,
              totalInvestment: totalInvestment,
              options: options,
            ),
          ];

          if (options.includeCostTotals && includedRecords.isNotEmpty) {
            widgets.addAll([
              pw.SizedBox(height: 16),
              _buildCategoryBreakdownSection(
                records: includedRecords,
                totalInvestment: totalInvestment,
                currency: options.displayCurrency,
              ),
            ]);
          }

          widgets.addAll([
            pw.SizedBox(height: 18),
            _buildSectionHeader(
              title: 'VERIFIED MAINTENANCE CHRONOLOGY',
              trailing:
                  '${includedRecords.length} ${includedRecords.length == 1 ? 'ENTRY' : 'ENTRIES'} INCLUDED',
            ),
            pw.SizedBox(height: 10),
          ]);

          if (includedRecords.isEmpty) {
            widgets.add(_buildEmptyRecordsNotice());
          } else {
            for (final record in includedRecords) {
              widgets.add(_buildRecordCard(record: record, options: options));
              widgets.add(pw.SizedBox(height: 10));
            }
          }

          widgets.addAll([
            pw.SizedBox(height: 8),
            _buildCertificationStamp(
              vehicle: vehicle,
              issuedDate: issuedDate,
              certCode: certCode,
              options: options,
            ),
          ]);

          return widgets;
        },
      ),
    );

    return doc.save();
  }

  @override
  String formatPdfCurrency(double amount, Currency currency) {
    final isWholeNumber = (amount - amount.roundToDouble()).abs() < 0.01;
    if (currency == Currency.amd || currency == Currency.rub || isWholeNumber) {
      final intVal = amount.round();
      final formattedInt = intVal.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
      return '${currency.code} $formattedInt';
    }
    final fixed = amount.toStringAsFixed(2);
    final parts = fixed.split('.');
    final formattedInt = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '${currency.code} $formattedInt.${parts[1]}';
  }

  pw.Widget _buildVinWatermark(String vin) {
    final text = 'VIN: ${vin.toUpperCase()}   |   AUTOPASSPORT CERTIFIED';
    return pw.FullPage(
      ignoreMargins: true,
      child: pw.Opacity(
        opacity: 0.055,
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (_) => pw.Transform.rotate(
              angle: -math.pi / 6,
              child: pw.Text(
                text,
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: _navyDark,
                  letterSpacing: 2.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  pw.Widget _buildRunningHeader(VehiclePassportModel vehicle, String certCode) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.only(bottom: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _slate200, width: 0.8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'AUTOPASSPORT  |  ${vehicle.year} ${vehicle.fullName.toUpperCase()}',
            style: pw.TextStyle(
              fontSize: 8.5,
              fontWeight: pw.FontWeight.bold,
              color: _slate700,
              letterSpacing: 0.8,
            ),
          ),
          pw.Text(
            'VIN: ${vehicle.vin.toUpperCase()}  |  $certCode',
            style: const pw.TextStyle(fontSize: 8, color: _slate500),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPageFooter({
    required pw.Context context,
    required VehiclePassportModel vehicle,
    required String publicUrl,
    required String certCode,
  }) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 10),
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: _slate200, width: 0.8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Verified Vehicle Health Passport  |  $publicUrl  |  $certCode',
            style: const pw.TextStyle(fontSize: 7.5, color: _slate500),
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(
              fontSize: 7.5,
              fontWeight: pw.FontWeight.bold,
              color: _slate700,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildHeroBanner({
    required VehiclePassportModel vehicle,
    required pw.MemoryImage? vehiclePhoto,
    required String issuedDate,
    required String certCode,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: const pw.BoxDecoration(
        color: _navyDark,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(12)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(
                children: [
                  pw.Container(
                    width: 4,
                    height: 16,
                    decoration: const pw.BoxDecoration(
                      color: _primaryLight,
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                    ),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    'AUTOPASSPORT  |  CERTIFIED RESALE DOSSIER',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                      color: _primaryLight,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: const pw.BoxDecoration(
                  color: _verifiedGreen,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(10)),
                ),
                child: pw.Text(
                  'VERIFIED PASSPORT',
                  style: pw.TextStyle(
                    fontSize: 7.5,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${vehicle.year} ${vehicle.fullName}',
                      style: pw.TextStyle(
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      '${vehicle.fuelPowertrain}  |  ${vehicle.bodyType}  |  Plate: ${vehicle.licensePlate}',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColor.fromInt(0xFFCBD5E1),
                      ),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _buildDarkChip('VIN', vehicle.vin.toUpperCase()),
                        _buildDarkChip('ISSUED', issuedDate),
                        _buildDarkChip('CERT ID', certCode),
                      ],
                    ),
                  ],
                ),
              ),
              if (vehiclePhoto != null) ...[
                pw.SizedBox(width: 14),
                pw.ClipRRect(
                  horizontalRadius: 8,
                  verticalRadius: 8,
                  child: pw.Container(
                    width: 112,
                    height: 78,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: _navyMid, width: 1.5),
                    ),
                    child: pw.Image(vehiclePhoto, fit: pw.BoxFit.cover),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildDarkChip(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const pw.BoxDecoration(
        color: _navyMid,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            '$label: ',
            style: pw.TextStyle(
              fontSize: 7.5,
              fontWeight: pw.FontWeight.bold,
              color: _primaryLight,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildKpiStrip({
    required VehiclePassportModel vehicle,
    required int includedRecordsCount,
    required int formalCount,
    required int informalCount,
    required double totalInvestment,
    required DossierPdfOptions options,
  }) {
    final cards = <pw.Widget>[
      _buildKpiCard(
        label: 'CURRENT ODOMETER',
        value: vehicle.formattedMileageIn(options.distanceUnit),
        subtitle: 'Reported in ${options.distanceUnit.label}',
        accent: _primaryBlue,
      ),
      _buildKpiCard(
        label: 'DOSSIER RECORDS',
        value: '$includedRecordsCount',
        subtitle: '$formalCount official  |  $informalCount photo-verified',
        accent: _verifiedGreen,
      ),
    ];

    if (options.includeCostTotals) {
      cards.add(
        _buildKpiCard(
          label: 'TOTAL INVESTMENT',
          value: formatPdfCurrency(totalInvestment, options.displayCurrency),
          subtitle: 'Converted to ${options.displayCurrency.code}',
          accent: _amber,
        ),
      );
    }

    return pw.Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          pw.Expanded(child: cards[i]),
          if (i < cards.length - 1) pw.SizedBox(width: 10),
        ],
      ],
    );
  }

  pw.Widget _buildKpiCard({
    required String label,
    required String value,
    required String subtitle,
    required PdfColor accent,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _slate50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border.all(color: _slate200, width: 0.8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 6,
                height: 6,
                decoration: pw.BoxDecoration(
                  color: accent,
                  shape: pw.BoxShape.circle,
                ),
              ),
              pw.SizedBox(width: 6),
              pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 7.5,
                  fontWeight: pw.FontWeight.bold,
                  color: _slate500,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              color: _slate900,
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            subtitle,
            style: const pw.TextStyle(fontSize: 7.5, color: _slate500),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildCategoryBreakdownSection({
    required List<ServiceRecordModel> records,
    required double totalInvestment,
    required Currency currency,
  }) {
    final totalsByCategory = <ServiceCategory, double>{};
    final countsByCategory = <ServiceCategory, int>{};

    for (final r in records) {
      totalsByCategory[r.category] =
          (totalsByCategory[r.category] ?? 0.0) + r.totalCostIn(currency);
      countsByCategory[r.category] = (countsByCategory[r.category] ?? 0) + 1;
    }

    final sortedEntries = totalsByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border.all(color: _slate200, width: 0.8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'INVESTMENT BY SERVICE CATEGORY',
            style: pw.TextStyle(
              fontSize: 8.5,
              fontWeight: pw.FontWeight.bold,
              color: _slate700,
              letterSpacing: 0.8,
            ),
          ),
          pw.SizedBox(height: 10),
          ...sortedEntries.map((entry) {
            final ratio = totalInvestment > 0
                ? (entry.value / totalInvestment).clamp(0.04, 1.0)
                : 0.0;
            final count = countsByCategory[entry.key] ?? 0;
            final pct = totalInvestment > 0
                ? ((entry.value / totalInvestment) * 100).round()
                : 0;

            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 7),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        '${entry.key.enName} ($count)',
                        style: pw.TextStyle(
                          fontSize: 8.5,
                          fontWeight: pw.FontWeight.bold,
                          color: _slate900,
                        ),
                      ),
                      pw.Text(
                        '${formatPdfCurrency(entry.value, currency)}  ($pct%)',
                        style: pw.TextStyle(
                          fontSize: 8.5,
                          fontWeight: pw.FontWeight.bold,
                          color: _slate700,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 3),
                  pw.Stack(
                    children: [
                      pw.Container(
                        height: 5,
                        width: double.infinity,
                        decoration: const pw.BoxDecoration(
                          color: _slate100,
                          borderRadius: pw.BorderRadius.all(
                            pw.Radius.circular(3),
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 5,
                        width: 480 * ratio,
                        decoration: pw.BoxDecoration(
                          color: _categoryColor(entry.key),
                          borderRadius: const pw.BorderRadius.all(
                            pw.Radius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  pw.Widget _buildSectionHeader({
    required String title,
    required String trailing,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: _slate900,
            letterSpacing: 0.8,
          ),
        ),
        pw.Text(
          trailing,
          style: pw.TextStyle(
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
            color: _primaryBlue,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildRecordCard({
    required ServiceRecordModel record,
    required DossierPdfOptions options,
  }) {
    final isFormal =
        record.proofClassification == ProofClassification.formalStoreReceipt;
    final accent = _categoryColor(record.category);

    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border(
          left: pw.BorderSide(color: accent, width: 3.5),
          top: const pw.BorderSide(color: _slate200, width: 0.8),
          right: const pw.BorderSide(color: _slate200, width: 0.8),
          bottom: const pw.BorderSide(color: _slate200, width: 0.8),
        ),
      ),
      padding: const pw.EdgeInsets.all(12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          record.formattedDate,
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: _slate500,
                          ),
                        ),
                        pw.SizedBox(width: 8),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: const pw.BoxDecoration(
                            color: _slate100,
                            borderRadius: pw.BorderRadius.all(
                              pw.Radius.circular(4),
                            ),
                          ),
                          child: pw.Text(
                            record.category.enName.toUpperCase(),
                            style: pw.TextStyle(
                              fontSize: 7,
                              fontWeight: pw.FontWeight.bold,
                              color: _slate700,
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 6),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: pw.BoxDecoration(
                            color: isFormal ? _verifiedBg : _amberBg,
                            borderRadius: const pw.BorderRadius.all(
                              pw.Radius.circular(4),
                            ),
                          ),
                          child: pw.Text(
                            isFormal ? 'OFFICIAL RECEIPT' : 'PHOTO-VERIFIED',
                            style: pw.TextStyle(
                              fontSize: 7,
                              fontWeight: pw.FontWeight.bold,
                              color: isFormal ? _verifiedGreen : _amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      record.title,
                      style: pw.TextStyle(
                        fontSize: 11.5,
                        fontWeight: pw.FontWeight.bold,
                        color: _slate900,
                      ),
                    ),
                  ],
                ),
              ),
              if (options.includeCostTotals) ...[
                pw.SizedBox(width: 10),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      formatPdfCurrency(
                        record.totalCostIn(options.displayCurrency),
                        options.displayCurrency,
                      ),
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: _slate900,
                      ),
                    ),
                    if (record.partsCost > 0 || record.laborCost > 0)
                      pw.Text(
                        'Parts: ${formatPdfCurrency(record.partsCostIn(options.displayCurrency), options.displayCurrency)}  |  Labor: ${formatPdfCurrency(record.laborCostIn(options.displayCurrency), options.displayCurrency)}',
                        style: const pw.TextStyle(
                          fontSize: 7,
                          color: _slate500,
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              pw.Text(
                'Facility: ${record.facilityName} (${record.facilityType})',
                style: const pw.TextStyle(fontSize: 8.5, color: _slate700),
              ),
              pw.Text(
                'Odometer: ${record.formattedMileageIn(options.distanceUnit)}',
                style: pw.TextStyle(
                  fontSize: 8.5,
                  fontWeight: pw.FontWeight.bold,
                  color: _slate700,
                ),
              ),
              if (record.partsOemNumber.isNotEmpty)
                pw.Text(
                  'OEM: ${record.partsOemNumber}',
                  style: const pw.TextStyle(fontSize: 8, color: _slate500),
                ),
            ],
          ),
          if (options.includePartBoxPhotos &&
              record.proofBadges.isNotEmpty) ...[
            pw.SizedBox(height: 7),
            pw.Wrap(
              spacing: 5,
              runSpacing: 4,
              children: [
                pw.Text(
                  'Part Box & Proof Evidence:',
                  style: pw.TextStyle(
                    fontSize: 7.5,
                    fontWeight: pw.FontWeight.bold,
                    color: _slate500,
                  ),
                ),
                ...record.proofBadges.map(
                  (badge) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: pw.BoxDecoration(
                      color: _slate100,
                      borderRadius: const pw.BorderRadius.all(
                        pw.Radius.circular(10),
                      ),
                      border: pw.Border.all(color: _slate200, width: 0.6),
                    ),
                    child: pw.Text(
                      badge,
                      style: pw.TextStyle(
                        fontSize: 7,
                        fontWeight: pw.FontWeight.bold,
                        color: _primaryBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (record.verificationNotes.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: const pw.BoxDecoration(
                color: _slate50,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
              ),
              child: pw.Text(
                record.verificationNotes,
                style: const pw.TextStyle(fontSize: 7.5, color: _slate500),
              ),
            ),
          ],
        ],
      ),
    );
  }

  pw.Widget _buildEmptyRecordsNotice() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: _slate50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border.all(color: _slate200, width: 0.8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'No Service Records Selected for Dossier',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: _slate700,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Enable "Include in Resale Dossier" on individual service records to display them in this certified report.',
            style: const pw.TextStyle(fontSize: 8.5, color: _slate500),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  pw.Widget _buildCertificationStamp({
    required VehiclePassportModel vehicle,
    required String issuedDate,
    required String certCode,
    required DossierPdfOptions options,
  }) {
    final flags = <String>[
      'Part Box Photos: ${options.includePartBoxPhotos ? 'Included' : 'Hidden'}',
      'Cost Totals: ${options.includeCostTotals ? 'Included (${options.displayCurrency.code})' : 'Hidden'}',
      'VIN Watermark: ${options.watermarkWithVin ? 'Enabled' : 'Disabled'}',
    ].join('   |   ');

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _slate50,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border.all(color: _slate200, width: 0.8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'DIGITAL CERTIFICATION & EXPORT CONFIGURATION',
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: _slate700,
              letterSpacing: 0.7,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'This dossier was generated by AutoPassport on $issuedDate for VIN ${vehicle.vin.toUpperCase()} (Certificate $certCode).',
            style: const pw.TextStyle(fontSize: 8, color: _slate500),
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            flags,
            style: pw.TextStyle(
              fontSize: 7.5,
              fontWeight: pw.FontWeight.bold,
              color: _primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  PdfColor _categoryColor(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.suspension:
        return _amber;
      case ServiceCategory.brakes:
        return const PdfColor.fromInt(0xFF0284C7);
      case ServiceCategory.oilFilter:
        return _verifiedGreen;
      case ServiceCategory.engine:
        return const PdfColor.fromInt(0xFFDC2626);
      case ServiceCategory.transmission:
        return const PdfColor.fromInt(0xFF7C3AED);
    }
  }
}
