import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class DossierEmptyView extends StatelessWidget {
  final VoidCallback? onAddVehicle;

  const DossierEmptyView({
    super.key,
    this.onAddVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.darkBorder),
            boxShadow: AppDimensions.cardShadowDark,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryLight.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: 34,
                  color: AppColors.primaryLight,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'No Vehicle Selected',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add a car to your garage to generate a certified buyer dossier and shareable public link.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text(
                    'Add Vehicle to Garage',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    if (onAddVehicle != null) {
                      onAddVehicle!();
                    } else {
                      context.router.push(AddNewVehicleRoute());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
