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

 String get id; String get title; String get description; DateTime get date; int get mileageKm; double get totalCost; double get partsCost; double get laborCost; String get partsOemNumber; String get facilityName; String get facilityType; String get facilityLocation; ServiceCategory get category; ProofClassification get proofClassification; List<String> get proofBadges; bool get isVerified; String get verificationNotes;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRecordModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.mileageKm, _this.mileageKm) || other.mileageKm == _this.mileageKm)&&(identical(other.totalCost, _this.totalCost) || other.totalCost == _this.totalCost)&&(identical(other.partsCost, _this.partsCost) || other.partsCost == _this.partsCost)&&(identical(other.laborCost, _this.laborCost) || other.laborCost == _this.laborCost)&&(identical(other.partsOemNumber, _this.partsOemNumber) || other.partsOemNumber == _this.partsOemNumber)&&(identical(other.facilityName, _this.facilityName) || other.facilityName == _this.facilityName)&&(identical(other.facilityType, _this.facilityType) || other.facilityType == _this.facilityType)&&(identical(other.facilityLocation, _this.facilityLocation) || other.facilityLocation == _this.facilityLocation)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.proofClassification, _this.proofClassification) || other.proofClassification == _this.proofClassification)&&const DeepCollectionEquality().equals(other.proofBadges, _this.proofBadges)&&(identical(other.isVerified, _this.isVerified) || other.isVerified == _this.isVerified)&&(identical(other.verificationNotes, _this.verificationNotes) || other.verificationNotes == _this.verificationNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServiceRecordModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.date,_this.mileageKm,_this.totalCost,_this.partsCost,_this.laborCost,_this.partsOemNumber,_this.facilityName,_this.facilityType,_this.facilityLocation,_this.category,_this.proofClassification,const DeepCollectionEquality().hash(_this.proofBadges),_this.isVerified,_this.verificationNotes);
}

@override
String toString() {
  final _this = this as ServiceRecordModel;
  return 'ServiceRecordModel(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, date: ${_this.date}, mileageKm: ${_this.mileageKm}, totalCost: ${_this.totalCost}, partsCost: ${_this.partsCost}, laborCost: ${_this.laborCost}, partsOemNumber: ${_this.partsOemNumber}, facilityName: ${_this.facilityName}, facilityType: ${_this.facilityType}, facilityLocation: ${_this.facilityLocation}, category: ${_this.category}, proofClassification: ${_this.proofClassification}, proofBadges: ${_this.proofBadges}, isVerified: ${_this.isVerified}, verificationNotes: ${_this.verificationNotes})';
}


}

/// @nodoc
abstract mixin class $ServiceRecordModelCopyWith<$Res>  {
  factory $ServiceRecordModelCopyWith(ServiceRecordModel value, $Res Function(ServiceRecordModel) _then) = _$ServiceRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, DateTime date, int mileageKm, double totalCost, double partsCost, double laborCost, String partsOemNumber, String facilityName, String facilityType, String facilityLocation, ServiceCategory category, ProofClassification proofClassification, List<String> proofBadges, bool isVerified, String verificationNotes
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? date = null,Object? mileageKm = null,Object? totalCost = null,Object? partsCost = null,Object? laborCost = null,Object? partsOemNumber = null,Object? facilityName = null,Object? facilityType = null,Object? facilityLocation = null,Object? category = null,Object? proofClassification = null,Object? proofBadges = null,Object? isVerified = null,Object? verificationNotes = null,}) {
  return _then(ServiceRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mileageKm: null == mileageKm ? _self.mileageKm : mileageKm // ignore: cast_nullable_to_non_nullable
as int,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,partsCost: null == partsCost ? _self.partsCost : partsCost // ignore: cast_nullable_to_non_nullable
as double,laborCost: null == laborCost ? _self.laborCost : laborCost // ignore: cast_nullable_to_non_nullable
as double,partsOemNumber: null == partsOemNumber ? _self.partsOemNumber : partsOemNumber // ignore: cast_nullable_to_non_nullable
as String,facilityName: null == facilityName ? _self.facilityName : facilityName // ignore: cast_nullable_to_non_nullable
as String,facilityType: null == facilityType ? _self.facilityType : facilityType // ignore: cast_nullable_to_non_nullable
as String,facilityLocation: null == facilityLocation ? _self.facilityLocation : facilityLocation // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ServiceCategory,proofClassification: null == proofClassification ? _self.proofClassification : proofClassification // ignore: cast_nullable_to_non_nullable
as ProofClassification,proofBadges: null == proofBadges ? _self.proofBadges : proofBadges // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  DateTime date,  int mileageKm,  double totalCost,  double partsCost,  double laborCost,  String partsOemNumber,  String facilityName,  String facilityType,  String facilityLocation,  ServiceCategory category,  ProofClassification proofClassification,  List<String> proofBadges,  bool isVerified,  String verificationNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceRecordModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.date,_that.mileageKm,_that.totalCost,_that.partsCost,_that.laborCost,_that.partsOemNumber,_that.facilityName,_that.facilityType,_that.facilityLocation,_that.category,_that.proofClassification,_that.proofBadges,_that.isVerified,_that.verificationNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  DateTime date,  int mileageKm,  double totalCost,  double partsCost,  double laborCost,  String partsOemNumber,  String facilityName,  String facilityType,  String facilityLocation,  ServiceCategory category,  ProofClassification proofClassification,  List<String> proofBadges,  bool isVerified,  String verificationNotes)  $default,) {final _that = this;
switch (_that) {
case _ServiceRecordModel():
return $default(_that.id,_that.title,_that.description,_that.date,_that.mileageKm,_that.totalCost,_that.partsCost,_that.laborCost,_that.partsOemNumber,_that.facilityName,_that.facilityType,_that.facilityLocation,_that.category,_that.proofClassification,_that.proofBadges,_that.isVerified,_that.verificationNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  DateTime date,  int mileageKm,  double totalCost,  double partsCost,  double laborCost,  String partsOemNumber,  String facilityName,  String facilityType,  String facilityLocation,  ServiceCategory category,  ProofClassification proofClassification,  List<String> proofBadges,  bool isVerified,  String verificationNotes)?  $default,) {final _that = this;
switch (_that) {
case _ServiceRecordModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.date,_that.mileageKm,_that.totalCost,_that.partsCost,_that.laborCost,_that.partsOemNumber,_that.facilityName,_that.facilityType,_that.facilityLocation,_that.category,_that.proofClassification,_that.proofBadges,_that.isVerified,_that.verificationNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceRecordModel extends ServiceRecordModel {
  const _ServiceRecordModel({required this.id, required this.title, required this.description, required this.date, required this.mileageKm, required this.totalCost, this.partsCost = 0.0, this.laborCost = 0.0, this.partsOemNumber = '', required this.facilityName, this.facilityType = 'Private Garage', this.facilityLocation = 'Yerevan', required this.category, this.proofClassification = ProofClassification.informalMaster,  List<String> proofBadges = const <String>[], this.isVerified = true, this.verificationNotes = ''}): _proofBadges = proofBadges,super._();
  factory _ServiceRecordModel.fromJson(Map<String, dynamic> json) => _$ServiceRecordModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  DateTime date;
@override final  int mileageKm;
@override final  double totalCost;
@override@JsonKey() final  double partsCost;
@override@JsonKey() final  double laborCost;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.mileageKm, mileageKm) || other.mileageKm == mileageKm)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.partsCost, partsCost) || other.partsCost == partsCost)&&(identical(other.laborCost, laborCost) || other.laborCost == laborCost)&&(identical(other.partsOemNumber, partsOemNumber) || other.partsOemNumber == partsOemNumber)&&(identical(other.facilityName, facilityName) || other.facilityName == facilityName)&&(identical(other.facilityType, facilityType) || other.facilityType == facilityType)&&(identical(other.facilityLocation, facilityLocation) || other.facilityLocation == facilityLocation)&&(identical(other.category, category) || other.category == category)&&(identical(other.proofClassification, proofClassification) || other.proofClassification == proofClassification)&&const DeepCollectionEquality().equals(other.proofBadges, _proofBadges)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.verificationNotes, verificationNotes) || other.verificationNotes == verificationNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,date,mileageKm,totalCost,partsCost,laborCost,partsOemNumber,facilityName,facilityType,facilityLocation,category,proofClassification,const DeepCollectionEquality().hash(_proofBadges),isVerified,verificationNotes);
}

