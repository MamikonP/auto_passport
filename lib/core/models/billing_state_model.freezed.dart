// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillingProduct {

 String get id; String get title; String get description; String get price; bool get isSubscription;
/// Create a copy of BillingProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingProductCopyWith<BillingProduct> get copyWith => _$BillingProductCopyWithImpl<BillingProduct>(this as BillingProduct, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillingProduct;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingProduct&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.isSubscription, _this.isSubscription) || other.isSubscription == _this.isSubscription));
}


@override
int get hashCode {
  final _this = this as BillingProduct;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.price,_this.isSubscription);
}

@override
String toString() {
  final _this = this as BillingProduct;
  return 'BillingProduct(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, price: ${_this.price}, isSubscription: ${_this.isSubscription})';
}


}

/// @nodoc
abstract mixin class $BillingProductCopyWith<$Res>  {
  factory $BillingProductCopyWith(BillingProduct value, $Res Function(BillingProduct) _then) = _$BillingProductCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String price, bool isSubscription
});




}
/// @nodoc
class _$BillingProductCopyWithImpl<$Res>
    implements $BillingProductCopyWith<$Res> {
  _$BillingProductCopyWithImpl(this._self, this._then);

  final BillingProduct _self;
  final $Res Function(BillingProduct) _then;

/// Create a copy of BillingProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? price = null,Object? isSubscription = null,}) {
  return _then(BillingProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,isSubscription: null == isSubscription ? _self.isSubscription : isSubscription // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BillingProduct].
extension BillingProductPatterns on BillingProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingProduct value)  $default,){
final _that = this;
switch (_that) {
case _BillingProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingProduct value)?  $default,){
final _that = this;
switch (_that) {
case _BillingProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String price,  bool isSubscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingProduct() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.price,_that.isSubscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String price,  bool isSubscription)  $default,) {final _that = this;
switch (_that) {
case _BillingProduct():
return $default(_that.id,_that.title,_that.description,_that.price,_that.isSubscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String price,  bool isSubscription)?  $default,) {final _that = this;
switch (_that) {
case _BillingProduct() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.price,_that.isSubscription);case _:
  return null;

}
}

}

/// @nodoc


class _BillingProduct implements BillingProduct {
  const _BillingProduct({required this.id, required this.title, required this.description, required this.price, required this.isSubscription});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String price;
@override final  bool isSubscription;

/// Create a copy of BillingProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingProductCopyWith<_BillingProduct> get copyWith => __$BillingProductCopyWithImpl<_BillingProduct>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.isSubscription, isSubscription) || other.isSubscription == isSubscription));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,price,isSubscription);
}

@override
String toString() {
    return 'BillingProduct(id: $id, title: $title, description: $description, price: $price, isSubscription: $isSubscription)';
}


}

