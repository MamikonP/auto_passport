import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/currency.dart';
import '../enums/distance_unit.dart';
import '../enums/passport_status.dart';
import 'service_record_model.dart';

part 'vehicle_passport_model.freezed.dart';
part 'vehicle_passport_model.g.dart';

@freezed
abstract class VehiclePassportModel with _$VehiclePassportModel {
  const VehiclePassportModel._();

  const factory VehiclePassportModel({
    required String id,
    required String make,
    required String model,
    required int year,
    required String vin,
    required String fuelPowertrain,
    required String bodyType,
    required int currentMileage,
    @Default(DistanceUnit.km) DistanceUnit distanceUnit,
    @Default(Currency.amd) Currency currency,
    @Default(false) bool isActive,
    String? photoUrl,
    @Default('37 XX 777') String licensePlate,
    double? lifetimeTotalSpentOverride,
    int? totalVerifiedRecordsOverride,
    @Default(<ServiceRecordModel>[]) List<ServiceRecordModel> serviceRecords,
  }) = _VehiclePassportModel;

  factory VehiclePassportModel.fromJson(Map<String, dynamic> json) =>
      _$VehiclePassportModelFromJson(json);

  String get fullName => '$make $model';

  int get mileageKm => currentMileage;

  PassportStatus get status => isActive ? PassportStatus.verified : PassportStatus.pending;

  String get maskedVin {
    if (vin.length > 7) {
      return '${vin.substring(0, vin.length - 3)}***';
    }
    return vin;
  }

  int get verifiedRecordsCount =>
      totalVerifiedRecordsOverride ?? serviceRecords.where((r) => r.isVerified).length;

  double get totalSpent =>
      lifetimeTotalSpentOverride ?? serviceRecords.fold(0.0, (sum, r) => sum + r.totalCost);

  String get formattedTotalSpent {
    final intCost = totalSpent.toInt();
    final formatted = intCost.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '${currency.symbol} $formatted';
  }

  String get formattedMileage {
    final formatted = currentMileage.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '$formatted ${distanceUnit.label}';
  }
}
