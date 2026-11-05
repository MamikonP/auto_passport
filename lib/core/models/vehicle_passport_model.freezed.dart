// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_passport_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehiclePassportModel {

 String get id; String get make; String get model; int get year; String get vin; String get fuelPowertrain; String get bodyType; int get currentMileage; DistanceUnit get distanceUnit; Currency get currency; bool get isActive; String? get photoUrl; String get licensePlate; double? get lifetimeTotalSpentOverride; int? get totalVerifiedRecordsOverride; List<ServiceRecordModel> get serviceRecords;
/// Create a copy of VehiclePassportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclePassportModelCopyWith<VehiclePassportModel> get copyWith => _$VehiclePassportModelCopyWithImpl<VehiclePassportModel>(this as VehiclePassportModel, _$identity);

  /// Serializes this VehiclePassportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VehiclePassportModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclePassportModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.make, _this.make) || other.make == _this.make)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.vin, _this.vin) || other.vin == _this.vin)&&(identical(other.fuelPowertrain, _this.fuelPowertrain) || other.fuelPowertrain == _this.fuelPowertrain)&&(identical(other.bodyType, _this.bodyType) || other.bodyType == _this.bodyType)&&(identical(other.currentMileage, _this.currentMileage) || other.currentMileage == _this.currentMileage)&&(identical(other.distanceUnit, _this.distanceUnit) || other.distanceUnit == _this.distanceUnit)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.licensePlate, _this.licensePlate) || other.licensePlate == _this.licensePlate)&&(identical(other.lifetimeTotalSpentOverride, _this.lifetimeTotalSpentOverride) || other.lifetimeTotalSpentOverride == _this.lifetimeTotalSpentOverride)&&(identical(other.totalVerifiedRecordsOverride, _this.totalVerifiedRecordsOverride) || other.totalVerifiedRecordsOverride == _this.totalVerifiedRecordsOverride)&&const DeepCollectionEquality().equals(other.serviceRecords, _this.serviceRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VehiclePassportModel;
  return Object.hash(runtimeType,_this.id,_this.make,_this.model,_this.year,_this.vin,_this.fuelPowertrain,_this.bodyType,_this.currentMileage,_this.distanceUnit,_this.currency,_this.isActive,_this.photoUrl,_this.licensePlate,_this.lifetimeTotalSpentOverride,_this.totalVerifiedRecordsOverride,const DeepCollectionEquality().hash(_this.serviceRecords));
}

@override
String toString() {
  final _this = this as VehiclePassportModel;
  return 'VehiclePassportModel(id: ${_this.id}, make: ${_this.make}, model: ${_this.model}, year: ${_this.year}, vin: ${_this.vin}, fuelPowertrain: ${_this.fuelPowertrain}, bodyType: ${_this.bodyType}, currentMileage: ${_this.currentMileage}, distanceUnit: ${_this.distanceUnit}, currency: ${_this.currency}, isActive: ${_this.isActive}, photoUrl: ${_this.photoUrl}, licensePlate: ${_this.licensePlate}, lifetimeTotalSpentOverride: ${_this.lifetimeTotalSpentOverride}, totalVerifiedRecordsOverride: ${_this.totalVerifiedRecordsOverride}, serviceRecords: ${_this.serviceRecords})';
}


}

