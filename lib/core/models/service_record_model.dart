import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/currency.dart';
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
    required String description,
    required DateTime date,
    required int mileageKm,
    required double totalCost,
    @Default(0.0) double partsCost,
    @Default(0.0) double laborCost,
    @Default('') String partsOemNumber,
    required String facilityName,
    @Default('Private Garage') String facilityType,
    @Default('Yerevan') String facilityLocation,
    required ServiceCategory category,
    @Default(ProofClassification.informalMaster) ProofClassification proofClassification,
    @Default(<String>[]) List<String> proofBadges,
    @Default(true) bool isVerified,
    @Default('') String verificationNotes,
  }) = _ServiceRecordModel;

  factory ServiceRecordModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceRecordModelFromJson(json);

  String get serviceCenter => facilityName;
  double get cost => totalCost;
  String get notes => description;
  String get proofType => proofClassification.label;

  String get formattedDate =>
      '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

  String formattedCost(Currency curr) {
    final intCost = totalCost.toInt();
    final formatted = intCost.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '${curr.symbol} $formatted';
  }
}