@override
String toString() {
    return 'ServiceRecordModel(id: $id, title: $title, description: $description, date: $date, mileageKm: $mileageKm, totalCost: $totalCost, partsCost: $partsCost, laborCost: $laborCost, partsOemNumber: $partsOemNumber, facilityName: $facilityName, facilityType: $facilityType, facilityLocation: $facilityLocation, category: $category, proofClassification: $proofClassification, proofBadges: $proofBadges, isVerified: $isVerified, verificationNotes: $verificationNotes)';
}


}

/// @nodoc
abstract mixin class _$ServiceRecordModelCopyWith<$Res> implements $ServiceRecordModelCopyWith<$Res> {
  factory _$ServiceRecordModelCopyWith(_ServiceRecordModel value, $Res Function(_ServiceRecordModel) _then) = __$ServiceRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, DateTime date, int mileageKm, double totalCost, double partsCost, double laborCost, String partsOemNumber, String facilityName, String facilityType, String facilityLocation, ServiceCategory category, ProofClassification proofClassification, List<String> proofBadges, bool isVerified, String verificationNotes
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? date = null,Object? mileageKm = null,Object? totalCost = null,Object? partsCost = null,Object? laborCost = null,Object? partsOemNumber = null,Object? facilityName = null,Object? facilityType = null,Object? facilityLocation = null,Object? category = null,Object? proofClassification = null,Object? proofBadges = null,Object? isVerified = null,Object? verificationNotes = null,}) {
  return _then(_ServiceRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,mileageKm: null == mileageKm ? _self.mileageKm : mileageKm // ignore: cast_nullable_to_non_nullable
as int,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,partsCost: null == partsCost ? _self.partsCost : partsCost // ignore: cast_nullable_to_non_nullable
as double,laborCost: null == laborCost ? _self.laborCost : laborCost // ignore: cast_nullable_to_non_nullable
as double,partsOemNumber: null == partsOemNumber ? _self.partsOemNumber : partsOemNumber // ignore: cast_nullable_to_non_nullable
as String,facilityName: null == facilityName ? _self.facilityName : facilityName // ignore: cast_nullable_to_non_nullable
as String,facilityType: null == facilityType ? _self.facilityType : facilityType // ignore: cast_nullable_to_non_nullable
as String,facilityLocation: null == facilityLocation ? _self.facilityLocation : facilityLocation // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ServiceCategory,proofClassification: null == proofClassification ? _self.proofClassification : proofClassification // ignore: cast_nullable_to_non_nullable
as ProofClassification,proofBadges: null == proofBadges ? _self._proofBadges : proofBadges // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,verificationNotes: null == verificationNotes ? _self.verificationNotes : verificationNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
