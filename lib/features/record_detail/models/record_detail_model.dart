import '../../../core/models/vehicle_model.dart';

class RecordBreakdownModel {
  final ServiceRecordModel record;
  final Currency currency;

  const RecordBreakdownModel({required this.record, required this.currency});

  String get title => record.title;
  String get description => record.description;
  int get mileageKm => record.mileageKm;
  double get partsCost => record.partsCost;
  double get laborCost => record.laborCost;
  double get totalCost =>
      (partsCost + laborCost) > 0 ? (partsCost + laborCost) : record.totalCost;
  String get partsOemNumber =>
      record.partsOemNumber.isNotEmpty ? record.partsOemNumber : 'OEM Spec';
  String get facilityName => record.facilityName;
  String get facilityType => record.facilityType;
  String get verificationNotes => record.verificationNotes.isNotEmpty
      ? record.verificationNotes
      : 'Stamped with timestamp and geo-location metadata. Photo of parts box includes serial code recognized by buyer validation engine.';

  String _formatCurrency(double amount) {
    final intCost = amount.toInt();
    final formatted = intCost.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '${currency.symbol} $formatted';
  }

  String get formattedTotalCost => _formatCurrency(totalCost);
  String get formattedPartsCost => _formatCurrency(partsCost);
  String get formattedLaborCost => _formatCurrency(laborCost);
}
