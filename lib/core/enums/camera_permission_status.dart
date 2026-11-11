enum CameraPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  notDetermined;

  bool get isGranted => this == CameraPermissionStatus.granted;

  bool get requiresSettings =>
      this == CameraPermissionStatus.permanentlyDenied ||
      this == CameraPermissionStatus.restricted;

  static CameraPermissionStatus fromRaw(String? raw) {
    switch (raw) {
      case 'granted':
        return CameraPermissionStatus.granted;
      case 'permanentlyDenied':
        return CameraPermissionStatus.permanentlyDenied;
      case 'restricted':
        return CameraPermissionStatus.restricted;
      case 'notDetermined':
        return CameraPermissionStatus.notDetermined;
      case 'denied':
      default:
        return CameraPermissionStatus.denied;
    }
  }
}
