import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/di/locator.dart';
import '../../../core/enums/proof_classification.dart';
import '../../../core/models/service_record_model.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/services/voice/voice_log_parser.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/info_description_box.dart';

class VoiceServiceLogSheet extends StatefulWidget {
  const VoiceServiceLogSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const VoiceServiceLogSheet(),
    );
  }

  @override
  State<VoiceServiceLogSheet> createState() => _VoiceServiceLogSheetState();
}

class _VoiceServiceLogSheetState extends State<VoiceServiceLogSheet> {
  final SpeechToText _speechToText = SpeechToText();
  final TextEditingController _transcriptController = TextEditingController();

  bool _speechAvailable = false;
  bool _isListening = false;
  bool _isManualListeningActive = false;
  bool _isRestartingSession = false;
  bool _isInitializing = true;
  bool _isUpdatingFromSpeech = false;
  String _committedText = '';
  String _currentChunk = '';
  String? _statusMessage;
  ServiceRecordModel? _savedRecord;

  late int _defaultMileageKm;
  late VoiceParsedServiceLog _parsedLog;

  static const List<String> _samplePhrases = [
    'Changed front brake pads and rotors at 185000 km for 45000 dram with Master Karen',
    'Engine oil and filter change 186500 km 32000 dram at Liqui Moly',
    'Replaced front shock absorbers at 188000 km for 85000 dram with Gago Varpet',
  ];

  @override
  void initState() {
    super.initState();
    final activeVehicle = Locator.timelineController.activeVehicle;
    _defaultMileageKm = activeVehicle?.mileageKm ?? 184250;
    _parsedLog = VoiceLogParser.parse(
      '',
      defaultOdometerKm: _defaultMileageKm,
    );

    _transcriptController.addListener(_onTranscriptChanged);
    _initSpeech();
  }

  @override
  void dispose() {
    _isManualListeningActive = false;
    _speechToText.stop();
    _transcriptController.removeListener(_onTranscriptChanged);
    _transcriptController.dispose();
    super.dispose();
  }

  void _onTranscriptChanged() {
    if (!_isUpdatingFromSpeech) {
      _committedText = _transcriptController.text.trim();
      _currentChunk = '';
    }
    setState(() {
      _parsedLog = VoiceLogParser.parse(
        _transcriptController.text,
        defaultOdometerKm: _defaultMileageKm,
      );
    });
  }

  void _commitCurrentChunk() {
    if (_currentChunk.trim().isNotEmpty) {
      _committedText = [_committedText, _currentChunk.trim()]
          .where((s) => s.isNotEmpty)
          .join(' ');
      _currentChunk = '';
    }
  }

