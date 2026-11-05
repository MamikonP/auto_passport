// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VehicleRepository on _VehicleRepositoryBase, Store {
  Computed<VehiclePassportModel?>? _$activeVehicleComputed;

  @override
  VehiclePassportModel? get activeVehicle =>
      (_$activeVehicleComputed ??= Computed<VehiclePassportModel?>(
        () => super.activeVehicle,
        name: '_VehicleRepositoryBase.activeVehicle',
      )).value;
  Computed<bool>? _$hasVehiclesComputed;

  @override
  bool get hasVehicles => (_$hasVehiclesComputed ??= Computed<bool>(
    () => super.hasVehicles,
    name: '_VehicleRepositoryBase.hasVehicles',
  )).value;
  Computed<int>? _$totalVehiclesCountComputed;

  @override
  int get totalVehiclesCount => (_$totalVehiclesCountComputed ??= Computed<int>(
    () => super.totalVehiclesCount,
    name: '_VehicleRepositoryBase.totalVehiclesCount',
  )).value;

  late final _$vehiclesAtom = Atom(
    name: '_VehicleRepositoryBase.vehicles',
    context: context,
  );

  @override
  ObservableList<VehiclePassportModel> get vehicles {
    _$vehiclesAtom.reportRead();
    return super.vehicles;
  }

  @override
  set vehicles(ObservableList<VehiclePassportModel> value) {
    _$vehiclesAtom.reportWrite(value, super.vehicles, () {
      super.vehicles = value;
    });
  }

  late final _$activeVehicleIdAtom = Atom(
    name: '_VehicleRepositoryBase.activeVehicleId',
    context: context,
  );

  @override
  String? get activeVehicleId {
    _$activeVehicleIdAtom.reportRead();
    return super.activeVehicleId;
  }

  @override
  set activeVehicleId(String? value) {
    _$activeVehicleIdAtom.reportWrite(value, super.activeVehicleId, () {
      super.activeVehicleId = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_VehicleRepositoryBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadFromDatabaseAsyncAction = AsyncAction(
    '_VehicleRepositoryBase.loadFromDatabase',
    context: context,
  );

  @override
  Future<void> loadFromDatabase() {
    return _$loadFromDatabaseAsyncAction.run(() => super.loadFromDatabase());
  }

  late final _$clearAllAsyncAction = AsyncAction(
    '_VehicleRepositoryBase.clearAll',
    context: context,
  );

  @override
  Future<void> clearAll() {
    return _$clearAllAsyncAction.run(() => super.clearAll());
  }

  late final _$_VehicleRepositoryBaseActionController = ActionController(
    name: '_VehicleRepositoryBase',
    context: context,
  );

  @override
  void setActiveVehicle(String id) {
    final _$actionInfo = _$_VehicleRepositoryBaseActionController.startAction(
      name: '_VehicleRepositoryBase.setActiveVehicle',
    );
    try {
      return super.setActiveVehicle(id);
    } finally {
      _$_VehicleRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addVehicle(VehiclePassportModel vehicle) {
    final _$actionInfo = _$_VehicleRepositoryBaseActionController.startAction(
      name: '_VehicleRepositoryBase.addVehicle',
    );
    try {
      return super.addVehicle(vehicle);
    } finally {
      _$_VehicleRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateVehicle(VehiclePassportModel vehicle) {
    final _$actionInfo = _$_VehicleRepositoryBaseActionController.startAction(
      name: '_VehicleRepositoryBase.updateVehicle',
    );
    try {
      return super.updateVehicle(vehicle);
    } finally {
      _$_VehicleRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteVehicle(String id) {
    final _$actionInfo = _$_VehicleRepositoryBaseActionController.startAction(
      name: '_VehicleRepositoryBase.deleteVehicle',
    );
    try {
      return super.deleteVehicle(id);
    } finally {
      _$_VehicleRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vehicles: ${vehicles},
activeVehicleId: ${activeVehicleId},
isLoading: ${isLoading},
activeVehicle: ${activeVehicle},
hasVehicles: ${hasVehicles},
totalVehiclesCount: ${totalVehiclesCount}
    ''';
  }
}
