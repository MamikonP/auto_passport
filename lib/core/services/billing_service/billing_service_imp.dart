import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../models/billing_state_model.dart';
import '../local_database_service.dart';
import 'billing_service.dart';

/// Concrete [BillingService] implementation backed by `in_app_purchase`
/// and persisted locally via [LocalDatabaseService].
class BillingServiceImp implements BillingService {
  static const String _unlockedVehiclesKey = 'billing_unlocked_vehicle_ids';
  static const String _proSubscribedKey = 'billing_is_pro_subscribed';
  static const String _activeSubProductIdKey = 'billing_active_sub_product_id';

  final LocalDatabaseService _databaseService;
  final InAppPurchase? _inAppPurchaseOverride;
  final bool _enableDevFallback;

  final StreamController<BillingStateModel> _stateController =
      StreamController<BillingStateModel>.broadcast();
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  BillingStateModel _state = const BillingStateModel();
  final Map<String, ProductDetails> _storeProductDetails = {};
  String? _pendingVehicleIdForPass;
  Completer<bool>? _activePurchaseCompleter;
  Completer<RestorePurchasesResult>? _restoreCompleter;
  bool _initialized = false;

  BillingServiceImp({
    required this._databaseService,
    InAppPurchase? inAppPurchase,
    this._enableDevFallback = kDebugMode,
  }) : _inAppPurchaseOverride = inAppPurchase;

  InAppPurchase get _iap => _inAppPurchaseOverride ?? InAppPurchase.instance;

  @override
  BillingStateModel get currentState => _state;

  @override
  Stream<BillingStateModel> get stateStream => _stateController.stream;

  void _emit(BillingStateModel next) {
    _state = next;
    if (!_stateController.isClosed) {
      _stateController.add(next);
    }
  }

  @override
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    _emit(_state.copyWith(isLoading: true, errorMessage: null));
    await _loadPersistedEntitlements();

