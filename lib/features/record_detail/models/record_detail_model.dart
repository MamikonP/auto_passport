import '../../../core/models/vehicle_model.dart';

class RecordBreakdownModel {
  final ServiceRecordModel record;
  final Currency currency;
  final DistanceUnit distanceUnit;

  const RecordBreakdownModel({
    required this.record,
    required this.currency,
    this.distanceUnit = DistanceUnit.km,
  });

  String get title => record.title;
  int get mileageKm => record.mileageIn(distanceUnit);
  String get formattedMileage => record.formattedMileageIn(distanceUnit);
  double get partsCost => record.partsCostIn(currency);
  double get laborCost => record.laborCostIn(currency);
  double get totalCost => (record.partsCost + record.laborCost) > 0
      ? record.currency.convert(
          record.partsCost + record.laborCost,
          to: currency,
        )
      : record.totalCostIn(currency);
  String get partsOemNumber =>
      record.partsOemNumber.isNotEmpty ? record.partsOemNumber : 'OEM Spec';
  String get facilityName => record.facilityName;
  String get facilityType => record.facilityType;
  String get verificationNotes => record.verificationNotes.isNotEmpty
      ? record.verificationNotes
      : 'Stamped with timestamp and geo-location metadata. Photo of parts box includes serial code recognized by buyer validation engine.';

  String _formatCurrency(double amount) => currency.format(amount);

  String get formattedTotalCost => _formatCurrency(totalCost);
  String get formattedPartsCost => _formatCurrency(partsCost);
  String get formattedLaborCost => _formatCurrency(laborCost);
}