/// @nodoc
abstract mixin class _$BillingProductCopyWith<$Res> implements $BillingProductCopyWith<$Res> {
  factory _$BillingProductCopyWith(_BillingProduct value, $Res Function(_BillingProduct) _then) = __$BillingProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String price, bool isSubscription
});




}
/// @nodoc
class __$BillingProductCopyWithImpl<$Res>
    implements _$BillingProductCopyWith<$Res> {
  __$BillingProductCopyWithImpl(this._self, this._then);

  final _BillingProduct _self;
  final $Res Function(_BillingProduct) _then;

/// Create a copy of BillingProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? price = null,Object? isSubscription = null,}) {
  return _then(_BillingProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,isSubscription: null == isSubscription ? _self.isSubscription : isSubscription // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$BillingStateModel {

 bool get isStoreAvailable; bool get isLoading; bool get isPurchasing; bool get isProSubscribed; String? get activeSubscriptionProductId; Set<String> get unlockedVehicleIds; Map<String, BillingProduct> get products; String? get errorMessage;
/// Create a copy of BillingStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingStateModelCopyWith<BillingStateModel> get copyWith => _$BillingStateModelCopyWithImpl<BillingStateModel>(this as BillingStateModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillingStateModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingStateModel&&(identical(other.isStoreAvailable, _this.isStoreAvailable) || other.isStoreAvailable == _this.isStoreAvailable)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isPurchasing, _this.isPurchasing) || other.isPurchasing == _this.isPurchasing)&&(identical(other.isProSubscribed, _this.isProSubscribed) || other.isProSubscribed == _this.isProSubscribed)&&(identical(other.activeSubscriptionProductId, _this.activeSubscriptionProductId) || other.activeSubscriptionProductId == _this.activeSubscriptionProductId)&&const DeepCollectionEquality().equals(other.unlockedVehicleIds, _this.unlockedVehicleIds)&&const DeepCollectionEquality().equals(other.products, _this.products)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as BillingStateModel;
  return Object.hash(runtimeType,_this.isStoreAvailable,_this.isLoading,_this.isPurchasing,_this.isProSubscribed,_this.activeSubscriptionProductId,const DeepCollectionEquality().hash(_this.unlockedVehicleIds),const DeepCollectionEquality().hash(_this.products),_this.errorMessage);
}

@override
String toString() {
  final _this = this as BillingStateModel;
  return 'BillingStateModel(isStoreAvailable: ${_this.isStoreAvailable}, isLoading: ${_this.isLoading}, isPurchasing: ${_this.isPurchasing}, isProSubscribed: ${_this.isProSubscribed}, activeSubscriptionProductId: ${_this.activeSubscriptionProductId}, unlockedVehicleIds: ${_this.unlockedVehicleIds}, products: ${_this.products}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $BillingStateModelCopyWith<$Res>  {
  factory $BillingStateModelCopyWith(BillingStateModel value, $Res Function(BillingStateModel) _then) = _$BillingStateModelCopyWithImpl;
@useResult
$Res call({
 bool isStoreAvailable, bool isLoading, bool isPurchasing, bool isProSubscribed, String? activeSubscriptionProductId, Set<String> unlockedVehicleIds, Map<String, BillingProduct> products, String? errorMessage
});




}
/// @nodoc
class _$BillingStateModelCopyWithImpl<$Res>
    implements $BillingStateModelCopyWith<$Res> {
  _$BillingStateModelCopyWithImpl(this._self, this._then);

  final BillingStateModel _self;
  final $Res Function(BillingStateModel) _then;

/// Create a copy of BillingStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isStoreAvailable = null,Object? isLoading = null,Object? isPurchasing = null,Object? isProSubscribed = null,Object? activeSubscriptionProductId = freezed,Object? unlockedVehicleIds = null,Object? products = null,Object? errorMessage = freezed,}) {
  return _then(BillingStateModel(
isStoreAvailable: null == isStoreAvailable ? _self.isStoreAvailable : isStoreAvailable // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPurchasing: null == isPurchasing ? _self.isPurchasing : isPurchasing // ignore: cast_nullable_to_non_nullable
as bool,isProSubscribed: null == isProSubscribed ? _self.isProSubscribed : isProSubscribed // ignore: cast_nullable_to_non_nullable
as bool,activeSubscriptionProductId: freezed == activeSubscriptionProductId ? _self.activeSubscriptionProductId : activeSubscriptionProductId // ignore: cast_nullable_to_non_nullable
as String?,unlockedVehicleIds: null == unlockedVehicleIds ? _self.unlockedVehicleIds : unlockedVehicleIds // ignore: cast_nullable_to_non_nullable
as Set<String>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as Map<String, BillingProduct>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BillingStateModel].
extension BillingStateModelPatterns on BillingStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingStateModel value)  $default,){
final _that = this;
switch (_that) {
case _BillingStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _BillingStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isStoreAvailable,  bool isLoading,  bool isPurchasing,  bool isProSubscribed,  String? activeSubscriptionProductId,  Set<String> unlockedVehicleIds,  Map<String, BillingProduct> products,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingStateModel() when $default != null:
return $default(_that.isStoreAvailable,_that.isLoading,_that.isPurchasing,_that.isProSubscribed,_that.activeSubscriptionProductId,_that.unlockedVehicleIds,_that.products,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isStoreAvailable,  bool isLoading,  bool isPurchasing,  bool isProSubscribed,  String? activeSubscriptionProductId,  Set<String> unlockedVehicleIds,  Map<String, BillingProduct> products,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BillingStateModel():
return $default(_that.isStoreAvailable,_that.isLoading,_that.isPurchasing,_that.isProSubscribed,_that.activeSubscriptionProductId,_that.unlockedVehicleIds,_that.products,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isStoreAvailable,  bool isLoading,  bool isPurchasing,  bool isProSubscribed,  String? activeSubscriptionProductId,  Set<String> unlockedVehicleIds,  Map<String, BillingProduct> products,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BillingStateModel() when $default != null:
return $default(_that.isStoreAvailable,_that.isLoading,_that.isPurchasing,_that.isProSubscribed,_that.activeSubscriptionProductId,_that.unlockedVehicleIds,_that.products,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BillingStateModel extends BillingStateModel {
  const _BillingStateModel({this.isStoreAvailable = false, this.isLoading = false, this.isPurchasing = false, this.isProSubscribed = false, this.activeSubscriptionProductId,  Set<String> unlockedVehicleIds = const <String>{},  Map<String, BillingProduct> products = const <String, BillingProduct>{}, this.errorMessage}): _unlockedVehicleIds = unlockedVehicleIds,_products = products,super._();
  

@override@JsonKey() final  bool isStoreAvailable;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isPurchasing;
@override@JsonKey() final  bool isProSubscribed;
@override final  String? activeSubscriptionProductId;
 final  Set<String> _unlockedVehicleIds;
@override@JsonKey() Set<String> get unlockedVehicleIds {
  if (_unlockedVehicleIds is EqualUnmodifiableSetView) return _unlockedVehicleIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unlockedVehicleIds);
}

 final  Map<String, BillingProduct> _products;
@override@JsonKey() Map<String, BillingProduct> get products {
  if (_products is EqualUnmodifiableMapView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_products);
}

@override final  String? errorMessage;

/// Create a copy of BillingStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingStateModelCopyWith<_BillingStateModel> get copyWith => __$BillingStateModelCopyWithImpl<_BillingStateModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingStateModel&&(identical(other.isStoreAvailable, isStoreAvailable) || other.isStoreAvailable == isStoreAvailable)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPurchasing, isPurchasing) || other.isPurchasing == isPurchasing)&&(identical(other.isProSubscribed, isProSubscribed) || other.isProSubscribed == isProSubscribed)&&(identical(other.activeSubscriptionProductId, activeSubscriptionProductId) || other.activeSubscriptionProductId == activeSubscriptionProductId)&&const DeepCollectionEquality().equals(other.unlockedVehicleIds, _unlockedVehicleIds)&&const DeepCollectionEquality().equals(other.products, _products)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isStoreAvailable,isLoading,isPurchasing,isProSubscribed,activeSubscriptionProductId,const DeepCollectionEquality().hash(_unlockedVehicleIds),const DeepCollectionEquality().hash(_products),errorMessage);
}

@override
String toString() {
    return 'BillingStateModel(isStoreAvailable: $isStoreAvailable, isLoading: $isLoading, isPurchasing: $isPurchasing, isProSubscribed: $isProSubscribed, activeSubscriptionProductId: $activeSubscriptionProductId, unlockedVehicleIds: $unlockedVehicleIds, products: $products, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BillingStateModelCopyWith<$Res> implements $BillingStateModelCopyWith<$Res> {
  factory _$BillingStateModelCopyWith(_BillingStateModel value, $Res Function(_BillingStateModel) _then) = __$BillingStateModelCopyWithImpl;
@override @useResult
$Res call({
 bool isStoreAvailable, bool isLoading, bool isPurchasing, bool isProSubscribed, String? activeSubscriptionProductId, Set<String> unlockedVehicleIds, Map<String, BillingProduct> products, String? errorMessage
});




}
/// @nodoc
class __$BillingStateModelCopyWithImpl<$Res>
    implements _$BillingStateModelCopyWith<$Res> {
  __$BillingStateModelCopyWithImpl(this._self, this._then);

  final _BillingStateModel _self;
  final $Res Function(_BillingStateModel) _then;

/// Create a copy of BillingStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isStoreAvailable = null,Object? isLoading = null,Object? isPurchasing = null,Object? isProSubscribed = null,Object? activeSubscriptionProductId = freezed,Object? unlockedVehicleIds = null,Object? products = null,Object? errorMessage = freezed,}) {
  return _then(_BillingStateModel(
isStoreAvailable: null == isStoreAvailable ? _self.isStoreAvailable : isStoreAvailable // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPurchasing: null == isPurchasing ? _self.isPurchasing : isPurchasing // ignore: cast_nullable_to_non_nullable
as bool,isProSubscribed: null == isProSubscribed ? _self.isProSubscribed : isProSubscribed // ignore: cast_nullable_to_non_nullable
as bool,activeSubscriptionProductId: freezed == activeSubscriptionProductId ? _self.activeSubscriptionProductId : activeSubscriptionProductId // ignore: cast_nullable_to_non_nullable
as String?,unlockedVehicleIds: null == unlockedVehicleIds ? _self._unlockedVehicleIds : unlockedVehicleIds // ignore: cast_nullable_to_non_nullable
as Set<String>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as Map<String, BillingProduct>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
