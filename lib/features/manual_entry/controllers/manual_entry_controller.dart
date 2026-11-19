import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/enums/currency.dart';
import '../../../core/enums/distance_unit.dart';
import '../../../core/enums/proof_classification.dart';
import '../../../core/enums/service_category.dart';
import '../../../core/models/service_record_model.dart';
import '../../../core/repository/service_record_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../../../core/services/voice/voice_log_parser.dart';
import '../models/manual_entry_form_model.dart';

part 'manual_entry_controller.g.dart';

// ignore: library_private_types_in_public_api
class ManualEntryController = _ManualEntryControllerBase with _$ManualEntryController;

abstract class _ManualEntryControllerBase with Store {
  final ServiceRecordRepository _serviceRecordRepository;
  final VehicleRepository _vehicleRepository;

  _ManualEntryControllerBase({
    ServiceRecordRepository? serviceRecordRepository,
    VehicleRepository? vehicleRepository,
  })  : _serviceRecordRepository = serviceRecordRepository ?? Locator.serviceRecordRepository,
        _vehicleRepository = vehicleRepository ?? Locator.vehicleRepository;

  @observable
  ProofClassification proofClassification = ProofClassification.informalMaster;

  @observable
  ServiceCategory selectedCategory = ServiceCategory.suspension;

  @observable
  DateTime serviceDate = DateTime(2026, 10, 24);

  @observable
  Currency selectedCurrency = Currency.amd;

  @observable
  DistanceUnit selectedDistanceUnit = DistanceUnit.km;

  @observable
  ObservableList<String> proofBadges = ObservableList<String>.of(['Part Box', 'Idram Transfer']);

  VoiceParsedServiceLog? _pendingVoiceLog;

  void setPendingVoiceLog(VoiceParsedServiceLog log) {
    _pendingVoiceLog = log;
  }

  VoiceParsedServiceLog? consumePendingVoiceLog() {
    final log = _pendingVoiceLog;
    _pendingVoiceLog = null;
    if (log != null) {
      selectedCategory = log.category;
      selectedCurrency = log.currency;
      serviceDate = DateTime.now();
      if (!proofBadges.contains('Voice Quick Log')) {
        proofBadges.insert(0, 'Voice Quick Log');
      }
    }
    return log;
  }

  @action
  void initializeWithProofType(String? proofType) {
    selectedCurrency = Locator.settingsRepository.displayCurrency;
    selectedDistanceUnit = Locator.settingsRepository.distanceUnit;
    if (proofType == 'paper_receipt') {
      setClassification(ProofClassification.formalStoreReceipt);
    } else {
      setClassification(ProofClassification.informalMaster);
    }
  }

  @action
  void initializeForEdit(ServiceRecordModel record, {String? vehicleId}) {
    proofClassification = record.proofClassification;
    selectedCategory = record.category;
    serviceDate = record.date;
    selectedCurrency = record.currency;
    selectedDistanceUnit = record.distanceUnit;
    proofBadges = ObservableList<String>.of(record.proofBadges);
  }

  @action
  void setClassification(ProofClassification val) {
    proofClassification = val;
    final hasCustomPhoto = proofBadges.contains('Photo Proof');
    proofBadges.clear();
    if (val == ProofClassification.formalStoreReceipt) {
      proofBadges.addAll(['Store Invoice', 'Warranty Stamp']);
    } else {
      proofBadges.addAll(['Part Box', 'Idram Transfer']);
    }
    if (hasCustomPhoto) {
      proofBadges.add('Photo Proof');
    }
  }

  @action
  void setCategory(ServiceCategory val) => selectedCategory = val;

  @action
  void setDate(DateTime val) => serviceDate = val;

  @action
  void setCurrency(Currency val) => selectedCurrency = val;

  @action
  void setDistanceUnit(DistanceUnit val) => selectedDistanceUnit = val;

  @action
  void addAttachment(String badge) {
    if (!proofBadges.contains(badge)) {
      proofBadges.add(badge);
    }
  }

  @action
  void removeAttachment(String badge) {
    proofBadges.remove(badge);
  }

  @action
  ServiceRecordModel saveRecord({
    required String title,
    required String mechanicName,
    required double partsCost,
    required double laborCost,
    required int odometer,
    String partsOemNumber = '',
  }) {
    final form = ManualEntryFormModel(
      proofClassification: proofClassification,
      title: title,
      category: selectedCategory,
      date: serviceDate,
      odometerKm: odometer,
      distanceUnit: selectedDistanceUnit,
      partsCost: partsCost,
      laborCost: laborCost,
      currency: selectedCurrency,
      mechanicName: mechanicName,
      partsOemNumber: partsOemNumber,
      proofBadges: proofBadges.toList(),
    );

    final record = form.toServiceRecord();
    final targetVehicleId = _vehicleRepository.activeVehicleId ??
        (_vehicleRepository.vehicles.isNotEmpty ? _vehicleRepository.vehicles.first.id : null);
    if (targetVehicleId != null) {
      _serviceRecordRepository.addRecord(targetVehicleId, record);
    }
    return record;
  }

  @action
  ServiceRecordModel updateRecord({
    required String recordId,
    String? vehicleId,
    required String title,
    required String mechanicName,
    required double partsCost,
    required double laborCost,
    required int odometer,
    String partsOemNumber = '',
  }) {
    final form = ManualEntryFormModel(
      id: recordId,
      proofClassification: proofClassification,
      title: title,
      category: selectedCategory,
      date: serviceDate,
      odometerKm: odometer,
      distanceUnit: selectedDistanceUnit,
      partsCost: partsCost,
      laborCost: laborCost,
      currency: selectedCurrency,
      mechanicName: mechanicName,
      partsOemNumber: partsOemNumber,
      proofBadges: proofBadges.toList(),
    );

    final updatedRecord = form.toServiceRecord();
    final targetVehicleId =
        vehicleId ??
        _vehicleRepository.activeVehicleId ??
        (_vehicleRepository.vehicles.isNotEmpty
            ? _vehicleRepository.vehicles.first.id
            : null);
    if (targetVehicleId != null) {
      _serviceRecordRepository.updateRecord(targetVehicleId, updatedRecord);
    }
    return updatedRecord;
  }
}
