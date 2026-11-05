import 'package:mobx/mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/enums/currency.dart';
import '../../../core/enums/proof_classification.dart';
import '../../../core/enums/service_category.dart';
import '../../../core/models/service_record_model.dart';
import '../../../core/repository/service_record_repository.dart';
import '../../../core/repository/vehicle_repository.dart';
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
  ObservableList<String> proofBadges = ObservableList<String>.of(['Part Box', 'Idram Transfer']);

  @action
  void initializeWithProofType(String? proofType) {
    if (proofType == 'paper_receipt') {
      proofClassification = ProofClassification.formalStoreReceipt;
      proofBadges.clear();
      proofBadges.add('Store Invoice OCR');
    } else {
      proofClassification = ProofClassification.informalMaster;
      proofBadges.clear();
      proofBadges.addAll(['Part Box', 'Idram Transfer']);
    }
  }

  @action
  void setClassification(ProofClassification val) => proofClassification = val;

  @action
  void setCategory(ServiceCategory val) => selectedCategory = val;

  @action
  void setDate(DateTime val) => serviceDate = val;

  @action
  void setCurrency(Currency val) => selectedCurrency = val;

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
    required double cost,
    required int odometer,
  }) {
    final form = ManualEntryFormModel(
      proofClassification: proofClassification,
      title: title,
      category: selectedCategory,
      date: serviceDate,
      odometerKm: odometer,
      totalCost: cost,
      currency: selectedCurrency,
      mechanicName: mechanicName,
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
}
