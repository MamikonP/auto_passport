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
    required this.proofBadges,
  });

  ServiceRecordModel toServiceRecord() {
    return ServiceRecordModel(
      id: 'rec-${DateTime.now().millisecondsSinceEpoch}',
      title: title.isNotEmpty ? title : '${category.enName} Service',
      description: 'Serviced at $mechanicName ($odometerKm km).',
      date: date,
      mileageKm: odometerKm,
      totalCost: totalCost,
      partsCost: totalCost * 0.7,
      laborCost: totalCost * 0.3,
      facilityName: mechanicName.isNotEmpty ? mechanicName : 'Private Workshop',
      facilityType: proofClassification == ProofClassification.informalMaster
          ? 'Private Garage'
          : 'Official Dealership',
      category: category,
      proofClassification: proofClassification,
      proofBadges: List.from(proofBadges),
      isVerified: true,
      verificationNotes: 'Stamped with digital verification hash and location proof.',
    );
  }
}
