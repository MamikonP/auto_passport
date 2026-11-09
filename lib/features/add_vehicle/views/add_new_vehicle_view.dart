import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
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
            content: Text('✓ ${newVehicle.fullName} added to your Garage'),
            backgroundColor: AppColors.verified,
          ),
        );
      } else {
        _controller.updateVehicle(widget.vehicle!.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✓ ${_controller.make} updated in your Garage'),
            backgroundColor: AppColors.pending,
          ),
        );
      }

      context.router.maybePop();
    }
  }

  Future<void> _showPhotoPickerSheet() async {
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
                const Text(
                  'Vehicle Photo',
                  style: TextStyle(
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
                  title: const Text(
                    'Take Photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final path = await _controller.capturePhotoFromCamera();
                    if (path != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Front angle photo captured'),
                          duration: Duration(seconds: 1),
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
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final path = await _controller.pickPhotoFromGallery();
                    if (path != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Front angle photo attached'),
                          duration: Duration(seconds: 1),
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
                    title: const Text(
                      'Remove Photo',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      _controller.removePhoto();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Photo removed'),
                          duration: Duration(seconds: 1),
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
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: TextButton(
          onPressed: () => context.router.maybePop(),
          child: const Text(
            '✕ Cancel',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 90,
        centerTitle: true,
        title: Text(
          widget.vehicle != null ? 'Edit Vehicle' : 'New Vehicle Setup',
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
                label: 'VIN / Chassis Number',
                controller: _vinTextController,
                textCapitalization: TextCapitalization.characters,
                hintText: 'e.g. WBA5A7C52FD129482',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'VIN / Chassis number is required';
                  }
                  if (trimmed.length < 6) {
                    return 'Enter a valid VIN / chassis number';
                  }
                  return null;
                },
                suffixIcon: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Make',
                      controller: _makeTextController,
                      hintText: 'BMW',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Make is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: 'Model',
                      controller: _modelTextController,
                      hintText: '528i xDrive',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Model is required';
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
                      label: 'Year',
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
                          return 'Year is required';
                        }
                        final year = int.tryParse(trimmed);
                        final maxYear = DateTime.now().year + 1;
                        if (year == null || year < 1900 || year > maxYear) {
                          return 'Enter a valid year';
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
                        const Text(
                          'Fuel / Powertrain',
                          style: TextStyle(
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
              const Text(
                'Body Type',
                style: TextStyle(
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
                      label: 'Current Mileage',
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
                          return 'Mileage is required';
                        }
                        final mileage = int.tryParse(trimmed);
                        if (mileage == null || mileage <= 0) {
                          return 'Enter a valid mileage';
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
                        const Text(
                          'Distance Unit',
                          style: TextStyle(
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
                                          'km',
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
                                          'miles',
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
              const Text(
                'Vehicle Cost Tracking Currency',
                style: TextStyle(
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
              const Text(
                'Vehicle Photo (Optional)',
                style: TextStyle(
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
                                ? 'Front Angle Photo Attached ✓ (Tap to change)'
                                : 'Add Front / Angle Photo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: hasPhoto
                                  ? AppColors.verified
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Will be stamped on the exported buyer PDF cover',
                            style: TextStyle(
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
            child: const Text(
              'Save & Open Passport Timeline →',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
