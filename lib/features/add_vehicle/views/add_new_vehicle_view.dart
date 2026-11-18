import 'dart:io';

import 'package:auto_passport/core/models/ocr_scan_result.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/info_description_box.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/add_vehicle_controller.dart';

@RoutePage()
class AddNewVehicleView extends StatefulWidget {
  final VehiclePassportModel? vehicle;

  const AddNewVehicleView({super.key, this.vehicle});

  @override
  State<AddNewVehicleView> createState() => _AddNewVehicleViewState();
}

class _AddNewVehicleViewState extends State<AddNewVehicleView> {
  final _formKey = GlobalKey<FormState>();
  late final AddVehicleController _controller;

  late final TextEditingController _vinTextController;
  late final TextEditingController _makeTextController;
  late final TextEditingController _modelTextController;
  late final TextEditingController _yearTextController;
  late final TextEditingController _mileageTextController;

  bool _isVinScannedFromCamera = false;

  @override
  void initState() {
    super.initState();
    _controller = Locator.addVehicleController;
    if (widget.vehicle != null) {
      _onInitializeVehicle(widget.vehicle!, _controller);
    }

    _vinTextController = TextEditingController(text: _controller.vin);
    _makeTextController = TextEditingController(text: _controller.make);
    _modelTextController = TextEditingController(text: _controller.model);
    _yearTextController = TextEditingController(
      text: _controller.year > 0 ? _controller.year.toString() : '',
    );
    _mileageTextController = TextEditingController(
      text: _controller.mileage > 0 ? _controller.mileage.toString() : '',
    );
  }

  @override
  void dispose() {
    _vinTextController.dispose();
    _makeTextController.dispose();
    _modelTextController.dispose();
    _yearTextController.dispose();
    _mileageTextController.dispose();
    super.dispose();
  }

