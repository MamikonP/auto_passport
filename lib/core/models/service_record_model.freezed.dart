// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceRecordModel {

 String get id; String get title; DateTime get date; int get mileageKm; DistanceUnit get distanceUnit; double get totalCost; double get partsCost; double get laborCost; Currency get currency; String get partsOemNumber; String get facilityName; String get facilityType; String get facilityLocation; ServiceCategory get category; ProofClassification get proofClassification; List<String> get proofBadges; bool get isVerified; bool get includeInDossier; String get verificationNotes;
/// Create a copy of ServiceRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRecordModelCopyWith<ServiceRecordModel> get copyWith => _$ServiceRecordModelCopyWithImpl<ServiceRecordModel>(this as ServiceRecordModel, _$identity);

  /// Serializes this ServiceRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServiceRecordModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRecordModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.mileageKm, _this.mileageKm) || other.mileageKm == _this.mileageKm)&&(identical(other.distanceUnit, _this.distanceUnit) || other.distanceUnit == _this.distanceUnit)&&(identical(other.totalCost, _this.totalCost) || other.totalCost == _this.totalCost)&&(identical(other.partsCost, _this.partsCost) || other.partsCost == _this.partsCost)&&(identical(other.laborCost, _this.laborCost) || other.laborCost == _this.laborCost)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.partsOemNumber, _this.partsOemNumber) || other.partsOemNumber == _this.partsOemNumber)&&(identical(other.facilityName, _this.facilityName) || other.facilityName == _this.facilityName)&&(identical(other.facilityType, _this.facilityType) || other.facilityType == _this.facilityType)&&(identical(other.facilityLocation, _this.facilityLocation) || other.facilityLocation == _this.facilityLocation)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.proofClassification, _this.proofClassification) || other.proofClassification == _this.proofClassification)&&const DeepCollectionEquality().equals(other.proofBadges, _this.proofBadges)&&(identical(other.isVerified, _this.isVerified) || other.isVerified == _this.isVerified)&&(identical(other.includeInDossier, _this.includeInDossier) || other.includeInDossier == _this.includeInDossier)&&(identical(other.verificationNotes, _this.verificationNotes) || other.verificationNotes == _this.verificationNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServiceRecordModel;
  return Object.hashAll([runtimeType,_this.id,_this.title,_this.date,_this.mileageKm,_this.distanceUnit,_this.totalCost,_this.partsCost,_this.laborCost,_this.currency,_this.partsOemNumber,_this.facilityName,_this.facilityType,_this.facilityLocation,_this.category,_this.proofClassification,const DeepCollectionEquality().hash(_this.proofBadges),_this.isVerified,_this.includeInDossier,_this.verificationNotes]);
}

@override
String toString() {
  final _this = this as ServiceRecordModel;
  return 'ServiceRecordModel(id: ${_this.id}, title: ${_this.title}, date: ${_this.date}, mileageKm: ${_this.mileageKm}, distanceUnit: ${_this.distanceUnit}, totalCost: ${_this.totalCost}, partsCost: ${_this.partsCost}, laborCost: ${_this.laborCost}, currency: ${_this.currency}, partsOemNumber: ${_this.partsOemNumber}, facilityName: ${_this.facilityName}, facilityType: ${_this.facilityType}, facilityLocation: ${_this.facilityLocation}, category: ${_this.category}, proofClassification: ${_this.proofClassification}, proofBadges: ${_this.proofBadges}, isVerified: ${_this.isVerified}, includeInDossier: ${_this.includeInDossier}, verificationNotes: ${_this.verificationNotes})';
}


}