/// @nodoc
abstract mixin class $VehiclePassportModelCopyWith<$Res>  {
  factory $VehiclePassportModelCopyWith(VehiclePassportModel value, $Res Function(VehiclePassportModel) _then) = _$VehiclePassportModelCopyWithImpl;
@useResult
$Res call({
 String id, String make, String model, int year, String vin, String fuelPowertrain, String bodyType, int currentMileage, DistanceUnit distanceUnit, Currency currency, bool isActive, String? photoUrl, String licensePlate, double? lifetimeTotalSpentOverride, int? totalVerifiedRecordsOverride, List<ServiceRecordModel> serviceRecords
});




}
/// @nodoc
class _$VehiclePassportModelCopyWithImpl<$Res>
    implements $VehiclePassportModelCopyWith<$Res> {
  _$VehiclePassportModelCopyWithImpl(this._self, this._then);

  final VehiclePassportModel _self;
  final $Res Function(VehiclePassportModel) _then;

/// Create a copy of VehiclePassportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? vin = null,Object? fuelPowertrain = null,Object? bodyType = null,Object? currentMileage = null,Object? distanceUnit = null,Object? currency = null,Object? isActive = null,Object? photoUrl = freezed,Object? licensePlate = null,Object? lifetimeTotalSpentOverride = freezed,Object? totalVerifiedRecordsOverride = freezed,Object? serviceRecords = null,}) {
  return _then(VehiclePassportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,vin: null == vin ? _self.vin : vin // ignore: cast_nullable_to_non_nullable
as String,fuelPowertrain: null == fuelPowertrain ? _self.fuelPowertrain : fuelPowertrain // ignore: cast_nullable_to_non_nullable
as String,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as String,currentMileage: null == currentMileage ? _self.currentMileage : currentMileage // ignore: cast_nullable_to_non_nullable
as int,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as DistanceUnit,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,licensePlate: null == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String,lifetimeTotalSpentOverride: freezed == lifetimeTotalSpentOverride ? _self.lifetimeTotalSpentOverride : lifetimeTotalSpentOverride // ignore: cast_nullable_to_non_nullable
as double?,totalVerifiedRecordsOverride: freezed == totalVerifiedRecordsOverride ? _self.totalVerifiedRecordsOverride : totalVerifiedRecordsOverride // ignore: cast_nullable_to_non_nullable
as int?,serviceRecords: null == serviceRecords ? _self.serviceRecords : serviceRecords // ignore: cast_nullable_to_non_nullable
as List<ServiceRecordModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [VehiclePassportModel].
extension VehiclePassportModelPatterns on VehiclePassportModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehiclePassportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehiclePassportModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehiclePassportModel value)  $default,){
final _that = this;
switch (_that) {
case _VehiclePassportModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehiclePassportModel value)?  $default,){
final _that = this;
switch (_that) {
case _VehiclePassportModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year,  String vin,  String fuelPowertrain,  String bodyType,  int currentMileage,  DistanceUnit distanceUnit,  Currency currency,  bool isActive,  String? photoUrl,  String licensePlate,  double? lifetimeTotalSpentOverride,  int? totalVerifiedRecordsOverride,  List<ServiceRecordModel> serviceRecords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehiclePassportModel() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.vin,_that.fuelPowertrain,_that.bodyType,_that.currentMileage,_that.distanceUnit,_that.currency,_that.isActive,_that.photoUrl,_that.licensePlate,_that.lifetimeTotalSpentOverride,_that.totalVerifiedRecordsOverride,_that.serviceRecords);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String make,  String model,  int year,  String vin,  String fuelPowertrain,  String bodyType,  int currentMileage,  DistanceUnit distanceUnit,  Currency currency,  bool isActive,  String? photoUrl,  String licensePlate,  double? lifetimeTotalSpentOverride,  int? totalVerifiedRecordsOverride,  List<ServiceRecordModel> serviceRecords)  $default,) {final _that = this;
switch (_that) {
case _VehiclePassportModel():
return $default(_that.id,_that.make,_that.model,_that.year,_that.vin,_that.fuelPowertrain,_that.bodyType,_that.currentMileage,_that.distanceUnit,_that.currency,_that.isActive,_that.photoUrl,_that.licensePlate,_that.lifetimeTotalSpentOverride,_that.totalVerifiedRecordsOverride,_that.serviceRecords);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String make,  String model,  int year,  String vin,  String fuelPowertrain,  String bodyType,  int currentMileage,  DistanceUnit distanceUnit,  Currency currency,  bool isActive,  String? photoUrl,  String licensePlate,  double? lifetimeTotalSpentOverride,  int? totalVerifiedRecordsOverride,  List<ServiceRecordModel> serviceRecords)?  $default,) {final _that = this;
switch (_that) {
case _VehiclePassportModel() when $default != null:
return $default(_that.id,_that.make,_that.model,_that.year,_that.vin,_that.fuelPowertrain,_that.bodyType,_that.currentMileage,_that.distanceUnit,_that.currency,_that.isActive,_that.photoUrl,_that.licensePlate,_that.lifetimeTotalSpentOverride,_that.totalVerifiedRecordsOverride,_that.serviceRecords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehiclePassportModel extends VehiclePassportModel {
  const _VehiclePassportModel({required this.id, required this.make, required this.model, required this.year, required this.vin, required this.fuelPowertrain, required this.bodyType, required this.currentMileage, this.distanceUnit = DistanceUnit.km, this.currency = Currency.amd, this.isActive = false, this.photoUrl, this.licensePlate = '37 XX 777', this.lifetimeTotalSpentOverride, this.totalVerifiedRecordsOverride,  List<ServiceRecordModel> serviceRecords = const <ServiceRecordModel>[]}): _serviceRecords = serviceRecords,super._();
  factory _VehiclePassportModel.fromJson(Map<String, dynamic> json) => _$VehiclePassportModelFromJson(json);

@override final  String id;
@override final  String make;
@override final  String model;
@override final  int year;
@override final  String vin;
@override final  String fuelPowertrain;
@override final  String bodyType;
@override final  int currentMileage;
@override@JsonKey() final  DistanceUnit distanceUnit;
@override@JsonKey() final  Currency currency;
@override@JsonKey() final  bool isActive;
@override final  String? photoUrl;
@override@JsonKey() final  String licensePlate;
@override final  double? lifetimeTotalSpentOverride;
@override final  int? totalVerifiedRecordsOverride;
 final  List<ServiceRecordModel> _serviceRecords;
@override@JsonKey() List<ServiceRecordModel> get serviceRecords {
  if (_serviceRecords is EqualUnmodifiableListView) return _serviceRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceRecords);
}


/// Create a copy of VehiclePassportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehiclePassportModelCopyWith<_VehiclePassportModel> get copyWith => __$VehiclePassportModelCopyWithImpl<_VehiclePassportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehiclePassportModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehiclePassportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.year, year) || other.year == year)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.fuelPowertrain, fuelPowertrain) || other.fuelPowertrain == fuelPowertrain)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.currentMileage, currentMileage) || other.currentMileage == currentMileage)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.lifetimeTotalSpentOverride, lifetimeTotalSpentOverride) || other.lifetimeTotalSpentOverride == lifetimeTotalSpentOverride)&&(identical(other.totalVerifiedRecordsOverride, totalVerifiedRecordsOverride) || other.totalVerifiedRecordsOverride == totalVerifiedRecordsOverride)&&const DeepCollectionEquality().equals(other.serviceRecords, _serviceRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,make,model,year,vin,fuelPowertrain,bodyType,currentMileage,distanceUnit,currency,isActive,photoUrl,licensePlate,lifetimeTotalSpentOverride,totalVerifiedRecordsOverride,const DeepCollectionEquality().hash(_serviceRecords));
}

@override
String toString() {
    return 'VehiclePassportModel(id: $id, make: $make, model: $model, year: $year, vin: $vin, fuelPowertrain: $fuelPowertrain, bodyType: $bodyType, currentMileage: $currentMileage, distanceUnit: $distanceUnit, currency: $currency, isActive: $isActive, photoUrl: $photoUrl, licensePlate: $licensePlate, lifetimeTotalSpentOverride: $lifetimeTotalSpentOverride, totalVerifiedRecordsOverride: $totalVerifiedRecordsOverride, serviceRecords: $serviceRecords)';
}


}

/// @nodoc
abstract mixin class _$VehiclePassportModelCopyWith<$Res> implements $VehiclePassportModelCopyWith<$Res> {
  factory _$VehiclePassportModelCopyWith(_VehiclePassportModel value, $Res Function(_VehiclePassportModel) _then) = __$VehiclePassportModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String make, String model, int year, String vin, String fuelPowertrain, String bodyType, int currentMileage, DistanceUnit distanceUnit, Currency currency, bool isActive, String? photoUrl, String licensePlate, double? lifetimeTotalSpentOverride, int? totalVerifiedRecordsOverride, List<ServiceRecordModel> serviceRecords
});




}
/// @nodoc
class __$VehiclePassportModelCopyWithImpl<$Res>
    implements _$VehiclePassportModelCopyWith<$Res> {
  __$VehiclePassportModelCopyWithImpl(this._self, this._then);

  final _VehiclePassportModel _self;
  final $Res Function(_VehiclePassportModel) _then;

/// Create a copy of VehiclePassportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? make = null,Object? model = null,Object? year = null,Object? vin = null,Object? fuelPowertrain = null,Object? bodyType = null,Object? currentMileage = null,Object? distanceUnit = null,Object? currency = null,Object? isActive = null,Object? photoUrl = freezed,Object? licensePlate = null,Object? lifetimeTotalSpentOverride = freezed,Object? totalVerifiedRecordsOverride = freezed,Object? serviceRecords = null,}) {
  return _then(_VehiclePassportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,vin: null == vin ? _self.vin : vin // ignore: cast_nullable_to_non_nullable
as String,fuelPowertrain: null == fuelPowertrain ? _self.fuelPowertrain : fuelPowertrain // ignore: cast_nullable_to_non_nullable
as String,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as String,currentMileage: null == currentMileage ? _self.currentMileage : currentMileage // ignore: cast_nullable_to_non_nullable
as int,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as DistanceUnit,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,licensePlate: null == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String,lifetimeTotalSpentOverride: freezed == lifetimeTotalSpentOverride ? _self.lifetimeTotalSpentOverride : lifetimeTotalSpentOverride // ignore: cast_nullable_to_non_nullable
as double?,totalVerifiedRecordsOverride: freezed == totalVerifiedRecordsOverride ? _self.totalVerifiedRecordsOverride : totalVerifiedRecordsOverride // ignore: cast_nullable_to_non_nullable
as int?,serviceRecords: null == serviceRecords ? _self._serviceRecords : serviceRecords // ignore: cast_nullable_to_non_nullable
as List<ServiceRecordModel>,
  ));
}


}

// dart format on
