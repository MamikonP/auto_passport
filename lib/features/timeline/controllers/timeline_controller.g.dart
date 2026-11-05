// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimelineController on _TimelineControllerBase, Store {
  Computed<VehiclePassportModel?>? _$activeVehicleComputed;

  @override
  VehiclePassportModel? get activeVehicle =>
      (_$activeVehicleComputed ??= Computed<VehiclePassportModel?>(
        () => super.activeVehicle,
        name: '_TimelineControllerBase.activeVehicle',
      )).value;
  Computed<bool>? _$hasActiveVehicleComputed;

  @override
  bool get hasActiveVehicle => (_$hasActiveVehicleComputed ??= Computed<bool>(
    () => super.hasActiveVehicle,
    name: '_TimelineControllerBase.hasActiveVehicle',
  )).value;
  Computed<int>? _$totalVehiclesCountComputed;

  @override
  int get totalVehiclesCount => (_$totalVehiclesCountComputed ??= Computed<int>(
    () => super.totalVehiclesCount,
    name: '_TimelineControllerBase.totalVehiclesCount',
  )).value;
  Computed<List<TimelineEntryModel>>? _$timelineEntriesComputed;

  @override
  List<TimelineEntryModel> get timelineEntries =>
      (_$timelineEntriesComputed ??= Computed<List<TimelineEntryModel>>(
        () => super.timelineEntries,
        name: '_TimelineControllerBase.timelineEntries',
      )).value;

  late final _$selectedCategoryFilterAtom = Atom(
    name: '_TimelineControllerBase.selectedCategoryFilter',
    context: context,
  );

  @override
  String get selectedCategoryFilter {
    _$selectedCategoryFilterAtom.reportRead();
    return super.selectedCategoryFilter;
  }

  @override
  set selectedCategoryFilter(String value) {
    _$selectedCategoryFilterAtom.reportWrite(
      value,
      super.selectedCategoryFilter,
      () {
        super.selectedCategoryFilter = value;
      },
    );
  }

  late final _$_TimelineControllerBaseActionController = ActionController(
    name: '_TimelineControllerBase',
    context: context,
  );

  @override
  void setCategoryFilter(String category) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
      name: '_TimelineControllerBase.setCategoryFilter',
    );
    try {
      return super.setCategoryFilter(category);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRecord(String recordId) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
      name: '_TimelineControllerBase.deleteRecord',
    );
    try {
      return super.deleteRecord(recordId);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteVehicle(String id) {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
      name: '_TimelineControllerBase.deleteVehicle',
    );
    try {
      return super.deleteVehicle(id);
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteActiveVehicle() {
    final _$actionInfo = _$_TimelineControllerBaseActionController.startAction(
      name: '_TimelineControllerBase.deleteActiveVehicle',
    );
    try {
      return super.deleteActiveVehicle();
    } finally {
      _$_TimelineControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategoryFilter: ${selectedCategoryFilter},
activeVehicle: ${activeVehicle},
hasActiveVehicle: ${hasActiveVehicle},
totalVehiclesCount: ${totalVehiclesCount},
timelineEntries: ${timelineEntries}
    ''';
  }
}
