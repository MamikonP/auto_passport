import '../../../core/models/vehicle_model.dart';

class RecordBreakdownModel {
  final ServiceRecordModel record;
  final Currency currency;

  const RecordBreakdownModel({
    required this.record,
    required this.currency,
  });

  String get title => record.title;
  String get description => record.description;
  int get mileageKm => record.mileageKm;
  double get totalCost => record.totalCost;
  double get partsCost => record.partsCost > 0 ? record.partsCost : (record.totalCost * 0.7);
  double get laborCost => record.laborCost > 0 ? record.laborCost : (record.totalCost * 0.3);
  String get partsOemNumber => record.partsOemNumber.isNotEmpty ? record.partsOemNumber : 'OEM Spec';
  String get facilityName => record.facilityName;
  String get facilityType => record.facilityType;
  String get verificationNotes => record.verificationNotes.isNotEmpty
      ? record.verificationNotes
      : 'Stamped with timestamp and geo-location metadata. Photo of parts box includes serial code recognized by buyer validation engine.';

  String get formattedTotalCost => record.formattedCost(currency);

  String get formattedPartsCost {
    final intCost = partsCost.toInt();
    final formatted = intCost.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '${currency.symbol} $formatted';
  }

  String get formattedLaborCost {
    final intCost = laborCost.toInt();
    final formatted = intCost.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '${currency.symbol} $formatted';
  }
}
