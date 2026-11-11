import 'package:auto_passport/core/enums/camera_permission_status.dart';
import 'package:auto_passport/core/models/ocr_scan_result.dart';
import 'package:auto_passport/core/services/ocr/ocr_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OcrServiceImp implements OcrService {
  static const _methodChannel = MethodChannel('com.auto_passport/ocr');

  @override
  Future<CameraPermissionStatus> checkCameraPermission() async {
    try {
      final raw = await _methodChannel.invokeMethod<String>(
        'checkCameraPermission',
      );
      return CameraPermissionStatus.fromRaw(raw);
    } on PlatformException catch (e) {
      debugPrint('OcrService.checkCameraPermission error: $e');
      return CameraPermissionStatus.denied;
    } on MissingPluginException {
      return CameraPermissionStatus.granted;
    }
  }

  /// Requests camera permission from the OS if not yet determined.
  @override
  Future<CameraPermissionStatus> requestCameraPermission() async {
    try {
      final raw = await _methodChannel.invokeMethod<String>(
        'requestCameraPermission',
      );
      return CameraPermissionStatus.fromRaw(raw);
    } on PlatformException catch (e) {
      debugPrint('OcrService.requestCameraPermission error: $e');
      return CameraPermissionStatus.denied;
    } on MissingPluginException {
      return CameraPermissionStatus.granted;
    }
  }

  /// Opens the OS application settings page so the user can enable camera access.
  @override
  Future<bool> openAppSettings() async {
    try {
      final opened = await _methodChannel.invokeMethod<bool>('openAppSettings');
      return opened ?? false;
    } catch (e) {
      debugPrint('OcrService.openAppSettings error: $e');
      return false;
    }
  }

  /// Launches the native live camera VIN scanner (supported on iOS physical devices).
  /// Throws [PlatformException] with code `'NO_CAMERA'` or `'USE_CAMERA_CAPTURE'`
  /// when the caller should fall back to standard camera photo capture + [recognizeVinFromImage].
  @override
  Future<OcrScanResult?> scanVinWithLiveCamera() async {
    final response = await _methodChannel.invokeMapMethod<String, dynamic>(
      'scanVinWithCamera',
    );
    if (response == null) return null;

    final rawVin = response['vin'] as String?;
    final fullText = response['fullText'] as String? ?? '';
    final rawLines =
        (response['lines'] as List<dynamic>?)?.map((e) => '$e').toList() ??
        const <String>[];

    final candidates = extractVinCandidates(rawLines, fullText);
    final bestVin = rawVin ?? (candidates.isNotEmpty ? candidates.first : null);

    return OcrScanResult(
      detectedVin: bestVin,
      candidates: candidates,
      fullText: fullText,
      lines: rawLines,
    );
  }

  /// Runs native on-device OCR on the image at [imagePath] and extracts VIN candidates.
  @override
  Future<OcrScanResult> recognizeVinFromImage(String imagePath) async {
    try {
      final response = await _methodChannel.invokeMapMethod<String, dynamic>(
        'recognizeText',
        {'imagePath': imagePath},
      );

      if (response == null) {
        return const OcrScanResult();
      }

      final fullText = response['fullText'] as String? ?? '';
      final rawLines =
          (response['lines'] as List<dynamic>?)?.map((e) => '$e').toList() ??
          const <String>[];

      final candidates = extractVinCandidates(rawLines, fullText);

      return OcrScanResult(
        detectedVin: candidates.isNotEmpty ? candidates.first : null,
        candidates: candidates,
        fullText: fullText,
        lines: rawLines,
      );
    } on PlatformException catch (e) {
      debugPrint('OcrService.recognizeVinFromImage error: $e');
      return const OcrScanResult();
    }
  }

  /// Extracts and ranks valid 17-character ISO 3779 VINs (and 9-17 char chassis codes)
  /// from raw OCR text lines, automatically fixing common OCR character lookalikes
  /// (`O` -> `0`, `I` -> `1`, `Q` -> `0`).
  static List<String> extractVinCandidates(
    List<String> lines,
    String fullText,
  ) {
    final strict17Vins = <String>[];
    final fallbackChassisCodes = <String>[];

    final allSources = <String>[...lines, fullText];

    for (final raw in allSources) {
      if (raw.trim().isEmpty) continue;

      // Remove common labels and punctuation while keeping alphanumeric blocks
      final upper = raw
          .toUpperCase()
          .replaceAll(RegExp(r'\b(VIN|CHASSIS|FRAME|NO|NUMBER)\b'), ' ')
          .replaceAll(RegExp(r'[^A-Z0-9\s]'), '');

      final tokens = upper
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      // Also check sliding window of concatenated tokens in case OCR split a 17-char VIN with a space
      final joined = tokens.join();
      final candidateTokens = <String>{...tokens};
      if (joined.length >= 17) {
        for (int i = 0; i <= joined.length - 17; i++) {
          candidateTokens.add(joined.substring(i, i + 17));
        }
      }

      for (final token in candidateTokens) {
        if (token.length == 17) {
          final normalized = token
              .replaceAll('O', '0')
              .replaceAll('I', '1')
              .replaceAll('Q', '0');

          final isValidIsoVin = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$')
              .hasMatch(normalized);
          final hasLetters = RegExp(r'[A-HJ-NPR-Z]').hasMatch(normalized);
          final hasDigits = RegExp(r'[0-9]').hasMatch(normalized);

          if (isValidIsoVin && hasLetters && hasDigits) {
            if (!strict17Vins.contains(normalized)) {
              strict17Vins.add(normalized);
            }
          }
        } else if (token.length >= 9 && token.length <= 16) {
          final hasLetters = RegExp(r'[A-Z]').hasMatch(token);
          final hasDigits = RegExp(r'[0-9]').hasMatch(token);
          if (hasLetters &&
              hasDigits &&
              !fallbackChassisCodes.contains(token)) {
            fallbackChassisCodes.add(token);
          }
        }
      }
    }

    return <String>[...strict17Vins, ...fallbackChassisCodes];
  }
}
