// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GarageController on _GarageControllerBase, Store {
  Computed<List<GarageItemModel>>? _$garageItemsComputed;

  @override
  List<GarageItemModel> get garageItems =>
      (_$garageItemsComputed ??= Computed<List<GarageItemModel>>(
        () => super.garageItems,
        name: '_GarageControllerBase.garageItems',
      )).value;
  Computed<int>? _$totalVehiclesCountComputed;

  @override
  int get totalVehiclesCount => (_$totalVehiclesCountComputed ??= Computed<int>(
    () => super.totalVehiclesCount,
    name: '_GarageControllerBase.totalVehiclesCount',
  )).value;
  Computed<String?>? _$activeVehicleIdComputed;

  @override
  String? get activeVehicleId =>
      (_$activeVehicleIdComputed ??= Computed<String?>(
        () => super.activeVehicleId,
        name: '_GarageControllerBase.activeVehicleId',
      )).value;

  late final _$_GarageControllerBaseActionController = ActionController(
    name: '_GarageControllerBase',
    context: context,
  );

  @override
  void selectVehicle(String id) {
    final _$actionInfo = _$_GarageControllerBaseActionController.startAction(
      name: '_GarageControllerBase.selectVehicle',
    );
    try {
      return super.selectVehicle(id);
    } finally {
      _$_GarageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteVehicle(String id) {
    final _$actionInfo = _$_GarageControllerBaseActionController.startAction(
      name: '_GarageControllerBase.deleteVehicle',
    );
    try {
      return super.deleteVehicle(id);
    } finally {
      _$_GarageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> clearAll() {
    final _$actionInfo = _$_GarageControllerBaseActionController.startAction(
      name: '_GarageControllerBase.clearAll',
    );
    try {
      return super.clearAll();
    } finally {
      _$_GarageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
garageItems: ${garageItems},
totalVehiclesCount: ${totalVehiclesCount},
activeVehicleId: ${activeVehicleId}
    ''';
  }
}
