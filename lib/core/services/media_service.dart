import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Service responsible for picking or capturing media files (photos) from the device.
class MediaService {
  final ImagePicker _picker;

  MediaService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  /// Picks an image from the specified [source] (camera or gallery).
  /// Returns the selected [XFile] or `null` if cancelled or failed.
  Future<XFile?> pickImageFile({
    required ImageSource source,
    double? maxWidth = 1920,
    double? maxHeight = 1920,
    int? imageQuality = 85,
  }) async {
    try {
      return await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
    } catch (e) {
      debugPrint('MediaService.pickImageFile error: $e');
      return null;
    }
  }

  /// Picks an image from the device photo gallery and returns its file path.
  Future<String?> pickFromGallery({
    double? maxWidth = 1920,
    double? maxHeight = 1920,
    int? imageQuality = 85,
  }) async {
    final file = await pickImageFile(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    return file?.path;
  }

  /// Captures a new photo using the device camera and returns its file path.
  Future<String?> captureFromCamera({
    double? maxWidth = 1920,
    double? maxHeight = 1920,
    int? imageQuality = 85,
  }) async {
    final file = await pickImageFile(
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    return file?.path;
  }
}

