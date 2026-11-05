// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shell_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShellController on ShellControllerBase, Store {
  Computed<ShellTab>? _$currentTabComputed;

  @override
  ShellTab get currentTab => (_$currentTabComputed ??= Computed<ShellTab>(
    () => super.currentTab,
    name: 'ShellControllerBase.currentTab',
  )).value;

  late final _$currentIndexAtom = Atom(
    name: 'ShellControllerBase.currentIndex',
    context: context,
  );

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$showingGarageAtom = Atom(
    name: 'ShellControllerBase.showingGarage',
    context: context,
  );

  @override
  bool get showingGarage {
    _$showingGarageAtom.reportRead();
    return super.showingGarage;
  }

  @override
  set showingGarage(bool value) {
    _$showingGarageAtom.reportWrite(value, super.showingGarage, () {
      super.showingGarage = value;
    });
  }

  late final _$ShellControllerBaseActionController = ActionController(
    name: 'ShellControllerBase',
    context: context,
  );

  @override
  void setIndex(int index) {
    final _$actionInfo = _$ShellControllerBaseActionController.startAction(
      name: 'ShellControllerBase.setIndex',
    );
    try {
      return super.setIndex(index);
    } finally {
      _$ShellControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openGarage() {
    final _$actionInfo = _$ShellControllerBaseActionController.startAction(
      name: 'ShellControllerBase.openGarage',
    );
    try {
      return super.openGarage();
    } finally {
      _$ShellControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void closeGarage() {
    final _$actionInfo = _$ShellControllerBaseActionController.startAction(
      name: 'ShellControllerBase.closeGarage',
    );
    try {
      return super.closeGarage();
    } finally {
      _$ShellControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleGarage() {
    final _$actionInfo = _$ShellControllerBaseActionController.startAction(
      name: 'ShellControllerBase.toggleGarage',
    );
    try {
      return super.toggleGarage();
    } finally {
      _$ShellControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
showingGarage: ${showingGarage},
currentTab: ${currentTab}
    ''';
  }
}
