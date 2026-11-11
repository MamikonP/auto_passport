import 'package:auto_passport/core/enums/camera_permission_status.dart';
import 'package:auto_passport/core/models/ocr_scan_result.dart';
import 'package:flutter/services.dart';


/// Service bridging Flutter with native on-device OCR (Apple Vision on iOS,
/// Google ML Kit Text Recognition on Android) and native camera permissions.
abstract interface class OcrService {
  /// Checks current camera permission status without prompting the user.
  Future<CameraPermissionStatus> checkCameraPermission();

  /// Requests camera permission from the OS if not yet determined.
  Future<CameraPermissionStatus> requestCameraPermission();

  /// Opens the OS application settings page so the user can enable camera access.
  Future<bool> openAppSettings();

  /// Launches the native live camera VIN scanner (supported on iOS physical devices).
  /// Throws [PlatformException] with code `'NO_CAMERA'` or `'USE_CAMERA_CAPTURE'`
  /// when the caller should fall back to standard camera photo capture + [recognizeVinFromImage].
  Future<OcrScanResult?> scanVinWithLiveCamera();

  /// Runs native on-device OCR on the image at [imagePath] and extracts VIN candidates.
  Future<OcrScanResult> recognizeVinFromImage(String imagePath);
}
