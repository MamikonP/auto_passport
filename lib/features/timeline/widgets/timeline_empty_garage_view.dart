import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class TimelineEmptyGarageView extends StatelessWidget {
  final VoidCallback? onRegisterFirstVehicle;

  const TimelineEmptyGarageView({
    super.key,
    this.onRegisterFirstVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.shield_rounded, color: AppColors.primaryLight, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Flexible(
                      child: Text(
                        'AutoPassport',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: AppColors.proBadgeGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
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
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3), width: 1.5),
                  ),
                  child: const Icon(
                    Icons.directions_car_rounded,
                    size: 36,
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Garage is Empty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Register your first vehicle to generate its immutable digital passport and start logging service records.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.add_rounded, size: 20),
                    label: const Text(
                      'Register First Vehicle',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      if (onRegisterFirstVehicle != null) {
                        onRegisterFirstVehicle!();
                      } else {
                        context.router.push(AddNewVehicleRoute());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
