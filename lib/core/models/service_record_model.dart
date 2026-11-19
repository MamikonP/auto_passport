import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/currency.dart';
import '../enums/distance_unit.dart';
import '../enums/proof_classification.dart';
import '../enums/service_category.dart';

part 'service_record_model.freezed.dart';
part 'service_record_model.g.dart';

@freezed
abstract class ServiceRecordModel with _$ServiceRecordModel {
  const ServiceRecordModel._();

  const factory ServiceRecordModel({
    required String id,
    required String title,
    required DateTime date,
    required int mileageKm,
    @Default(DistanceUnit.km) DistanceUnit distanceUnit,
    required double totalCost,
    @Default(0.0) double partsCost,
    @Default(0.0) double laborCost,
    @Default(Currency.amd) Currency currency,
    @Default('') String partsOemNumber,
    required String facilityName,
    @Default('Private Garage') String facilityType,
    @Default('Yerevan') String facilityLocation,
    required ServiceCategory category,
    @Default(ProofClassification.informalMaster) ProofClassification proofClassification,
    @Default(<String>[]) List<String> proofBadges,
    @Default(true) bool isVerified,
    @Default(true) bool includeInDossier,
    @Default('') String verificationNotes,
  }) = _ServiceRecordModel;

  factory ServiceRecordModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceRecordModelFromJson(json);

  String get serviceCenter => facilityName;
  double get cost => totalCost;
  String get proofType => proofClassification.label;

  String get formattedDate =>
      '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

  int mileageIn(DistanceUnit targetUnit) =>
      distanceUnit.convertToInt(mileageKm, to: targetUnit);

  String formattedMileageIn(DistanceUnit targetUnit) =>
      targetUnit.format(mileageIn(targetUnit));

  double totalCostIn(Currency targetCurrency) =>
      currency.convert(totalCost, to: targetCurrency);

  double partsCostIn(Currency targetCurrency) =>
      currency.convert(partsCost, to: targetCurrency);

  double laborCostIn(Currency targetCurrency) =>
      currency.convert(laborCost, to: targetCurrency);

  String formattedCost(Currency targetCurrency) =>
      targetCurrency.format(totalCostIn(targetCurrency));
}
