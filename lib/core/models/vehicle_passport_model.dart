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

  double totalSpentIn(Currency targetCurrency) {
    if (lifetimeTotalSpentOverride != null) {
      return currency.convert(lifetimeTotalSpentOverride!, to: targetCurrency);
    }
    return serviceRecords.fold(
      0.0,
      (sum, r) => sum + r.totalCostIn(targetCurrency),
    );
  }

  String formattedTotalSpentIn(Currency targetCurrency) =>
      targetCurrency.format(totalSpentIn(targetCurrency));

  double get totalSpent => totalSpentIn(currency);

  String get formattedTotalSpent => formattedTotalSpentIn(currency);

  int mileageIn(DistanceUnit targetUnit) =>
      distanceUnit.convertToInt(currentMileage, to: targetUnit);

  String formattedMileageIn(DistanceUnit targetUnit) =>
      targetUnit.format(mileageIn(targetUnit));

  String get formattedMileage => formattedMileageIn(distanceUnit);
}
