import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/info_description_box.dart';
import '../controllers/manual_entry_controller.dart';
import '../widgets/manual_entry_add_photo_button.dart';
import '../widgets/manual_entry_attachment_thumbnail.dart';

@RoutePage()
class ManualEntryFormView extends StatefulWidget {
  final String? initialProofType;
  final ServiceRecordModel? record;
  final String? vehicleId;
  final ManualEntryController? controller;

  const ManualEntryFormView({
    super.key,
    this.initialProofType,
    this.record,
    this.vehicleId,
    this.controller,
  });

  @override
  State<ManualEntryFormView> createState() => _ManualEntryFormViewState();
}

class _ManualEntryFormViewState extends State<ManualEntryFormView> {
  final _formKey = GlobalKey<FormState>();
  late final ManualEntryController _controller;

  late final TextEditingController _titleController;
  late final TextEditingController _odometerController;
  late final TextEditingController _partsCostController;
  late final TextEditingController _laborCostController;
  late final TextEditingController _mechanicController;
  late final TextEditingController _oemNumberController;

  bool get _isEditing => widget.record != null;

  double get _partsCostValue =>
      double.tryParse(_partsCostController.text.replaceAll(',', '').trim()) ??
      0.0;

  double get _laborCostValue =>
      double.tryParse(_laborCostController.text.replaceAll(',', '').trim()) ??
      0.0;

  double get _totalCostValue => _partsCostValue + _laborCostValue;

  String _formatAmount(double amount) {
    final intVal = amount.toInt();
    return intVal.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  void _onCostChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? Locator.manualEntryController;
    final existingRecord = widget.record;

    if (existingRecord != null) {
      _controller.initializeForEdit(existingRecord, vehicleId: widget.vehicleId);
      final initialParts = existingRecord.partsCost > 0
          ? existingRecord.partsCost.toInt().toString()
          : (existingRecord.laborCost == 0 && existingRecord.totalCost > 0
                ? existingRecord.totalCost.toInt().toString()
                : '0');
      final initialLabor = existingRecord.laborCost > 0
          ? existingRecord.laborCost.toInt().toString()
          : '0';

      _titleController = TextEditingController(text: existingRecord.title);
      _odometerController = TextEditingController(
        text: existingRecord.mileageKm.toString(),
      );
      _partsCostController = TextEditingController(text: initialParts);
      _laborCostController = TextEditingController(text: initialLabor);
      _mechanicController = TextEditingController(
        text: existingRecord.facilityName,
      );
      _oemNumberController = TextEditingController(
        text: existingRecord.partsOemNumber,
      );
    } else {
      _controller.initializeWithProofType(widget.initialProofType);
      final voiceLog = _controller.consumePendingVoiceLog();

      _titleController = TextEditingController(text: voiceLog?.title ?? '');
      _odometerController = TextEditingController(
        text: voiceLog != null ? voiceLog.odometerKm.toString() : '',
      );
      _partsCostController = TextEditingController(
        text: voiceLog != null && voiceLog.totalCost > 0
            ? voiceLog.totalCost.toInt().toString()
            : '',
      );
      _laborCostController = TextEditingController(text: '');
      _mechanicController = TextEditingController(
        text: voiceLog != null && voiceLog.mechanicName != 'Private Workshop'
            ? voiceLog.mechanicName
            : '',
      );
      _oemNumberController = TextEditingController(text: '');
    }

    _partsCostController.addListener(_onCostChanged);
    _laborCostController.addListener(_onCostChanged);
  }

  @override
  void dispose() {
    _partsCostController.removeListener(_onCostChanged);
    _laborCostController.removeListener(_onCostChanged);
    _titleController.dispose();
    _odometerController.dispose();
    _partsCostController.dispose();
    _laborCostController.dispose();
    _mechanicController.dispose();
    _oemNumberController.dispose();
    super.dispose();
  }

