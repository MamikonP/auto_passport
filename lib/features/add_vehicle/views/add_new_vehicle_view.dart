import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/add_vehicle_controller.dart';

@RoutePage()
class AddNewVehicleView extends StatefulWidget {
  final AddVehicleController? controller;

  const AddNewVehicleView({
    super.key,
    this.controller,
  });

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
    _controller = widget.controller ?? Locator.addVehicleController;

    _vinTextController = TextEditingController(text: _controller.vin);
    _makeTextController = TextEditingController(text: _controller.make);
    _modelTextController = TextEditingController(text: _controller.model);
    _yearTextController = TextEditingController(text: _controller.year.toString());
    _mileageTextController = TextEditingController(text: _controller.mileage.toString());
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

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _controller.setVin(_vinTextController.text.trim());
      _controller.setMake(_makeTextController.text.trim());
      _controller.setModel(_modelTextController.text.trim());
      _controller.setYear(int.tryParse(_yearTextController.text.trim()) ?? 2013);
      _controller.setMileage(int.tryParse(_mileageTextController.text.replaceAll(',', '').trim()) ?? 142000);

      final newVehicle = _controller.submitVehicle();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✓ ${newVehicle.fullName} added to your Garage'),
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
        title: const Text(
          'New Vehicle Setup',
          style: TextStyle(
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
              const Text(
                'VIN / Chassis Number',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _vinTextController,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
                decoration: InputDecoration(
                  fillColor: AppColors.darkSurface,
                  filled: true,
                  hintText: 'e.g. WBA5A7C52FD129482',
                  hintStyle: const TextStyle(color: AppColors.textMuted),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.darkBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.darkBorder),
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
                          'Make',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _makeTextController,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            fillColor: AppColors.darkSurface,
                            filled: true,
                            hintText: 'BMW',
                            hintStyle: const TextStyle(color: AppColors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Model',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _modelTextController,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            fillColor: AppColors.darkSurface,
                            filled: true,
                            hintText: '528i xDrive',
                            hintStyle: const TextStyle(color: AppColors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Year',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _yearTextController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            fillColor: AppColors.darkSurface,
                            filled: true,
                            hintText: '2013',
                            hintStyle: const TextStyle(color: AppColors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fuel / Powertrain',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
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
                                    value: f,
                                    child: Text(
                                      f,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.white, fontSize: 13),
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
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Mileage',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _mileageTextController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            fillColor: AppColors.darkSurface,
                            filled: true,
                            hintText: '142,000',
                            hintStyle: const TextStyle(color: AppColors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.darkBorder),
                            ),
                          ),
                        ),
                      ],
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
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
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
                                    onTap: () => _controller.setDistanceUnit(DistanceUnit.km),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _controller.distanceUnit == DistanceUnit.km
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
                                            color: _controller.distanceUnit == DistanceUnit.km
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
                                    onTap: () => _controller.setDistanceUnit(DistanceUnit.miles),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _controller.distanceUnit == DistanceUnit.miles
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
                                            color: _controller.distanceUnit == DistanceUnit.miles
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
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
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
                              color: isSelected ? AppColors.primary : AppColors.darkSurfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? AppColors.primaryLight : AppColors.darkBorder,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${curr.symbol} ${curr.code}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : AppColors.textSecondary,
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
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Observer(
                builder: (_) => GestureDetector(
                  onTap: () {
                    _controller.togglePhoto();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_controller.photoAdded ? 'Front angle photo attached' : 'Photo removed'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _controller.photoAdded ? AppColors.verified : AppColors.darkBorder,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _controller.photoAdded ? Icons.check_circle_rounded : Icons.camera_alt_outlined,
                          size: 36,
                          color: _controller.photoAdded ? AppColors.verified : AppColors.primaryLight,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _controller.photoAdded ? 'Front Angle Photo Attached ✓' : 'Add Front / Angle Photo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _controller.photoAdded ? AppColors.verified : Colors.white,
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
          border: Border(top: BorderSide(color: AppColors.darkBorder, width: 1)),
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
