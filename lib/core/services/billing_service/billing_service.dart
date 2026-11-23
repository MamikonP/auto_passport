import '../../models/billing_state_model.dart';

/// Outcome of calling [BillingService.restorePurchases].
enum RestorePurchasesResult {
  restored,
  nothingToRestore,
  failed,
}

/// Store product identifiers for AutoPassport In-App Purchases & Subscriptions.
class BillingProductIds {
  BillingProductIds._();

  /// One-time purchase unlocking unlimited Certified PDF Dossier exports for a single vehicle.
  static const String vehicleLifetimePass = 'autopassport_vehicle_lifetime_pass';

  /// Monthly Pro subscription unlocking multi-car garage & unlimited PDF exports for all cars.
  static const String proMonthlySubscription = 'autopassport_pro_monthly';

  /// Yearly Pro subscription unlocking multi-car garage & unlimited PDF exports for all cars.
  static const String proYearlySubscription = 'autopassport_pro_yearly';

  static const Set<String> allIds = {
    vehicleLifetimePass,
    proMonthlySubscription,
    proYearlySubscription,
  };

  static const Set<String> subscriptionIds = {
    proMonthlySubscription,
    proYearlySubscription,
  };
}

/// Abstract service contract managing all In-App Purchases (one-time per-vehicle
/// PDF passes and auto-renewing Pro subscriptions).
abstract interface class BillingService {
  BillingStateModel get currentState;

  Stream<BillingStateModel> get stateStream;

  /// Initializes persisted entitlements, connects to the store, and listens to purchase updates.
  Future<void> init();

  /// Queries latest product metadata & localized prices from App Store / Google Play.
  Future<void> refreshProducts();

  /// Purchases a one-time Lifetime Dossier Pass for [vehicleId] only.
  /// Returns `true` if the purchase succeeded (or was already unlocked).
  Future<bool> purchaseVehiclePass(String vehicleId);

  /// Purchases the Pro Subscription (monthly or yearly) unlocking multi-car garage
  /// and unlimited PDF dossiers for all vehicles.
  Future<bool> purchaseProSubscription({bool yearly = false});

  /// Restores previous store purchases and subscriptions.
  Future<RestorePurchasesResult> restorePurchases();

  /// Merges unlocked per-car pass IDs (e.g. from an encrypted sync backup).
  Future<void> mergeUnlockedVehicleIds(Iterable<String> vehicleIds);

  bool isDossierUnlockedForVehicle(String vehicleId);

  bool canAddVehicle(int currentVehicleCount);

  void dispose();
}