  void _saveRecord() {
    if (_formKey.currentState?.validate() ?? false) {
      final odometer =
          int.tryParse(_odometerController.text.replaceAll(',', '')) ?? 184250;

      if (_isEditing) {
        _controller.updateRecord(
          recordId: widget.record!.id,
          vehicleId: widget.vehicleId,
          title: _titleController.text.trim(),
          mechanicName: _mechanicController.text.trim(),
          partsCost: _partsCostValue,
          laborCost: _laborCostValue,
          odometer: odometer,
          partsOemNumber: _oemNumberController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Service record updated'),
            backgroundColor: AppColors.verified,
          ),
        );
      } else {
        _controller.saveRecord(
          title: _titleController.text.trim(),
          mechanicName: _mechanicController.text.trim(),
          partsCost: _partsCostValue,
          laborCost: _laborCostValue,
          odometer: odometer,
          partsOemNumber: _oemNumberController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Service record saved to timeline feed'),
            backgroundColor: AppColors.verified,
          ),
        );
      }

      context.router.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: TextButton.icon(
          onPressed: () => context.router.maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 14,
            color: AppColors.primaryLight,
          ),
          label: const Text(
            'Back',
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: Text(
          _isEditing ? 'Edit Service Record' : 'New Service Record',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Proof Verification Classification',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Observer(
                builder: (_) => Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _controller.setClassification(
                            ProofClassification.informalMaster,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  _controller.proofClassification ==
                                      ProofClassification.informalMaster
                                  ? AppColors.warningBg
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  _controller.proofClassification ==
                                      ProofClassification.informalMaster
                                  ? Border.all(
                                      color: AppColors.warning,
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_outline_rounded,
                                    size: 14,
                                    color:
                                        _controller.proofClassification ==
                                            ProofClassification.informalMaster
                                        ? AppColors.warning
                                        : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Informal Master Proof',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          _controller.proofClassification ==
                                              ProofClassification.informalMaster
                                          ? AppColors.warning
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _controller.setClassification(
                            ProofClassification.formalStoreReceipt,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  _controller.proofClassification ==
                                      ProofClassification.formalStoreReceipt
                                  ? AppColors.primaryDark
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  _controller.proofClassification ==
                                      ProofClassification.formalStoreReceipt
                                  ? Border.all(
                                      color: AppColors.primaryLight,
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_long_rounded,
                                    size: 14,
                                    color:
                                        _controller.proofClassification ==
                                            ProofClassification
                                                .formalStoreReceipt
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Formal Store Receipt',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          _controller.proofClassification ==
                                              ProofClassification
                                                  .formalStoreReceipt
                                          ? Colors.white
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Observer(
                builder: (_) => InfoDescriptionBox(
                  icon:
                      _controller.proofClassification ==
                          ProofClassification.informalMaster
                      ? Icons.lock_outline_rounded
                      : Icons.receipt_long_rounded,
                  iconColor:
                      _controller.proofClassification ==
                          ProofClassification.informalMaster
                      ? AppColors.warning
                      : AppColors.primaryLight,
                  text:
                      _controller.proofClassification ==
                          ProofClassification.informalMaster
                      ? 'Private Mechanic / Master Repair: Verified through part box photos, car on a lift, or mobile transfer screenshots.'
                      : 'Official Service / Store Receipt: Verified through printed store invoices, OEM part numbers, or official service stamps.',
                ),
              ),
              const SizedBox(height: 18),
              CustomTextField(
                label: 'Service Item / Description',
                isRequired: true,
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                hintText: 'e.g. Front CV Joint & Control Arms',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Service description is required';
                  }
                  return null;
                },
              ),
              Observer(
                builder: (_) {
                  if (_controller.proofClassification !=
                      ProofClassification.formalStoreReceipt) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: CustomTextField(
                      label: 'OEM Part # / Store Invoice No. (Optional)',
                      isRequired: false,
                      controller: _oemNumberController,
                      hintText: 'e.g. OEM 31126794203 or INV-2048',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text.rich(
                TextSpan(
                  text: 'Repair / Maintenance Category',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Observer(
                builder: (_) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ServiceCategory>(
                      isExpanded: true,
                      dropdownColor: AppColors.darkSurface,
                      value: _controller.selectedCategory,
                      items: ServiceCategory.values.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(
                            '${cat.enName} (${cat.hyName})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (cat) {
                        if (cat != null) _controller.setCategory(cat);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Service Date',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Observer(
                          builder: (_) => GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _controller.serviceDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2030),
                              );
                              if (picked != null) {
                                _controller.setDate(picked);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkSurface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.darkBorder),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_controller.serviceDate.day.toString().padLeft(2, '0')}.${_controller.serviceDate.month.toString().padLeft(2, '0')}.${_controller.serviceDate.year}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today_rounded,
                                    size: 16,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: 'Odometer (km)',
                      isRequired: true,
                      controller: _odometerController,
                      keyboardType: TextInputType.number,
                      hintText: '184,250',
                      validator: (value) {
                        final trimmed = value?.replaceAll(',', '').trim() ?? '';
                        if (trimmed.isEmpty) {
                          return 'Odometer is required';
                        }
                        final odo = int.tryParse(trimmed);
                        if (odo == null || odo <= 0) {
                          return 'Enter valid km';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Parts Cost',
                      isRequired: true,
                      controller: _partsCostController,
                      keyboardType: TextInputType.number,
                      hintText: '45,000',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      validator: (value) {
                        final trimmed = value?.replaceAll(',', '').trim() ?? '';
                        if (trimmed.isEmpty) {
                          return 'Parts cost is required';
                        }
                        final cost = double.tryParse(trimmed);
                        if (cost == null || cost < 0) {
                          return 'Enter valid cost';
                        }
                        if (_totalCostValue <= 0) {
                          return 'Total must be > 0';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: 'Labor Cost',
                      isRequired: true,
                      controller: _laborCostController,
                      keyboardType: TextInputType.number,
                      hintText: '20,000',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      validator: (value) {
                        final trimmed = value?.replaceAll(',', '').trim() ?? '';
                        if (trimmed.isEmpty) {
                          return 'Labor cost is required';
                        }
                        final cost = double.tryParse(trimmed);
                        if (cost == null || cost < 0) {
                          return 'Enter valid cost';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Observer(
                builder: (_) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Auto-Calculated Total Cost',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${_controller.selectedCurrency.symbol} ${_formatAmount(_totalCostValue)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [Currency.amd, Currency.usd, Currency.rub]
                            .map((curr) {
                              final isSelected =
                                  _controller.selectedCurrency == curr;
                              return Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: GestureDetector(
                                  onTap: () => _controller.setCurrency(curr),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.darkSurfaceVariant,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primaryLight
                                            : AppColors.darkBorder,
                                      ),
                                    ),
                                    child: Text(
                                      '${curr.code} ${curr.symbol}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) {
                  final isFormal =
                      _controller.proofClassification ==
                      ProofClassification.formalStoreReceipt;
                  return CustomTextField(
                    label: isFormal
                        ? 'Service Center / Store Name'
                        : 'Mechanic / Master Name',
                    isRequired: true,
                    controller: _mechanicController,
                    hintText: isFormal
                        ? 'e.g. Liqui Moly Center / Official Service'
                        : 'e.g. Gago Varpet',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return isFormal
                            ? 'Service center or store name is required'
                            : 'Mechanic / master name is required';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 18),
              const Text(
                'Proof Attachments (Photos / Screenshots)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Observer(
                builder: (_) {
                  final isFormal =
                      _controller.proofClassification ==
                      ProofClassification.formalStoreReceipt;
                  return InfoDescriptionBox(
                    text: isFormal
                        ? 'Upload photos of official store receipts, printed tax invoices, warranty cards, or oil change door stickers.'
                        : 'Upload photos of new part boxes or labels, the car on a service lift, or payment transfer screenshots (Idram, Telcell, bank app).',
                  );
                },
              ),
              const SizedBox(height: 10),
              Observer(
                builder: (_) => Wrap(
                  children: [
                    ..._controller.proofBadges.map((badge) {
                      return ManualEntryAttachmentThumbnail(
                        label: badge,
                        onDelete: () {
                          _controller.removeAttachment(badge);
                        },
                      );
                    }),
                    ManualEntryAddPhotoButton(
                      onTap: () {
                        _controller.addAttachment('Photo Proof');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Photo proof attached'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: const BoxDecoration(
          color: AppColors.darkBackground,
          border: Border(
            top: BorderSide(color: AppColors.darkBorder, width: 1),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _saveRecord,
            child: Text(
              _isEditing
                  ? '✓ Update Service Record'
                  : '✓ Save to Timeline Feed',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