    try {
      final available = await _iap.isAvailable();
      _emit(_state.copyWith(isStoreAvailable: available));

      if (available) {
        _purchaseSubscription ??= _iap.purchaseStream.listen(
          _handlePurchaseUpdates,
          onError: (Object error) {
            debugPrint('BillingService purchaseStream error: $error');
            _completePendingPurchase(false);
            _emit(
              _state.copyWith(
                isPurchasing: false,
                errorMessage: error.toString(),
              ),
            );
          },
        );
        await refreshProducts();
        // On Android, Google Play silently returns active subscriptions via
        // restorePurchases() without prompting for a password, keeping Pro
        // status dynamically synced with Play Console on every launch.
        // On iOS, StoreKit 1 restorePurchases() can prompt for Apple ID login,
        // so iOS restores on-demand via the Restore Purchases button.
        if (!kIsWeb && Platform.isAndroid) {
          await restorePurchases();
        }
      }
    } catch (e) {
      debugPrint('BillingService init store check failed: $e');
      _emit(_state.copyWith(isStoreAvailable: false));
    } finally {
      _emit(_state.copyWith(isLoading: false));
    }
  }

  Future<void> _loadPersistedEntitlements() async {
    final savedUnlocked = await _databaseService.getSetting<List<dynamic>>(
      _unlockedVehiclesKey,
    );
    final unlockedSet = savedUnlocked != null
        ? savedUnlocked.map((e) => e.toString()).toSet()
        : <String>{};

    final isPro =
        await _databaseService.getSetting<bool>(_proSubscribedKey, false) ??
        false;
    final activeSubId = await _databaseService.getSetting<String>(
      _activeSubProductIdKey,
    );

    _emit(
      _state.copyWith(
        unlockedVehicleIds: unlockedSet,
        isProSubscribed: isPro,
        activeSubscriptionProductId: activeSubId,
      ),
    );
  }

  Future<void> _persistEntitlements() async {
    await _databaseService.saveSetting(
      _unlockedVehiclesKey,
      _state.unlockedVehicleIds.toList(),
    );
    await _databaseService.saveSetting(
      _proSubscribedKey,
      _state.isProSubscribed,
    );
    await _databaseService.saveSetting(
      _activeSubProductIdKey,
      _state.activeSubscriptionProductId,
    );
  }

  @override
  Future<void> refreshProducts() async {
    if (!_state.isStoreAvailable) return;

    try {
      final response = await _iap.queryProductDetails(BillingProductIds.allIds);
      if (response.error != null) {
        _emit(_state.copyWith(errorMessage: response.error!.message));
        return;
      }

      _storeProductDetails.clear();
      final mapped = <String, BillingProduct>{};
      for (final details in response.productDetails) {
        _storeProductDetails[details.id] = details;
        mapped[details.id] = BillingProduct(
          id: details.id,
          title: details.title,
          description: details.description,
          price: details.price,
          isSubscription: BillingProductIds.subscriptionIds.contains(
            details.id,
          ),
        );
      }

      _emit(_state.copyWith(products: mapped, errorMessage: null));
    } catch (e) {
      debugPrint('BillingService refreshProducts error: $e');
      _emit(_state.copyWith(errorMessage: e.toString()));
    }
  }

  @override
  Future<bool> purchaseVehiclePass(String vehicleId) async {
    if (isDossierUnlockedForVehicle(vehicleId)) {
      return true;
    }

    _emit(_state.copyWith(isPurchasing: true, errorMessage: null));
    _pendingVehicleIdForPass = vehicleId;

    final product = _storeProductDetails[BillingProductIds.vehicleLifetimePass];
    if (_state.isStoreAvailable && product != null) {
      try {
        _activePurchaseCompleter = Completer<bool>();
        final param = PurchaseParam(
          productDetails: product,
          applicationUserName: vehicleId,
        );
        // Consumable allows buying separate lifetime passes for additional cars.
        final launched = await _iap.buyConsumable(purchaseParam: param);
        if (!launched) {
          _completePendingPurchase(false);
          _emit(
            _state.copyWith(
              isPurchasing: false,
              errorMessage: 'Could not launch store purchase flow.',
            ),
          );
          return false;
        }
        return await _activePurchaseCompleter!.future.timeout(
          const Duration(minutes: 2),
          onTimeout: () {
            _emit(_state.copyWith(isPurchasing: false));
            return false;
          },
        );
      } catch (e) {
        _completePendingPurchase(false);
        _emit(_state.copyWith(isPurchasing: false, errorMessage: e.toString()));
        return false;
      }
    }

    // In debug/simulator builds where App Store / Play Console products are not
    // configured yet, simulate the per-vehicle unlock so the flow can be tested.
    if (_enableDevFallback) {
      await _unlockVehiclePass(vehicleId);
      _emit(_state.copyWith(isPurchasing: false, errorMessage: null));
      return true;
    }

    _emit(
      _state.copyWith(
        isPurchasing: false,
        errorMessage: 'Store product is currently unavailable.',
      ),
    );
    return false;
  }

  @override
  Future<bool> purchaseProSubscription({bool yearly = false}) async {
    final productId = yearly
        ? BillingProductIds.proYearlySubscription
        : BillingProductIds.proMonthlySubscription;

    if (_state.isProSubscribed &&
        _state.activeSubscriptionProductId == productId) {
      return true;
    }

    _emit(_state.copyWith(isPurchasing: true, errorMessage: null));

    final product = _storeProductDetails[productId];
    if (_state.isStoreAvailable && product != null) {
      try {
        _activePurchaseCompleter = Completer<bool>();
        final param = PurchaseParam(productDetails: product);
        final launched = await _iap.buyNonConsumable(purchaseParam: param);
        if (!launched) {
          _completePendingPurchase(false);
          _emit(
            _state.copyWith(
              isPurchasing: false,
              errorMessage: 'Could not launch subscription flow.',
            ),
          );
          return false;
        }
        return await _activePurchaseCompleter!.future.timeout(
          const Duration(minutes: 2),
          onTimeout: () {
            _emit(_state.copyWith(isPurchasing: false));
            return false;
          },
        );
      } catch (e) {
        _completePendingPurchase(false);
        _emit(_state.copyWith(isPurchasing: false, errorMessage: e.toString()));
        return false;
      }
    }

    if (_enableDevFallback) {
      await _activateProSubscription(productId);
      _emit(_state.copyWith(isPurchasing: false, errorMessage: null));
      return true;
    }

    _emit(
      _state.copyWith(
        isPurchasing: false,
        errorMessage: 'Subscription product is currently unavailable.',
      ),
    );
    return false;
  }

  @override
  Future<RestorePurchasesResult> restorePurchases() async {
    _emit(_state.copyWith(isLoading: true, errorMessage: null));
    try {
      if (_state.isStoreAvailable) {
        if (!kIsWeb && Platform.isAndroid) {
          _emit(
            _state.copyWith(
              isProSubscribed: false,
              activeSubscriptionProductId: null,
            ),
          );
          await _persistEntitlements();
        }
        _restoreCompleter = Completer<RestorePurchasesResult>();
        await _iap.restorePurchases();

        final result = await _restoreCompleter!.future.timeout(
          const Duration(seconds: 3),
          onTimeout: () => _state.isProSubscribed
              ? RestorePurchasesResult.restored
              : RestorePurchasesResult.nothingToRestore,
        );
        _restoreCompleter = null;
        return result;
      } else {
        await _loadPersistedEntitlements();
        return _state.isProSubscribed
            ? RestorePurchasesResult.restored
            : RestorePurchasesResult.nothingToRestore;
      }
    } catch (e) {
      debugPrint('BillingService restorePurchases error: $e');
      _restoreCompleter = null;
      _emit(_state.copyWith(errorMessage: e.toString()));
      return RestorePurchasesResult.failed;
    } finally {
      _emit(_state.copyWith(isLoading: false));
    }
  }

  @override
  Future<void> mergeUnlockedVehicleIds(Iterable<String> vehicleIds) async {
    if (vehicleIds.isEmpty) return;
    final updated = Set<String>.from(_state.unlockedVehicleIds)
      ..addAll(vehicleIds);
    _emit(_state.copyWith(unlockedVehicleIds: updated));
    await _persistEntitlements();
  }

  Future<void> _handlePurchaseUpdates(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (final purchase in purchaseDetailsList) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _emit(_state.copyWith(isPurchasing: true, errorMessage: null));
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _grantEntitlementForPurchase(purchase);
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          _emit(_state.copyWith(isPurchasing: false, errorMessage: null));
          _completePendingPurchase(true);
          if (purchase.status == PurchaseStatus.restored &&
              _restoreCompleter != null &&
              !_restoreCompleter!.isCompleted) {
            _restoreCompleter!.complete(RestorePurchasesResult.restored);
          }
          break;
        case PurchaseStatus.error:
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          _emit(
            _state.copyWith(
              isPurchasing: false,
              errorMessage:
                  purchase.error?.message ?? 'Purchase failed. Please retry.',
            ),
          );
          _completePendingPurchase(false);
          if (_restoreCompleter != null && !_restoreCompleter!.isCompleted) {
            _restoreCompleter!.complete(RestorePurchasesResult.failed);
          }
          break;
        case PurchaseStatus.canceled:
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          _emit(_state.copyWith(isPurchasing: false));
          _completePendingPurchase(false);
          break;
      }
    }
  }

  Future<void> _grantEntitlementForPurchase(PurchaseDetails purchase) async {
    if (BillingProductIds.subscriptionIds.contains(purchase.productID)) {
      await _activateProSubscription(purchase.productID);
    } else if (purchase.productID == BillingProductIds.vehicleLifetimePass) {
      final targetVehicleId = _pendingVehicleIdForPass;
      if (targetVehicleId != null) {
        await _unlockVehiclePass(targetVehicleId);
        _pendingVehicleIdForPass = null;
      }
    }
  }

  Future<void> _unlockVehiclePass(String vehicleId) async {
    final updated = Set<String>.from(_state.unlockedVehicleIds)..add(vehicleId);
    _emit(_state.copyWith(unlockedVehicleIds: updated));
    await _persistEntitlements();
  }

  Future<void> _activateProSubscription(String productId) async {
    _emit(
      _state.copyWith(
        isProSubscribed: true,
        activeSubscriptionProductId: productId,
      ),
    );
    await _persistEntitlements();
  }

  void _completePendingPurchase(bool result) {
    if (_activePurchaseCompleter != null &&
        !_activePurchaseCompleter!.isCompleted) {
      _activePurchaseCompleter!.complete(result);
    }
    _activePurchaseCompleter = null;
  }

  @override
  bool isDossierUnlockedForVehicle(String vehicleId) =>
      _state.isDossierUnlockedForVehicle(vehicleId);

  @override
  bool canAddVehicle(int currentVehicleCount) =>
      _state.canAddVehicle(currentVehicleCount);

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    _stateController.close();
  }
}
