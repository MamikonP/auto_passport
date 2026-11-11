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
  final ManualEntryController? controller;

  const ManualEntryFormView({
    super.key,
    this.initialProofType,
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
  late final TextEditingController _costController;
  late final TextEditingController _mechanicController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? Locator.manualEntryController;
    _controller.initializeWithProofType(widget.initialProofType);

    _titleController = TextEditingController(
      text: 'Front CV Joint & Control Arms',
    );
    _odometerController = TextEditingController(text: '');
    _costController = TextEditingController(text: '');
    _mechanicController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _odometerController.dispose();
    _costController.dispose();
    _mechanicController.dispose();
    super.dispose();
  }

  void _saveRecord() {
    if (_formKey.currentState?.validate() ?? false) {
      final cost =
          double.tryParse(_costController.text.replaceAll(',', '')) ?? 0.0;
      final odometer =
          int.tryParse(_odometerController.text.replaceAll(',', '')) ?? 184250;

      _controller.saveRecord(
        title: _titleController.text.trim(),
        mechanicName: _mechanicController.text.trim(),
        cost: cost,
        odometer: odometer,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Service record saved to timeline feed'),
          backgroundColor: AppColors.verified,
        ),
      );

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
        title: const Text(
          'New Service Record',
          style: TextStyle(
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
              const SizedBox(height: 18),
              CustomTextField(
                label: 'Service Item / Description',
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                hintText: 'e.g. Front CV Joint & Control Arms',
              ),
              const SizedBox(height: 16),
              const Text(
                'Repair / Maintenance Category',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
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
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Service Date',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
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
                      controller: _odometerController,
                      keyboardType: TextInputType.number,
                      hintText: '184,250',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Total Cost & Currency',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      controller: _costController,
                      keyboardType: TextInputType.number,
                      hintText: '65,000',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Observer(
                    builder: (_) => Row(
                      children: [Currency.amd, Currency.usd, Currency.rub].map((
                        curr,
                      ) {
                        final isSelected = _controller.selectedCurrency == curr;
                        return Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: GestureDetector(
                            onTap: () => _controller.setCurrency(curr),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
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
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mechanic / Workshop Name',
                controller: _mechanicController,
                hintText: 'e.g. Gago Varpet',
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
              const InfoDescriptionBox(
                text: 'Upload photos of new part boxes or labels, the car on a service lift, paper store receipts, oil change door stickers, or payment transfer screenshots (Idram, Telcell, bank app).',
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
            child: const Text(
              '✓ Save to Timeline Feed',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
