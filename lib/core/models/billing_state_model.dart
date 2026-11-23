import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/billing_service/billing_service.dart';

part 'billing_state_model.freezed.dart';

/// Platform-agnostic store product metadata.
@freezed
abstract class BillingProduct with _$BillingProduct {
  const factory BillingProduct({
    required String id,
    required String title,
    required String description,
    required String price,
    required bool isSubscription,
  }) = _BillingProduct;
}

/// Immutable snapshot of the user's current billing state and entitlements.
@freezed
abstract class BillingStateModel with _$BillingStateModel {
  const BillingStateModel._();

  static const int freeVehicleLimit = 1;

  const factory BillingStateModel({
    @Default(false) bool isStoreAvailable,
    @Default(false) bool isLoading,
    @Default(false) bool isPurchasing,
    @Default(false) bool isProSubscribed,
    String? activeSubscriptionProductId,
    @Default(<String>{}) Set<String> unlockedVehicleIds,
    @Default(<String, BillingProduct>{}) Map<String, BillingProduct> products,
    String? errorMessage,
  }) = _BillingStateModel;

  /// Whether PDF Dossier export is unlocked for [vehicleId].
  /// Unlocked if the user has an active Pro subscription OR purchased the one-time pass for this car.
  bool isDossierUnlockedForVehicle(String vehicleId) =>
      isProSubscribed || unlockedVehicleIds.contains(vehicleId);

  /// Whether the user can add another vehicle given [currentVehicleCount].
  /// Free tier supports 1 car; Pro subscription unlocks unlimited cars.
  bool canAddVehicle(int currentVehicleCount) =>
      isProSubscribed || currentVehicleCount < freeVehicleLimit;

  String get vehiclePassPrice =>
      products[BillingProductIds.vehicleLifetimePass]?.price ?? '\$4.99';

  String get proMonthlyPrice =>
      products[BillingProductIds.proMonthlySubscription]?.price ?? '\$6.99/mo';

  String get proYearlyPrice =>
      products[BillingProductIds.proYearlySubscription]?.price ?? '\$49.99/yr';
}
