// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_passport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehiclePassportModel _$VehiclePassportModelFromJson(
  Map<String, dynamic> json,
) => _VehiclePassportModel(
  id: json['id'] as String,
  make: json['make'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  vin: json['vin'] as String,
  fuelPowertrain: json['fuelPowertrain'] as String,
  bodyType: json['bodyType'] as String,
  currentMileage: (json['currentMileage'] as num).toInt(),
  distanceUnit:
      $enumDecodeNullable(_$DistanceUnitEnumMap, json['distanceUnit']) ??
      DistanceUnit.km,
  currency:
      $enumDecodeNullable(_$CurrencyEnumMap, json['currency']) ?? Currency.amd,
  isActive: json['isActive'] as bool? ?? false,
  photoUrl: json['photoUrl'] as String?,
  licensePlate: json['licensePlate'] as String? ?? '37 XX 777',
  lifetimeTotalSpentOverride: (json['lifetimeTotalSpentOverride'] as num?)
      ?.toDouble(),
  totalVerifiedRecordsOverride: (json['totalVerifiedRecordsOverride'] as num?)
      ?.toInt(),
  serviceRecords:
      (json['serviceRecords'] as List<dynamic>?)
          ?.map((e) => ServiceRecordModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ServiceRecordModel>[],
);

Map<String, dynamic> _$VehiclePassportModelToJson(
  _VehiclePassportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'make': instance.make,
  'model': instance.model,
  'year': instance.year,
  'vin': instance.vin,
  'fuelPowertrain': instance.fuelPowertrain,
  'bodyType': instance.bodyType,
  'currentMileage': instance.currentMileage,
  'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit]!,
  'currency': _$CurrencyEnumMap[instance.currency]!,
  'isActive': instance.isActive,
  'photoUrl': instance.photoUrl,
  'licensePlate': instance.licensePlate,
  'lifetimeTotalSpentOverride': instance.lifetimeTotalSpentOverride,
  'totalVerifiedRecordsOverride': instance.totalVerifiedRecordsOverride,
  'serviceRecords': instance.serviceRecords.map((e) => e.toJson()).toList(),
};

const _$DistanceUnitEnumMap = {
  DistanceUnit.km: 'km',
  DistanceUnit.miles: 'miles',
};

const _$CurrencyEnumMap = {
  Currency.amd: 'amd',
  Currency.usd: 'usd',
  Currency.eur: 'eur',
  Currency.rub: 'rub',
};