/// @nodoc
abstract mixin class $ServiceRecordModelCopyWith<$Res>  {
  factory $ServiceRecordModelCopyWith(ServiceRecordModel value, $Res Function(ServiceRecordModel) _then) = _$ServiceRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime date, int mileageKm, DistanceUnit distanceUnit, double totalCost, double partsCost, double laborCost, Currency currency, String partsOemNumber, String facilityName, String facilityType, String facilityLocation, ServiceCategory category, ProofClassification proofClassification, List<String> proofBadges, bool isVerified, bool includeInDossier, String verificationNotes
});




}
/// @nodoc
class _$ServiceRecordModelCopyWithImpl<$Res>
    implements $ServiceRecordModelCopyWith<$Res> {
  _$ServiceRecordModelCopyWithImpl(this._self, this._then);

  final ServiceRecordModel _self;
  final $Res Function(ServiceRecordModel) _then;

/// Create a copy of ServiceRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? mileageKm = null,Object? distanceUnit = null,Object? totalCost = null,Object? partsCost = null,Object? laborCost = null,Object? currency = null,Object? partsOemNumber = null,Object? facilityName = null,Object? facilityType = null,Object? facilityLocation = null,Object? category = null,Object? proofClassification = null,Object? proofBadges = null,Object? isVerified = null,Object? includeInDossier = null,Object? verificationNotes = null,}) {
  return _then(ServiceRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mileageKm: null == mileageKm ? _self.mileageKm : mileageKm // ignore: cast_nullable_to_non_nullable
as int,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as DistanceUnit,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,partsCost: null == partsCost ? _self.partsCost : partsCost // ignore: cast_nullable_to_non_nullable
as double,laborCost: null == laborCost ? _self.laborCost : laborCost // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,partsOemNumber: null == partsOemNumber ? _self.partsOemNumber : partsOemNumber // ignore: cast_nullable_to_non_nullable
as String,facilityName: null == facilityName ? _self.facilityName : facilityName // ignore: cast_nullable_to_non_nullable
as String,facilityType: null == facilityType ? _self.facilityType : facilityType // ignore: cast_nullable_to_non_nullable
as String,facilityLocation: null == facilityLocation ? _self.facilityLocation : facilityLocation // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ServiceCategory,proofClassification: null == proofClassification ? _self.proofClassification : proofClassification // ignore: cast_nullable_to_non_nullable
as ProofClassification,proofBadges: null == proofBadges ? _self.proofBadges : proofBadges // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,includeInDossier: null == includeInDossier ? _self.includeInDossier : includeInDossier // ignore: cast_nullable_to_non_nullable
as bool,verificationNotes: null == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceRecordModel].
extension ServiceRecordModelPatterns on ServiceRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime date,  int mileageKm,  DistanceUnit distanceUnit,  double totalCost,  double partsCost,  double laborCost,  Currency currency,  String partsOemNumber,  String facilityName,  String facilityType,  String facilityLocation,  ServiceCategory category,  ProofClassification proofClassification,  List<String> proofBadges,  bool isVerified,  bool includeInDossier,  String verificationNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceRecordModel() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.mileageKm,_that.distanceUnit,_that.totalCost,_that.partsCost,_that.laborCost,_that.currency,_that.partsOemNumber,_that.facilityName,_that.facilityType,_that.facilityLocation,_that.category,_that.proofClassification,_that.proofBadges,_that.isVerified,_that.includeInDossier,_that.verificationNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime date,  int mileageKm,  DistanceUnit distanceUnit,  double totalCost,  double partsCost,  double laborCost,  Currency currency,  String partsOemNumber,  String facilityName,  String facilityType,  String facilityLocation,  ServiceCategory category,  ProofClassification proofClassification,  List<String> proofBadges,  bool isVerified,  bool includeInDossier,  String verificationNotes)  $default,) {final _that = this;
switch (_that) {
case _ServiceRecordModel():
return $default(_that.id,_that.title,_that.date,_that.mileageKm,_that.distanceUnit,_that.totalCost,_that.partsCost,_that.laborCost,_that.currency,_that.partsOemNumber,_that.facilityName,_that.facilityType,_that.facilityLocation,_that.category,_that.proofClassification,_that.proofBadges,_that.isVerified,_that.includeInDossier,_that.verificationNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime date,  int mileageKm,  DistanceUnit distanceUnit,  double totalCost,  double partsCost,  double laborCost,  Currency currency,  String partsOemNumber,  String facilityName,  String facilityType,  String facilityLocation,  ServiceCategory category,  ProofClassification proofClassification,  List<String> proofBadges,  bool isVerified,  bool includeInDossier,  String verificationNotes)?  $default,) {final _that = this;
switch (_that) {
case _ServiceRecordModel() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.mileageKm,_that.distanceUnit,_that.totalCost,_that.partsCost,_that.laborCost,_that.currency,_that.partsOemNumber,_that.facilityName,_that.facilityType,_that.facilityLocation,_that.category,_that.proofClassification,_that.proofBadges,_that.isVerified,_that.includeInDossier,_that.verificationNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceRecordModel extends ServiceRecordModel {
  const _ServiceRecordModel({required this.id, required this.title, required this.date, required this.mileageKm, this.distanceUnit = DistanceUnit.km, required this.totalCost, this.partsCost = 0.0, this.laborCost = 0.0, this.currency = Currency.amd, this.partsOemNumber = '', required this.facilityName, this.facilityType = 'Private Garage', this.facilityLocation = 'Yerevan', required this.category, this.proofClassification = ProofClassification.informalMaster,  List<String> proofBadges = const <String>[], this.isVerified = true, this.includeInDossier = true, this.verificationNotes = ''}): _proofBadges = proofBadges,super._();
  factory _ServiceRecordModel.fromJson(Map<String, dynamic> json) => _$ServiceRecordModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime date;
@override final  int mileageKm;
@override@JsonKey() final  DistanceUnit distanceUnit;
@override final  double totalCost;
@override@JsonKey() final  double partsCost;
@override@JsonKey() final  double laborCost;
@override@JsonKey() final  Currency currency;
@override@JsonKey() final  String partsOemNumber;
@override final  String facilityName;
@override@JsonKey() final  String facilityType;
@override@JsonKey() final  String facilityLocation;
@override final  ServiceCategory category;
@override@JsonKey() final  ProofClassification proofClassification;
 final  List<String> _proofBadges;
@override@JsonKey() List<String> get proofBadges {
  if (_proofBadges is EqualUnmodifiableListView) return _proofBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proofBadges);
}

@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  bool includeInDossier;
@override@JsonKey() final  String verificationNotes;

/// Create a copy of ServiceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRecordModelCopyWith<_ServiceRecordModel> get copyWith => __$ServiceRecordModelCopyWithImpl<_ServiceRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.mileageKm, mileageKm) || other.mileageKm == mileageKm)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.partsCost, partsCost) || other.partsCost == partsCost)&&(identical(other.laborCost, laborCost) || other.laborCost == laborCost)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.partsOemNumber, partsOemNumber) || other.partsOemNumber == partsOemNumber)&&(identical(other.facilityName, facilityName) || other.facilityName == facilityName)&&(identical(other.facilityType, facilityType) || other.facilityType == facilityType)&&(identical(other.facilityLocation, facilityLocation) || other.facilityLocation == facilityLocation)&&(identical(other.category, category) || other.category == category)&&(identical(other.proofClassification, proofClassification) || other.proofClassification == proofClassification)&&const DeepCollectionEquality().equals(other.proofBadges, _proofBadges)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.includeInDossier, includeInDossier) || other.includeInDossier == includeInDossier)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,title,date,mileageKm,distanceUnit,totalCost,partsCost,laborCost,currency,partsOemNumber,facilityName,facilityType,facilityLocation,category,proofClassification,const DeepCollectionEquality().hash(_proofBadges),isVerified,includeInDossier,verificationNotes]);
}

@override
String toString() {
    return 'ServiceRecordModel(id: $id, title: $title, date: $date, mileageKm: $mileageKm, distanceUnit: $distanceUnit, totalCost: $totalCost, partsCost: $partsCost, laborCost: $laborCost, currency: $currency, partsOemNumber: $partsOemNumber, facilityName: $facilityName, facilityType: $facilityType, facilityLocation: $facilityLocation, category: $category, proofClassification: $proofClassification, proofBadges: $proofBadges, isVerified: $isVerified, includeInDossier: $includeInDossier, verificationNotes: $verificationNotes)';
}


}

/// @nodoc
abstract mixin class _$ServiceRecordModelCopyWith<$Res> implements $ServiceRecordModelCopyWith<$Res> {
  factory _$ServiceRecordModelCopyWith(_ServiceRecordModel value, $Res Function(_ServiceRecordModel) _then) = __$ServiceRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime date, int mileageKm, DistanceUnit distanceUnit, double totalCost, double partsCost, double laborCost, Currency currency, String partsOemNumber, String facilityName, String facilityType, String facilityLocation, ServiceCategory category, ProofClassification proofClassification, List<String> proofBadges, bool isVerified, bool includeInDossier, String verificationNotes
});




}
/// @nodoc
class __$ServiceRecordModelCopyWithImpl<$Res>
    implements _$ServiceRecordModelCopyWith<$Res> {
  __$ServiceRecordModelCopyWithImpl(this._self, this._then);

  final _ServiceRecordModel _self;
  final $Res Function(_ServiceRecordModel) _then;

/// Create a copy of ServiceRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? mileageKm = null,Object? distanceUnit = null,Object? totalCost = null,Object? partsCost = null,Object? laborCost = null,Object? currency = null,Object? partsOemNumber = null,Object? facilityName = null,Object? facilityType = null,Object? facilityLocation = null,Object? category = null,Object? proofClassification = null,Object? proofBadges = null,Object? isVerified = null,Object? includeInDossier = null,Object? verificationNotes = null,}) {
  return _then(_ServiceRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mileageKm: null == mileageKm ? _self.mileageKm : mileageKm // ignore: cast_nullable_to_non_nullable
as int,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as DistanceUnit,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,partsCost: null == partsCost ? _self.partsCost : partsCost // ignore: cast_nullable_to_non_nullable
as double,laborCost: null == laborCost ? _self.laborCost : laborCost // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,partsOemNumber: null == partsOemNumber ? _self.partsOemNumber : partsOemNumber // ignore: cast_nullable_to_non_nullable
as String,facilityName: null == facilityName ? _self.facilityName : facilityName // ignore: cast_nullable_to_non_nullable
as String,facilityType: null == facilityType ? _self.facilityType : facilityType // ignore: cast_nullable_to_non_nullable
as String,facilityLocation: null == facilityLocation ? _self.facilityLocation : facilityLocation // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ServiceCategory,proofClassification: null == proofClassification ? _self.proofClassification : proofClassification // ignore: cast_nullable_to_non_nullable
as ProofClassification,proofBadges: null == proofBadges ? _self._proofBadges : proofBadges // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,includeInDossier: null == includeInDossier ? _self.includeInDossier : includeInDossier // ignore: cast_nullable_to_non_nullable
as bool,verificationNotes: null == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
