// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceRecordModel _$ServiceRecordModelFromJson(Map<String, dynamic> json) =>
    _ServiceRecordModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      mileageKm: (json['mileageKm'] as num).toInt(),
      totalCost: (json['totalCost'] as num).toDouble(),
      partsCost: (json['partsCost'] as num?)?.toDouble() ?? 0.0,
      laborCost: (json['laborCost'] as num?)?.toDouble() ?? 0.0,
      partsOemNumber: json['partsOemNumber'] as String? ?? '',
      facilityName: json['facilityName'] as String,
      facilityType: json['facilityType'] as String? ?? 'Private Garage',
      facilityLocation: json['facilityLocation'] as String? ?? 'Yerevan',
      category: $enumDecode(_$ServiceCategoryEnumMap, json['category']),
      proofClassification:
          $enumDecodeNullable(
            _$ProofClassificationEnumMap,
            json['proofClassification'],
          ) ??
          ProofClassification.informalMaster,
      proofBadges:
          (json['proofBadges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isVerified: json['isVerified'] as bool? ?? true,
      verificationNotes: json['verificationNotes'] as String? ?? '',
    );

Map<String, dynamic> _$ServiceRecordModelToJson(_ServiceRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'mileageKm': instance.mileageKm,
      'totalCost': instance.totalCost,
      'partsCost': instance.partsCost,
      'laborCost': instance.laborCost,
      'partsOemNumber': instance.partsOemNumber,
      'facilityName': instance.facilityName,
      'facilityType': instance.facilityType,
      'facilityLocation': instance.facilityLocation,
      'category': _$ServiceCategoryEnumMap[instance.category]!,
      'proofClassification':
          _$ProofClassificationEnumMap[instance.proofClassification]!,
      'proofBadges': instance.proofBadges,
      'isVerified': instance.isVerified,
      'verificationNotes': instance.verificationNotes,
    };

const _$ServiceCategoryEnumMap = {
  ServiceCategory.suspension: 'suspension',
  ServiceCategory.brakes: 'brakes',
  ServiceCategory.oilFilter: 'oilFilter',
  ServiceCategory.engine: 'engine',
  ServiceCategory.transmission: 'transmission',
};

const _$ProofClassificationEnumMap = {
  ProofClassification.informalMaster: 'informalMaster',
  ProofClassification.formalStoreReceipt: 'formalStoreReceipt',
};
