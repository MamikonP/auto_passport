// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_vehicle_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddVehicleController on _AddVehicleControllerBase, Store {
  late final _$vinAtom = Atom(
    name: '_AddVehicleControllerBase.vin',
    context: context,
  );

  @override
  String get vin {
    _$vinAtom.reportRead();
    return super.vin;
  }

  @override
  set vin(String value) {
    _$vinAtom.reportWrite(value, super.vin, () {
      super.vin = value;
    });
  }

  late final _$makeAtom = Atom(
    name: '_AddVehicleControllerBase.make',
    context: context,
  );

  @override
  String get make {
    _$makeAtom.reportRead();
    return super.make;
  }

  @override
  set make(String value) {
    _$makeAtom.reportWrite(value, super.make, () {
      super.make = value;
    });
  }

  late final _$modelAtom = Atom(
    name: '_AddVehicleControllerBase.model',
    context: context,
  );

  @override
  String get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(String value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  late final _$yearAtom = Atom(
    name: '_AddVehicleControllerBase.year',
    context: context,
  );

  @override
  int get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  late final _$fuelPowertrainAtom = Atom(
    name: '_AddVehicleControllerBase.fuelPowertrain',
    context: context,
  );

  @override
  String get fuelPowertrain {
    _$fuelPowertrainAtom.reportRead();
    return super.fuelPowertrain;
  }

  @override
  set fuelPowertrain(String value) {
    _$fuelPowertrainAtom.reportWrite(value, super.fuelPowertrain, () {
      super.fuelPowertrain = value;
    });
  }

  late final _$bodyTypeAtom = Atom(
    name: '_AddVehicleControllerBase.bodyType',
    context: context,
  );

  @override
  String get bodyType {
    _$bodyTypeAtom.reportRead();
    return super.bodyType;
  }

  @override
  set bodyType(String value) {
    _$bodyTypeAtom.reportWrite(value, super.bodyType, () {
      super.bodyType = value;
    });
  }

  late final _$mileageAtom = Atom(
    name: '_AddVehicleControllerBase.mileage',
    context: context,
  );

  @override
  int get mileage {
    _$mileageAtom.reportRead();
    return super.mileage;
  }

  @override
  set mileage(int value) {
    _$mileageAtom.reportWrite(value, super.mileage, () {
      super.mileage = value;
    });
  }

  late final _$distanceUnitAtom = Atom(
    name: '_AddVehicleControllerBase.distanceUnit',
    context: context,
  );

  @override
  DistanceUnit get distanceUnit {
    _$distanceUnitAtom.reportRead();
    return super.distanceUnit;
  }

  @override
  set distanceUnit(DistanceUnit value) {
    _$distanceUnitAtom.reportWrite(value, super.distanceUnit, () {
      super.distanceUnit = value;
    });
  }

  late final _$currencyAtom = Atom(
    name: '_AddVehicleControllerBase.currency',
    context: context,
  );

  @override
  Currency get currency {
    _$currencyAtom.reportRead();
    return super.currency;
  }

  @override
  set currency(Currency value) {
    _$currencyAtom.reportWrite(value, super.currency, () {
      super.currency = value;
    });
  }

  late final _$photoAddedAtom = Atom(
    name: '_AddVehicleControllerBase.photoAdded',
    context: context,
  );

  @override
  bool get photoAdded {
    _$photoAddedAtom.reportRead();
    return super.photoAdded;
  }

  @override
  set photoAdded(bool value) {
    _$photoAddedAtom.reportWrite(value, super.photoAdded, () {
      super.photoAdded = value;
    });
  }

  late final _$photoPathAtom = Atom(
    name: '_AddVehicleControllerBase.photoPath',
    context: context,
  );

  @override
  String? get photoPath {
    _$photoPathAtom.reportRead();
    return super.photoPath;
  }

  @override
  set photoPath(String? value) {
    _$photoPathAtom.reportWrite(value, super.photoPath, () {
      super.photoPath = value;
    });
  }

  late final _$pickPhotoFromGalleryAsyncAction = AsyncAction(
    '_AddVehicleControllerBase.pickPhotoFromGallery',
    context: context,
  );

  @override
  Future<String?> pickPhotoFromGallery() {
    return _$pickPhotoFromGalleryAsyncAction.run(
      () => super.pickPhotoFromGallery(),
    );
  }

  late final _$capturePhotoFromCameraAsyncAction = AsyncAction(
    '_AddVehicleControllerBase.capturePhotoFromCamera',
    context: context,
  );

  @override
  Future<String?> capturePhotoFromCamera() {
    return _$capturePhotoFromCameraAsyncAction.run(
      () => super.capturePhotoFromCamera(),
    );
  }

  late final _$_AddVehicleControllerBaseActionController = ActionController(
    name: '_AddVehicleControllerBase',
    context: context,
  );

  @override
  void setVin(String val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setVin');
    try {
      return super.setVin(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMake(String val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setMake');
    try {
      return super.setMake(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setModel(String val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setModel');
    try {
      return super.setModel(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setYear(int val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setYear');
    try {
      return super.setYear(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFuel(String val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setFuel');
    try {
      return super.setFuel(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBodyType(String val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setBodyType');
    try {
      return super.setBodyType(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMileage(int val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setMileage');
    try {
      return super.setMileage(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDistanceUnit(DistanceUnit val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setDistanceUnit');
    try {
      return super.setDistanceUnit(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrency(Currency val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setCurrency');
    try {
      return super.setCurrency(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoto(String val) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.setPhoto');
    try {
      return super.setPhoto(val);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePhoto() {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.togglePhoto');
    try {
      return super.togglePhoto();
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePhoto() {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.removePhoto');
    try {
      return super.removePhoto();
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  VehiclePassportModel submitVehicle() {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.submitVehicle');
    try {
      return super.submitVehicle();
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateVehicle(String id) {
    final _$actionInfo = _$_AddVehicleControllerBaseActionController
        .startAction(name: '_AddVehicleControllerBase.updateVehicle');
    try {
      return super.updateVehicle(id);
    } finally {
      _$_AddVehicleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vin: ${vin},
make: ${make},
model: ${model},
year: ${year},
fuelPowertrain: ${fuelPowertrain},
bodyType: ${bodyType},
mileage: ${mileage},
distanceUnit: ${distanceUnit},
currency: ${currency},
photoAdded: ${photoAdded},
photoPath: ${photoPath}
    ''';
  }
}
