import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/info_description_box.dart';
import '../../../l10n/app_localizations.dart';
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
      _controller.initializeForEdit(
        existingRecord,
        vehicleId: widget.vehicleId,
      );
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
      final l10n = AppLocalizations.of(context)!;
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
          SnackBar(
            content: Text(l10n.serviceRecordUpdatedToast),
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
          SnackBar(
            content: Text(l10n.serviceRecordSavedToast),
            backgroundColor: AppColors.verified,
          ),
        );
      }

      context.router.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
          label: Text(
            l10n.back,
            style: const TextStyle(
              color: AppColors.primaryLight,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: Text(
          _isEditing ? l10n.editServiceRecordTitle : l10n.newServiceRecordTitle,
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
              Text(
                l10n.proofVerificationClassification,
                style: const TextStyle(
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
                                  Flexible(
                                    child: Text(
                                      l10n.informalMasterProof,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            _controller.proofClassification ==
                                                ProofClassification
                                                    .informalMaster
                                            ? AppColors.warning
                                            : AppColors.textSecondary,
                                      ),
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
                                  Flexible(
                                    child: Text(
                                      l10n.formalStoreReceipt,
                                      overflow: TextOverflow.ellipsis,
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
                      ? l10n.informalMasterDescription
                      : l10n.formalStoreDescription,
                ),
              ),
              const SizedBox(height: 18),
              CustomTextField(
                label: l10n.serviceItemDescriptionLabel,
                isRequired: true,
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                hintText: l10n.serviceItemHint,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.serviceDescriptionRequiredError;
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
                      label: l10n.oemPartOrInvoiceLabel,
                      isRequired: false,
                      controller: _oemNumberController,
                      hintText: l10n.oemPartOrInvoiceHint,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: l10n.repairMaintenanceCategoryLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  children: const [
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
                        Text.rich(
                          TextSpan(
                            text: l10n.serviceDateLabel,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                            children: const [
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
                      label: l10n.odometerKmLabel,
                      isRequired: true,
                      controller: _odometerController,
                      keyboardType: TextInputType.number,
                      hintText: '184,250',
                      validator: (value) {
                        final trimmed = value?.replaceAll(',', '').trim() ?? '';
                        if (trimmed.isEmpty) {
                          return l10n.odometerRequiredError;
                        }
                        final odo = int.tryParse(trimmed);
                        if (odo == null || odo <= 0) {
                          return l10n.enterValidKmError;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: l10n.partsCostLabel,
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
                          return l10n.partsCostRequiredError;
                        }
                        final cost = double.tryParse(trimmed);
                        if (cost == null || cost < 0) {
                          return l10n.enterValidCostError;
                        }
                        if (_totalCostValue <= 0) {
                          return l10n.totalMustBeGreaterThanZeroError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: l10n.laborCostLabel,
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
                          return l10n.laborCostRequiredError;
                        }
                        final cost = double.tryParse(trimmed);
                        if (cost == null || cost < 0) {
                          return l10n.enterValidCostError;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Observer(
                builder: (_) {
                  final displayCurrency =
                      Locator.settingsRepository.displayCurrency;
                  final showConvertedPreview =
                      _controller.selectedCurrency != displayCurrency &&
                      _totalCostValue > 0;
                  final convertedPreview = showConvertedPreview
                      ? displayCurrency.format(
                          _controller.selectedCurrency.convert(
                            _totalCostValue,
                            to: displayCurrency,
                          ),
                        )
                      : null;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.darkBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                l10n.autoCalculatedTotalCost,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${_controller.selectedCurrency.symbol} ${_formatAmount(_totalCostValue)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                if (convertedPreview != null)
                                  Text(
                                    '≈ $convertedPreview',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryLight,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: Currency.values.map((curr) {
                            final isSelected =
                                _controller.selectedCurrency == curr;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                child: GestureDetector(
                                  onTap: () => _controller.setCurrency(curr),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 9,
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
                                    child: Center(
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
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) {
                  final isFormal =
                      _controller.proofClassification ==
                      ProofClassification.formalStoreReceipt;
                  return CustomTextField(
                    label: isFormal
                        ? l10n.serviceCenterStoreNameLabel
                        : l10n.mechanicMasterNameLabel,
                    isRequired: true,
                    controller: _mechanicController,
                    hintText: isFormal
                        ? l10n.serviceCenterHint
                        : l10n.mechanicNameHint,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return isFormal
                            ? l10n.serviceCenterRequiredError
                            : l10n.mechanicNameRequiredError;
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 18),
              Text(
                l10n.proofAttachmentsLabel,
                style: const TextStyle(
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
                        ? l10n.formalProofAttachmentsInfo
                        : l10n.informalProofAttachmentsInfo,
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
                          SnackBar(
                            content: Text(l10n.photoProofAttachedToast),
                            duration: const Duration(seconds: 1),
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
                  ? l10n.updateServiceRecordButton
                  : l10n.saveToTimelineFeedButton,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
