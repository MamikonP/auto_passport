// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_record_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceRecordRepository on _ServiceRecordRepositoryBase, Store {
  late final _$_ServiceRecordRepositoryBaseActionController = ActionController(
    name: '_ServiceRecordRepositoryBase',
    context: context,
  );

  @override
  void addRecord(String vehicleId, ServiceRecordModel record) {
    final _$actionInfo = _$_ServiceRecordRepositoryBaseActionController
        .startAction(name: '_ServiceRecordRepositoryBase.addRecord');
    try {
      return super.addRecord(vehicleId, record);
    } finally {
      _$_ServiceRecordRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRecord(String vehicleId, String recordId) {
    final _$actionInfo = _$_ServiceRecordRepositoryBaseActionController
        .startAction(name: '_ServiceRecordRepositoryBase.deleteRecord');
    try {
      return super.deleteRecord(vehicleId, recordId);
    } finally {
      _$_ServiceRecordRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
