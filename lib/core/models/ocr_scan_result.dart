class OcrScanResult {
  final String? detectedVin;
  final List<String> candidates;
  final String fullText;
  final List<String> lines;

  const OcrScanResult({
    this.detectedVin,
    this.candidates = const [],
    this.fullText = '',
    this.lines = const [],
  });

  bool get hasVin => detectedVin != null && detectedVin!.isNotEmpty;
}
