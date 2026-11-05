// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_entry_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManualEntryController on _ManualEntryControllerBase, Store {
  late final _$proofClassificationAtom = Atom(
    name: '_ManualEntryControllerBase.proofClassification',
    context: context,
  );

  @override
  ProofClassification get proofClassification {
    _$proofClassificationAtom.reportRead();
    return super.proofClassification;
  }

  @override
  set proofClassification(ProofClassification value) {
    _$proofClassificationAtom.reportWrite(value, super.proofClassification, () {
      super.proofClassification = value;
    });
  }

  late final _$selectedCategoryAtom = Atom(
    name: '_ManualEntryControllerBase.selectedCategory',
    context: context,
  );

  @override
  ServiceCategory get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(ServiceCategory value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$serviceDateAtom = Atom(
    name: '_ManualEntryControllerBase.serviceDate',
    context: context,
  );

  @override
  DateTime get serviceDate {
    _$serviceDateAtom.reportRead();
    return super.serviceDate;
  }

  @override
  set serviceDate(DateTime value) {
    _$serviceDateAtom.reportWrite(value, super.serviceDate, () {
      super.serviceDate = value;
    });
  }

  late final _$selectedCurrencyAtom = Atom(
    name: '_ManualEntryControllerBase.selectedCurrency',
    context: context,
  );

  @override
  Currency get selectedCurrency {
    _$selectedCurrencyAtom.reportRead();
    return super.selectedCurrency;
  }

  @override
  set selectedCurrency(Currency value) {
    _$selectedCurrencyAtom.reportWrite(value, super.selectedCurrency, () {
      super.selectedCurrency = value;
    });
  }

  late final _$proofBadgesAtom = Atom(
    name: '_ManualEntryControllerBase.proofBadges',
    context: context,
  );

  @override
  ObservableList<String> get proofBadges {
    _$proofBadgesAtom.reportRead();
    return super.proofBadges;
  }

  @override
  set proofBadges(ObservableList<String> value) {
    _$proofBadgesAtom.reportWrite(value, super.proofBadges, () {
      super.proofBadges = value;
    });
  }

  late final _$_ManualEntryControllerBaseActionController = ActionController(
    name: '_ManualEntryControllerBase',
    context: context,
  );

  @override
  void initializeWithProofType(String? proofType) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(
          name: '_ManualEntryControllerBase.initializeWithProofType',
        );
    try {
      return super.initializeWithProofType(proofType);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClassification(ProofClassification val) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.setClassification');
    try {
      return super.setClassification(val);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(ServiceCategory val) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.setCategory');
    try {
      return super.setCategory(val);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDate(DateTime val) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.setDate');
    try {
      return super.setDate(val);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrency(Currency val) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.setCurrency');
    try {
      return super.setCurrency(val);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAttachment(String badge) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.addAttachment');
    try {
      return super.addAttachment(badge);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAttachment(String badge) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.removeAttachment');
    try {
      return super.removeAttachment(badge);
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ServiceRecordModel saveRecord({
    required String title,
    required String mechanicName,
    required double cost,
    required int odometer,
  }) {
    final _$actionInfo = _$_ManualEntryControllerBaseActionController
        .startAction(name: '_ManualEntryControllerBase.saveRecord');
    try {
      return super.saveRecord(
        title: title,
        mechanicName: mechanicName,
        cost: cost,
        odometer: odometer,
      );
    } finally {
      _$_ManualEntryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
proofClassification: ${proofClassification},
selectedCategory: ${selectedCategory},
serviceDate: ${serviceDate},
selectedCurrency: ${selectedCurrency},
proofBadges: ${proofBadges}
    ''';
  }
}
