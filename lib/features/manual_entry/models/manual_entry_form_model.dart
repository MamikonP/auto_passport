import '../../../core/models/vehicle_model.dart';

class ManualEntryFormModel {
  final String? id;
  final ProofClassification proofClassification;
  final String title;
  final ServiceCategory category;
  final DateTime date;
  final int odometerKm;
  final double partsCost;
  final double laborCost;
  final Currency currency;
  final String mechanicName;
  final String partsOemNumber;
  final List<String> proofBadges;

  const ManualEntryFormModel({
    this.id,
    required this.proofClassification,
    required this.title,
    required this.category,
    required this.date,
    required this.odometerKm,
    required this.partsCost,
    required this.laborCost,
    required this.currency,
    required this.mechanicName,
    this.partsOemNumber = '',
    required this.proofBadges,
  });

  double get totalCost => partsCost + laborCost;

  ServiceRecordModel toServiceRecord() {
    final isFormal =
        proofClassification == ProofClassification.formalStoreReceipt;
    final defaultFacility = isFormal
        ? 'Official Service Center'
        : 'Private Workshop';
    final effectiveFacility = mechanicName.trim().isNotEmpty
        ? mechanicName.trim()
        : defaultFacility;
    final trimmedOem = partsOemNumber.trim();

    return ServiceRecordModel(
      id: id ?? 'rec-${DateTime.now().millisecondsSinceEpoch}',
      title: title.isNotEmpty ? title : '${category.enName} Service',
      description: 'Serviced at $effectiveFacility ($odometerKm km).',
      date: date,
      mileageKm: odometerKm,
      totalCost: totalCost,
      partsCost: partsCost,
      laborCost: laborCost,
      partsOemNumber: trimmedOem,
      facilityName: effectiveFacility,
      facilityType: isFormal ? 'Official Dealership / Store' : 'Private Garage',
      category: category,
      proofClassification: proofClassification,
      proofBadges: List.from(proofBadges),
      isVerified: true,
      verificationNotes: isFormal
          ? 'Verified with official store invoice${trimmedOem.isNotEmpty ? ' (Ref: $trimmedOem)' : ''} and digital timestamp.'
          : 'Stamped with digital verification hash, mechanic photo proof, and location metadata.',
    );
  }
}
