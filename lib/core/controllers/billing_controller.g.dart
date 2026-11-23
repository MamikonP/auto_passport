// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BillingController on _BillingControllerBase, Store {
  Computed<bool>? _$isStoreAvailableComputed;

  @override
  bool get isStoreAvailable => (_$isStoreAvailableComputed ??= Computed<bool>(
    () => super.isStoreAvailable,
    name: '_BillingControllerBase.isStoreAvailable',
  )).value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_BillingControllerBase.isLoading',
  )).value;
  Computed<bool>? _$isPurchasingComputed;

  @override
  bool get isPurchasing => (_$isPurchasingComputed ??= Computed<bool>(
    () => super.isPurchasing,
    name: '_BillingControllerBase.isPurchasing',
  )).value;
  Computed<bool>? _$isProSubscribedComputed;

  @override
  bool get isProSubscribed => (_$isProSubscribedComputed ??= Computed<bool>(
    () => super.isProSubscribed,
    name: '_BillingControllerBase.isProSubscribed',
  )).value;
  Computed<String?>? _$activeSubscriptionProductIdComputed;

  @override
  String? get activeSubscriptionProductId =>
      (_$activeSubscriptionProductIdComputed ??= Computed<String?>(
        () => super.activeSubscriptionProductId,
        name: '_BillingControllerBase.activeSubscriptionProductId',
      )).value;
  Computed<Set<String>>? _$unlockedVehicleIdsComputed;

  @override
  Set<String> get unlockedVehicleIds =>
      (_$unlockedVehicleIdsComputed ??= Computed<Set<String>>(
        () => super.unlockedVehicleIds,
        name: '_BillingControllerBase.unlockedVehicleIds',
      )).value;
  Computed<String>? _$vehiclePassPriceComputed;

  @override
  String get vehiclePassPrice =>
      (_$vehiclePassPriceComputed ??= Computed<String>(
        () => super.vehiclePassPrice,
        name: '_BillingControllerBase.vehiclePassPrice',
      )).value;
  Computed<String>? _$proMonthlyPriceComputed;

  @override
  String get proMonthlyPrice => (_$proMonthlyPriceComputed ??= Computed<String>(
    () => super.proMonthlyPrice,
    name: '_BillingControllerBase.proMonthlyPrice',
  )).value;
  Computed<String>? _$proYearlyPriceComputed;

  @override
  String get proYearlyPrice => (_$proYearlyPriceComputed ??= Computed<String>(
    () => super.proYearlyPrice,
    name: '_BillingControllerBase.proYearlyPrice',
  )).value;
  Computed<String?>? _$errorMessageComputed;

  @override
  String? get errorMessage => (_$errorMessageComputed ??= Computed<String?>(
    () => super.errorMessage,
    name: '_BillingControllerBase.errorMessage',
  )).value;

  late final _$billingStateAtom = Atom(
    name: '_BillingControllerBase.billingState',
    context: context,
  );

  @override
  BillingStateModel get billingState {
    _$billingStateAtom.reportRead();
    return super.billingState;
  }

  @override
  set billingState(BillingStateModel value) {
    _$billingStateAtom.reportWrite(value, super.billingState, () {
      super.billingState = value;
    });
  }

  late final _$initAsyncAction = AsyncAction(
    '_BillingControllerBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$purchaseVehiclePassAsyncAction = AsyncAction(
    '_BillingControllerBase.purchaseVehiclePass',
    context: context,
  );

  @override
  Future<bool> purchaseVehiclePass(String vehicleId) {
    return _$purchaseVehiclePassAsyncAction.run(
      () => super.purchaseVehiclePass(vehicleId),
    );
  }

  late final _$purchaseProSubscriptionAsyncAction = AsyncAction(
    '_BillingControllerBase.purchaseProSubscription',
    context: context,
  );

  @override
  Future<bool> purchaseProSubscription({bool yearly = false}) {
    return _$purchaseProSubscriptionAsyncAction.run(
      () => super.purchaseProSubscription(yearly: yearly),
    );
  }

  late final _$restorePurchasesAsyncAction = AsyncAction(
    '_BillingControllerBase.restorePurchases',
    context: context,
  );

  @override
  Future<RestorePurchasesResult> restorePurchases() {
    return _$restorePurchasesAsyncAction.run(() => super.restorePurchases());
  }

  late final _$mergeUnlockedVehicleIdsAsyncAction = AsyncAction(
    '_BillingControllerBase.mergeUnlockedVehicleIds',
    context: context,
  );

  @override
  Future<void> mergeUnlockedVehicleIds(Iterable<String> vehicleIds) {
    return _$mergeUnlockedVehicleIdsAsyncAction.run(
      () => super.mergeUnlockedVehicleIds(vehicleIds),
    );
  }

  late final _$_BillingControllerBaseActionController = ActionController(
    name: '_BillingControllerBase',
    context: context,
  );

  @override
  void _onStateUpdate(BillingStateModel next) {
    final _$actionInfo = _$_BillingControllerBaseActionController.startAction(
      name: '_BillingControllerBase._onStateUpdate',
    );
    try {
      return super._onStateUpdate(next);
    } finally {
      _$_BillingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
billingState: ${billingState},
isStoreAvailable: ${isStoreAvailable},
isLoading: ${isLoading},
isPurchasing: ${isPurchasing},
isProSubscribed: ${isProSubscribed},
activeSubscriptionProductId: ${activeSubscriptionProductId},
unlockedVehicleIds: ${unlockedVehicleIds},
vehiclePassPrice: ${vehiclePassPrice},
proMonthlyPrice: ${proMonthlyPrice},
proYearlyPrice: ${proYearlyPrice},
errorMessage: ${errorMessage}
    ''';
  }
}
