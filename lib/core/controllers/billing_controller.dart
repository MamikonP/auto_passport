import 'dart:async';

import 'package:mobx/mobx.dart';

import '../di/locator.dart';
import '../models/billing_state_model.dart';
import '../services/billing_service/billing_service.dart';

part 'billing_controller.g.dart';

// ignore: library_private_types_in_public_api
class BillingController = _BillingControllerBase with _$BillingController;

abstract class _BillingControllerBase with Store {
  final BillingService _billingService;
  StreamSubscription<BillingStateModel>? _subscription;

  _BillingControllerBase({BillingService? billingService})
    : _billingService = billingService ?? Locator.billingService {
    billingState = _billingService.currentState;
    _subscription = _billingService.stateStream.listen(_onStateUpdate);
  }

  @observable
  BillingStateModel billingState = const BillingStateModel();

  @computed
  bool get isStoreAvailable => billingState.isStoreAvailable;

  @computed
  bool get isLoading => billingState.isLoading;

  @computed
  bool get isPurchasing => billingState.isPurchasing;

  @computed
  bool get isProSubscribed => billingState.isProSubscribed;

  @computed
  String? get activeSubscriptionProductId =>
      billingState.activeSubscriptionProductId;

  @computed
  Set<String> get unlockedVehicleIds => billingState.unlockedVehicleIds;

  @computed
  String get vehiclePassPrice => billingState.vehiclePassPrice;

  @computed
  String get proMonthlyPrice => billingState.proMonthlyPrice;

  @computed
  String get proYearlyPrice => billingState.proYearlyPrice;

  @computed
  String? get errorMessage => billingState.errorMessage;

  @action
  void _onStateUpdate(BillingStateModel next) {
    billingState = next;
  }

  @action
  Future<void> init() async {
    await _billingService.init();
    billingState = _billingService.currentState;
  }

  @action
  Future<bool> purchaseVehiclePass(String vehicleId) async {
    final result = await _billingService.purchaseVehiclePass(vehicleId);
    billingState = _billingService.currentState;
    return result;
  }

  @action
  Future<bool> purchaseProSubscription({bool yearly = false}) async {
    final result = await _billingService.purchaseProSubscription(
      yearly: yearly,
    );
    billingState = _billingService.currentState;
    return result;
  }

  @action
  Future<RestorePurchasesResult> restorePurchases() async {
    final result = await _billingService.restorePurchases();
    billingState = _billingService.currentState;
    return result;
  }

  @action
  Future<void> mergeUnlockedVehicleIds(Iterable<String> vehicleIds) async {
    await _billingService.mergeUnlockedVehicleIds(vehicleIds);
    billingState = _billingService.currentState;
  }

  bool get hasOnlyPerCarPasses =>
      !isProSubscribed && unlockedVehicleIds.isNotEmpty;

  bool isDossierUnlockedForVehicle(String vehicleId) =>
      billingState.isDossierUnlockedForVehicle(vehicleId);

  bool canAddVehicle(int currentVehicleCount) =>
      billingState.canAddVehicle(currentVehicleCount);

  void dispose() {
    _subscription?.cancel();
  }
}