  Future<void> _initSpeech() async {
    try {
      final available = await _speechToText.initialize(
        onStatus: (status) {
          if (!mounted) return;
          if (status == 'done' || status == 'notListening') {
            if (_isManualListeningActive) {
              _commitCurrentChunk();
              _restartSessionIfActive();
            } else {
              setState(() {
                _isListening = false;
              });
            }
          }
        },
        onError: (errorNotification) {
          if (!mounted) return;
          final msg = errorNotification.errorMsg.toLowerCase();
          final isSilenceTimeout =
              msg.contains('timeout') ||
              msg.contains('no_match') ||
              msg.contains('speech_timeout') ||
              msg.contains('busy');

          if (_isManualListeningActive && isSilenceTimeout) {
            _commitCurrentChunk();
            _restartSessionIfActive();
            return;
          }

          if (!errorNotification.permanent && _isManualListeningActive) {
            _commitCurrentChunk();
            _restartSessionIfActive();
            return;
          }

          setState(() {
            _isManualListeningActive = false;
            _isListening = false;
            _statusMessage =
                'Microphone paused (${errorNotification.errorMsg}). Tap mic to resume or type below.';
          });
        },
      );

      if (!mounted) return;
      setState(() {
        _speechAvailable = available;
        _isInitializing = false;
        if (!available) {
          _statusMessage =
              'Speech recognition is unavailable on this device. You can type or tap a sample phrase below.';
        }
      });

      if (available) {
        await _startListening();
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _speechAvailable = false;
        _isInitializing = false;
        _statusMessage =
            'Could not access microphone. Check microphone permissions or type below.';
      });
    }
  }

  Future<void> _restartSessionIfActive() async {
    if (!_isManualListeningActive || _isRestartingSession || !mounted) return;
    _isRestartingSession = true;
    await Future<void>.delayed(const Duration(milliseconds: 250));
    _isRestartingSession = false;
    if (!mounted || !_isManualListeningActive) return;
    await _startSpeechSession();
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      await _initSpeech();
      return;
    }

    _committedText = _transcriptController.text.trim();
    _currentChunk = '';

    setState(() {
      _statusMessage = null;
      _isManualListeningActive = true;
      _isListening = true;
    });

    await _startSpeechSession();
  }

  Future<void> _startSpeechSession() async {
    if (!_isManualListeningActive || !mounted) return;
    try {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        // ignore: deprecated_member_use
        listenFor: const Duration(minutes: 10),
        // ignore: deprecated_member_use
        pauseFor: const Duration(minutes: 2),
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: false,
          listenMode: ListenMode.dictation,
        ),
      );
    } catch (_) {
      // Ignore transient restart errors while keeping manual listening active
    }
  }

  Future<void> _stopListening() async {
    _isManualListeningActive = false;
    _commitCurrentChunk();
    await _speechToText.stop();
    if (!mounted) return;
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted || !_isManualListeningActive) return;

    _currentChunk = result.recognizedWords.trim();
    final combined = [_committedText, _currentChunk]
        .where((s) => s.isNotEmpty)
        .join(' ');

    _isUpdatingFromSpeech = true;
    _transcriptController.text = combined;
    _transcriptController.selection = TextSelection.fromPosition(
      TextPosition(offset: _transcriptController.text.length),
    );
    _isUpdatingFromSpeech = false;

    if (result.finalResult) {
      _commitCurrentChunk();
      _restartSessionIfActive();
    }
  }

  void _saveVoiceLogDirectly() {
    _stopListening();
    final manualController = Locator.manualEntryController;
    manualController.setClassification(ProofClassification.informalMaster);
    manualController.setCategory(_parsedLog.category);
    manualController.setCurrency(_parsedLog.currency);
    manualController.setDate(DateTime.now());
    manualController.addAttachment('Voice Quick Log');

    final created = manualController.saveRecord(
      title: _parsedLog.title,
      mechanicName: _parsedLog.mechanicName,
      cost: _parsedLog.totalCost,
      odometer: _parsedLog.odometerKm,
    );

    setState(() {
      _savedRecord = created;
    });
  }

  void _openInManualForm() {
    _stopListening();
    final manualController = Locator.manualEntryController;
    manualController.setPendingVoiceLog(_parsedLog);
    Navigator.of(context).pop();
    context.router.push(ManualEntryFormRoute());
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusExtraLarge),
          topRight: Radius.circular(AppDimensions.radiusExtraLarge),
        ),
        border: Border(
          top: BorderSide(color: AppColors.darkBorder, width: 1.5),
          left: BorderSide(color: AppColors.darkBorder, width: 1.5),
          right: BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + bottomInset),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: _savedRecord != null
              ? _buildSavedConfirmationView(context, _savedRecord!)
              : _buildVoiceCaptureView(context),
        ),
      ),
    );
  }

  Widget _buildSavedConfirmationView(
    BuildContext context,
    ServiceRecordModel record,
  ) {
    final vehicleId = Locator.timelineController.activeVehicle?.id;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.darkBorder,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.verifiedBg,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.verified, width: 2),
          ),
          child: const Icon(
            Icons.check_rounded,
            color: AppColors.verified,
            size: 34,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Service Log Added to Timeline!',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Your voice note was parsed and saved to your vehicle history:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkSurfaceVariant,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.verified.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      record.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    record.formattedCost(_parsedLog.currency),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.verified,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${record.category.enName} • ${_formatNumber(record.mileageKm)} km • ${record.facilityName}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.darkBorder),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.router.push(
                    RecordDetailRoute(
                      recordId: record.id,
                      vehicleId: vehicleId,
                    ),
                  );
                },
                child: const Text(
                  'View Breakdown',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.verified,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Done',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVoiceCaptureView(BuildContext context) {
    final hasTranscript = _parsedLog.hasMeaningfulInput;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.darkBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voice Quick Log',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Speak your repair details (service, mileage, cost & master)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Microphone Trigger Banner
        Center(
          child: GestureDetector(
            onTap: _isListening ? _stopListening : _startListening,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: BoxDecoration(
                color: _isListening
                    ? const Color(0xFF3B0764)
                    : AppColors.darkSurfaceVariant,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: _isListening
                      ? const Color(0xFFA855F7)
                      : AppColors.primaryLight,
                  width: 1.5,
                ),
                boxShadow: _isListening
                    ? [
                        BoxShadow(
                          color: const Color(0xFFA855F7).withValues(alpha: 0.35),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isListening ? Icons.stop_circle_rounded : Icons.mic_rounded,
                    color: _isListening
                        ? const Color(0xFFD8B4FE)
                        : AppColors.primaryLight,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _isInitializing
                        ? 'Initializing microphone...'
                        : (_isListening
                              ? 'Listening... Tap to stop'
                              : 'Tap to speak service details'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),

        if (_statusMessage != null) ...[
          InfoDescriptionBox.warning(text: _statusMessage!),
          const SizedBox(height: 12),
        ],

        // Editable Live Transcript Box
        TextField(
          controller: _transcriptController,
          maxLines: 2,
          minLines: 2,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkBackground,
            hintText:
                'e.g. "Changed front brake pads at 185,000 km for 45,000 dram with Master Karen"',
            hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: hasTranscript
                ? IconButton(
                    icon: const Icon(
                      Icons.clear_rounded,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () => _transcriptController.clear(),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.darkBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.darkBorder),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Quick Sample Chips for easy testing / 1-tap demo
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _samplePhrases.map((phrase) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  backgroundColor: AppColors.darkSurfaceVariant,
                  side: const BorderSide(color: AppColors.darkBorder),
                  label: Text(
                    phrase.length > 38 ? '${phrase.substring(0, 38)}…' : phrase,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onPressed: () {
                    _transcriptController.text = phrase;
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Live Parsed Preview Card
        const Text(
          'AUTO-PARSED SERVICE LOG PREVIEW',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.7,
            color: AppColors.primaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.darkSurfaceVariant,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasTranscript
                  ? AppColors.primaryLight.withValues(alpha: 0.6)
                  : AppColors.darkBorder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _parsedLog.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B0764),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFFA855F7),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      _parsedLog.category.enName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFD8B4FE),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildPreviewMetric(
                      label: 'Cost',
                      value:
                          '${_parsedLog.currency.symbol} ${_formatNumber(_parsedLog.totalCost.toInt())}',
                    ),
                  ),
                  Expanded(
                    child: _buildPreviewMetric(
                      label: 'Odometer',
                      value: '${_formatNumber(_parsedLog.odometerKm)} km',
                    ),
                  ),
                  Expanded(
                    child: _buildPreviewMetric(
                      label: 'Workshop',
                      value: _parsedLog.mechanicName,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Bottom Actions: Edit in Form vs 1-Tap Save
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.darkBorder),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.tune_rounded, size: 17),
                label: const Text(
                  'Edit in Form',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                onPressed: _openInManualForm,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                label: const Text(
                  'Confirm & Add Log',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                onPressed: hasTranscript ? _saveVoiceLogDirectly : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreviewMetric({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
