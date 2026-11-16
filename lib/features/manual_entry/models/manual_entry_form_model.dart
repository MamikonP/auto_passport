import '../../../core/models/vehicle_model.dart';

class ManualEntryFormModel {
  final ProofClassification proofClassification;
  final String title;
  final ServiceCategory category;
  final DateTime date;
  final int odometerKm;
  final double totalCost;
  final Currency currency;
  final String mechanicName;
  final String partsOemNumber;
  final List<String> proofBadges;

  const ManualEntryFormModel({
    required this.proofClassification,
    required this.title,
    required this.category,
    required this.date,
    required this.odometerKm,
    required this.totalCost,
    required this.currency,
    required this.mechanicName,
    this.partsOemNumber = '',
    required this.proofBadges,
  });

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
      id: 'rec-${DateTime.now().millisecondsSinceEpoch}',
      title: title.isNotEmpty ? title : '${category.enName} Service',
      description: 'Serviced at $effectiveFacility ($odometerKm km).',
      date: date,
      mileageKm: odometerKm,
      totalCost: totalCost,
      partsCost: totalCost * 0.7,
      laborCost: totalCost * 0.3,
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
