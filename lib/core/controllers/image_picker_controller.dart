import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../di/locator.dart';
import '../services/media_service.dart';

part 'image_picker_controller.g.dart';

// ignore: library_private_types_in_public_api
class ImagePickerController = _ImagePickerControllerBase
    with _$ImagePickerController;

abstract class _ImagePickerControllerBase with Store {
  final MediaService _mediaService;

  _ImagePickerControllerBase({MediaService? mediaService})
    : _mediaService = mediaService ?? Locator.mediaService;

  @observable
  String? imagePath;

  @observable
  bool isLoading = false;

  @computed
  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  @action
  Future<String?> pickFromGallery() async {
    isLoading = true;
    try {
      final path = await _mediaService.pickFromGallery();
      if (path != null) {
        imagePath = path;
      }
      return path;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<String?> captureFromCamera() async {
    isLoading = true;
    try {
      final path = await _mediaService.captureFromCamera();
      if (path != null) {
        imagePath = path;
      }
      return path;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<String?> pickImage(ImageSource source) async {
    return source == ImageSource.camera
        ? captureFromCamera()
        : pickFromGallery();
  }

  @action
  void clearImage() {
    imagePath = null;
  }
}