  void _onInitializeVehicle(
    VehiclePassportModel vehicle,
    AddVehicleController controller,
  ) {
    controller.setVin(vehicle.vin);
    controller.setMake(vehicle.make);
    controller.setModel(vehicle.model);
    controller.setYear(vehicle.year);
    controller.setMileage(vehicle.mileageKm);
    controller.setBodyType(vehicle.bodyType);
    controller.setFuel(vehicle.fuelPowertrain);
    controller.setDistanceUnit(vehicle.distanceUnit);
    controller.setCurrency(vehicle.currency);
    controller.setPhoto(vehicle.photoUrl ?? '');
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final l10n = AppLocalizations.of(context)!;
      _controller.setVin(_vinTextController.text.trim());
      _controller.setMake(_makeTextController.text.trim());
      _controller.setModel(_modelTextController.text.trim());
      _controller.setYear(
        int.tryParse(_yearTextController.text.trim()) ?? 2013,
      );
      _controller.setMileage(
        int.tryParse(_mileageTextController.text.replaceAll(',', '').trim()) ??
            142000,
      );

      if (widget.vehicle == null) {
        final newVehicle = _controller.submitVehicle();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.vehicleAddedToGarageToast(newVehicle.fullName)),
            backgroundColor: AppColors.verified,
          ),
        );
      } else {
        _controller.updateVehicle(widget.vehicle!.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.vehicleUpdatedInGarageToast(_controller.make)),
            backgroundColor: AppColors.pending,
          ),
        );
      }

      context.router.maybePop();
    }
  }

  Future<bool> _ensureCameraAccess() async {
    final status = await _controller.ensureCameraPermission();
    if (status.isGranted) return true;
    if (!mounted) return false;
    final l10n = AppLocalizations.of(context)!;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        title: Text(
          l10n.cameraPermissionRequiredTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          l10n.cameraPermissionRequiredMessage,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _controller.openAppSettings();
            },
            child: Text(l10n.openSettings),
          ),
        ],
      ),
    );
    return false;
  }

  Future<void> _showVinScannerSheet() async {
    final l10n = AppLocalizations.of(context)!;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.darkBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  l10n.scanVehicleVinTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.scanVehicleVinSubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.document_scanner_rounded,
                    color: AppColors.primaryLight,
                  ),
                  title: Text(
                    l10n.scanVinWithCamera,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final allowed = await _ensureCameraAccess();
                    if (!allowed) return;
                    final result = await _controller.scanVinFromCamera();
                    _handleOcrResult(result);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: AppColors.primaryLight,
                  ),
                  title: Text(
                    l10n.scanVinFromPhotoLibrary,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final result = await _controller.scanVinFromGallery();
                    _handleOcrResult(result);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleOcrResult(OcrScanResult? result) {
    if (!mounted || result == null) return;
    final l10n = AppLocalizations.of(context)!;

    if (result.candidates.length > 1) {
      _showVinCandidateSelectionSheet(result.candidates);
      return;
    }

    if (result.hasVin) {
      final detected = result.detectedVin!;
      _vinTextController.text = detected;
      _controller.setVin(detected);
      setState(() {
        _isVinScannedFromCamera = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.vinDetectedToast(detected)),
          backgroundColor: AppColors.verified,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.noVinDetectedToast),
          backgroundColor: AppColors.pending,
        ),
      );
    }
  }

  Future<void> _showVinCandidateSelectionSheet(List<String> candidates) async {
    final l10n = AppLocalizations.of(context)!;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.selectDetectedVinTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ...candidates.take(5).map((candidate) {
                  return ListTile(
                    leading: const Icon(
                      Icons.verified_rounded,
                      color: AppColors.verified,
                    ),
                    title: Text(
                      candidate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    subtitle: Text(
                      candidate.length == 17
                          ? l10n.isoVinSubtitle
                          : l10n.chassisCodeSubtitle(candidate.length),
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      _vinTextController.text = candidate;
                      _controller.setVin(candidate);
                      setState(() {
                        _isVinScannedFromCamera = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.vinAppliedToast(candidate)),
                          backgroundColor: AppColors.verified,
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPhotoPickerSheet() async {
    final l10n = AppLocalizations.of(context)!;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.darkBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  l10n.vehiclePhotoSheetTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primaryLight,
                  ),
                  title: Text(
                    l10n.takePhoto,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final allowed = await _ensureCameraAccess();
                    if (!allowed) return;
                    final path = await _controller.capturePhotoFromCamera();
                    if (path != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.frontAnglePhotoCapturedToast),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: AppColors.primaryLight,
                  ),
                  title: Text(
                    l10n.chooseFromGallery,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final path = await _controller.pickPhotoFromGallery();
                    if (path != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.frontAnglePhotoAttachedToast),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                ),
                if (_controller.photoAdded)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      l10n.removePhoto,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      _controller.removePhoto();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.photoRemovedToast),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: TextButton(
          onPressed: () => context.router.maybePop(),
          child: Text(
            l10n.cancelClose,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 90,
        centerTitle: true,
        title: Text(
          widget.vehicle != null
              ? l10n.editVehicleTitle
              : l10n.newVehicleSetupTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryLight, width: 0.8),
            ),
            child: const Center(
              child: Text(
                '1/2',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: l10n.vinChassisNumberLabel,
                controller: _vinTextController,
                textCapitalization: TextCapitalization.characters,
                hintText: l10n.vinHint,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return l10n.vinRequiredError;
                  }
                  if (trimmed.length < 6) {
                    return l10n.enterValidVinError;
                  }
                  return null;
                },
                suffixIcon: Observer(
                  builder: (_) => GestureDetector(
                    onTap: _controller.isScanningVin
                        ? null
                        : _showVinScannerSheet,
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _controller.isScanningVin
                          ? const Padding(
                              padding: EdgeInsets.all(10),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ),
              if (_isVinScannedFromCamera) ...[
                const SizedBox(height: 8),
                InfoDescriptionBox.warning(
                  text: l10n.scannedVinWarningInfo,
                ),
              ],
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: l10n.make,
                      controller: _makeTextController,
                      hintText: 'BMW',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.makeRequiredError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: l10n.model,
                      controller: _modelTextController,
                      hintText: '528i xDrive',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.modelRequiredError;
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
                      label: l10n.year,
                      controller: _yearTextController,
                      keyboardType: TextInputType.number,
                      hintText: '2013',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                      ],
                      validator: (value) {
                        final trimmed = value?.trim() ?? '';
                        if (trimmed.isEmpty) {
                          return l10n.yearRequiredError;
                        }
                        final year = int.tryParse(trimmed);
                        final maxYear = DateTime.now().year + 1;
                        if (year == null || year < 1900 || year > maxYear) {
                          return l10n.enterValidYearError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.fuelPowertrainLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Observer(
                          builder: (_) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.darkSurface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.darkBorder),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                dropdownColor: AppColors.darkSurface,
                                value: _controller.fuelPowertrain,
                                items: _controller.fuelOptions.map((f) {
                                  return DropdownMenuItem(
                                    value: f.value,
                                    child: Text(
                                      f.value,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) _controller.setFuel(val);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                l10n.bodyTypeLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Observer(
                builder: (_) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: AppColors.darkSurface,
                      value: _controller.bodyType,
                      items: _controller.bodyTypeOptions.map((b) {
                        return DropdownMenuItem(
                          value: b.value,
                          child: Text(
                            b.value,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) _controller.setBodyType(val);
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
                    flex: 3,
                    child: CustomTextField(
                      label: l10n.currentMileageLabel,
                      controller: _mileageTextController,
                      keyboardType: TextInputType.number,
                      hintText: '142,000',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                      ],
                      validator: (value) {
                        final trimmed = value?.replaceAll(',', '').trim() ?? '';
                        if (trimmed.isEmpty) {
                          return l10n.mileageRequiredError;
                        }
                        final mileage = int.tryParse(trimmed);
                        if (mileage == null || mileage <= 0) {
                          return l10n.enterValidMileageError;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.distanceUnitLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Observer(
                          builder: (_) => Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: AppColors.darkSurface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.darkBorder),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _controller.setDistanceUnit(
                                      DistanceUnit.km,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            _controller.distanceUnit ==
                                                DistanceUnit.km
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          l10n.kmUnit,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                _controller.distanceUnit ==
                                                    DistanceUnit.km
                                                ? Colors.white
                                                : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _controller.setDistanceUnit(
                                      DistanceUnit.miles,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            _controller.distanceUnit ==
                                                DistanceUnit.miles
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          l10n.milesUnit,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                _controller.distanceUnit ==
                                                    DistanceUnit.miles
                                                ? Colors.white
                                                : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                l10n.vehicleCostTrackingCurrency,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Observer(
                builder: (_) => Row(
                  children: Currency.values.map((curr) {
                    final isSelected = _controller.currency == curr;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: GestureDetector(
                          onTap: () => _controller.setCurrency(curr),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                                '${curr.symbol} ${curr.code}',
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
              ),
              const SizedBox(height: 18),
              Text(
                l10n.vehiclePhotoOptionalLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Observer(
                builder: (_) {
                  final photoPath = _controller.photoPath;
                  final hasPhoto = _controller.photoAdded;

                  return GestureDetector(
                    onTap: _showPhotoPickerSheet,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: hasPhoto
                              ? AppColors.verified
                              : AppColors.darkBorder,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (photoPath != null && photoPath.isNotEmpty) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(photoPath),
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.check_circle_rounded,
                                  size: 36,
                                  color: AppColors.verified,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ] else ...[
                            Icon(
                              hasPhoto
                                  ? Icons.check_circle_rounded
                                  : Icons.camera_alt_outlined,
                              size: 36,
                              color: hasPhoto
                                  ? AppColors.verified
                                  : AppColors.primaryLight,
                            ),
                            const SizedBox(height: 10),
                          ],
                          Text(
                            hasPhoto
                                ? l10n.frontAnglePhotoAttachedTapToChange
                                : l10n.addFrontAnglePhoto,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: hasPhoto
                                  ? AppColors.verified
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.stampedOnBuyerPdfCover,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
            onPressed: _submit,
            child: Text(
              l10n.saveAndOpenPassportTimeline,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
