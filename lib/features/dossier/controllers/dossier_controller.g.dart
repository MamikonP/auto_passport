// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dossier_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DossierController on _DossierControllerBase, Store {
  Computed<VehiclePassportModel?>? _$activeVehicleComputed;

  @override
  VehiclePassportModel? get activeVehicle =>
      (_$activeVehicleComputed ??= Computed<VehiclePassportModel?>(
        () => super.activeVehicle,
        name: '_DossierControllerBase.activeVehicle',
      )).value;
  Computed<bool>? _$hasActiveVehicleComputed;

  @override
  bool get hasActiveVehicle => (_$hasActiveVehicleComputed ??= Computed<bool>(
    () => super.hasActiveVehicle,
    name: '_DossierControllerBase.hasActiveVehicle',
  )).value;
  Computed<String>? _$publicUrlComputed;

  @override
  String get publicUrl => (_$publicUrlComputed ??= Computed<String>(
    () => super.publicUrl,
    name: '_DossierControllerBase.publicUrl',
  )).value;

  late final _$includePartBoxPhotosAtom = Atom(
    name: '_DossierControllerBase.includePartBoxPhotos',
    context: context,
  );

  @override
  bool get includePartBoxPhotos {
    _$includePartBoxPhotosAtom.reportRead();
    return super.includePartBoxPhotos;
  }

  @override
  set includePartBoxPhotos(bool value) {
    _$includePartBoxPhotosAtom.reportWrite(
      value,
      super.includePartBoxPhotos,
      () {
        super.includePartBoxPhotos = value;
      },
    );
  }

  late final _$includeCostTotalsAtom = Atom(
    name: '_DossierControllerBase.includeCostTotals',
    context: context,
  );

  @override
  bool get includeCostTotals {
    _$includeCostTotalsAtom.reportRead();
    return super.includeCostTotals;
  }

  @override
  set includeCostTotals(bool value) {
    _$includeCostTotalsAtom.reportWrite(value, super.includeCostTotals, () {
      super.includeCostTotals = value;
    });
  }

  late final _$watermarkWithVinAtom = Atom(
    name: '_DossierControllerBase.watermarkWithVin',
    context: context,
  );

  @override
  bool get watermarkWithVin {
    _$watermarkWithVinAtom.reportRead();
    return super.watermarkWithVin;
  }

  @override
  set watermarkWithVin(bool value) {
    _$watermarkWithVinAtom.reportWrite(value, super.watermarkWithVin, () {
      super.watermarkWithVin = value;
    });
  }

  late final _$_DossierControllerBaseActionController = ActionController(
    name: '_DossierControllerBase',
    context: context,
  );

  @override
  void toggleIncludePartBoxPhotos(bool? val) {
    final _$actionInfo = _$_DossierControllerBaseActionController.startAction(
      name: '_DossierControllerBase.toggleIncludePartBoxPhotos',
    );
    try {
      return super.toggleIncludePartBoxPhotos(val);
    } finally {
      _$_DossierControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIncludeCostTotals(bool? val) {
    final _$actionInfo = _$_DossierControllerBaseActionController.startAction(
      name: '_DossierControllerBase.toggleIncludeCostTotals',
    );
    try {
      return super.toggleIncludeCostTotals(val);
    } finally {
      _$_DossierControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleWatermarkWithVin(bool? val) {
    final _$actionInfo = _$_DossierControllerBaseActionController.startAction(
      name: '_DossierControllerBase.toggleWatermarkWithVin',
    );
    try {
      return super.toggleWatermarkWithVin(val);
    } finally {
      _$_DossierControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
includePartBoxPhotos: ${includePartBoxPhotos},
includeCostTotals: ${includeCostTotals},
watermarkWithVin: ${watermarkWithVin},
activeVehicle: ${activeVehicle},
hasActiveVehicle: ${hasActiveVehicle},
publicUrl: ${publicUrl}
    ''';
  }
}
