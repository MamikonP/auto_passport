// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecordDetailController on _RecordDetailControllerBase, Store {
  late final _$isIncludedInDossierAtom = Atom(
    name: '_RecordDetailControllerBase.isIncludedInDossier',
    context: context,
  );

  @override
  bool get isIncludedInDossier {
    _$isIncludedInDossierAtom.reportRead();
    return super.isIncludedInDossier;
  }

  @override
  set isIncludedInDossier(bool value) {
    _$isIncludedInDossierAtom.reportWrite(value, super.isIncludedInDossier, () {
      super.isIncludedInDossier = value;
    });
  }

  late final _$isEditModeAtom = Atom(
    name: '_RecordDetailControllerBase.isEditMode',
    context: context,
  );

  @override
  bool get isEditMode {
    _$isEditModeAtom.reportRead();
    return super.isEditMode;
  }

  @override
  set isEditMode(bool value) {
    _$isEditModeAtom.reportWrite(value, super.isEditMode, () {
      super.isEditMode = value;
    });
  }

  late final _$_RecordDetailControllerBaseActionController = ActionController(
    name: '_RecordDetailControllerBase',
    context: context,
  );

  @override
  void toggleIncludedInDossier() {
    final _$actionInfo = _$_RecordDetailControllerBaseActionController
        .startAction(
          name: '_RecordDetailControllerBase.toggleIncludedInDossier',
        );
    try {
      return super.toggleIncludedInDossier();
    } finally {
      _$_RecordDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleEditMode() {
    final _$actionInfo = _$_RecordDetailControllerBaseActionController
        .startAction(name: '_RecordDetailControllerBase.toggleEditMode');
    try {
      return super.toggleEditMode();
    } finally {
      _$_RecordDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRecord(String recordId, {String? vehicleId}) {
    final _$actionInfo = _$_RecordDetailControllerBaseActionController
        .startAction(name: '_RecordDetailControllerBase.deleteRecord');
    try {
      return super.deleteRecord(recordId, vehicleId: vehicleId);
    } finally {
      _$_RecordDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isIncludedInDossier: ${isIncludedInDossier},
isEditMode: ${isEditMode}
    ''';
  }
}
