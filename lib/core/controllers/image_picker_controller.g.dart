// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_picker_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImagePickerController on _ImagePickerControllerBase, Store {
  Computed<bool>? _$hasImageComputed;

  @override
  bool get hasImage => (_$hasImageComputed ??= Computed<bool>(
    () => super.hasImage,
    name: '_ImagePickerControllerBase.hasImage',
  )).value;

  late final _$imagePathAtom = Atom(
    name: '_ImagePickerControllerBase.imagePath',
    context: context,
  );

  @override
  String? get imagePath {
    _$imagePathAtom.reportRead();
    return super.imagePath;
  }

  @override
  set imagePath(String? value) {
    _$imagePathAtom.reportWrite(value, super.imagePath, () {
      super.imagePath = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ImagePickerControllerBase.isLoading',
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

  late final _$pickFromGalleryAsyncAction = AsyncAction(
    '_ImagePickerControllerBase.pickFromGallery',
    context: context,
  );

  @override
  Future<String?> pickFromGallery() {
    return _$pickFromGalleryAsyncAction.run(() => super.pickFromGallery());
  }

  late final _$captureFromCameraAsyncAction = AsyncAction(
    '_ImagePickerControllerBase.captureFromCamera',
    context: context,
  );

  @override
  Future<String?> captureFromCamera() {
    return _$captureFromCameraAsyncAction.run(() => super.captureFromCamera());
  }

  late final _$pickImageAsyncAction = AsyncAction(
    '_ImagePickerControllerBase.pickImage',
    context: context,
  );

  @override
  Future<String?> pickImage(ImageSource source) {
    return _$pickImageAsyncAction.run(() => super.pickImage(source));
  }

  late final _$_ImagePickerControllerBaseActionController = ActionController(
    name: '_ImagePickerControllerBase',
    context: context,
  );

  @override
  void clearImage() {
    final _$actionInfo = _$_ImagePickerControllerBaseActionController
        .startAction(name: '_ImagePickerControllerBase.clearImage');
    try {
      return super.clearImage();
    } finally {
      _$_ImagePickerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imagePath: ${imagePath},
isLoading: ${isLoading},
hasImage: ${hasImage}
    ''';
  }
}
