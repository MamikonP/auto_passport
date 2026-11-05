import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../models/vehicle_model.dart';
import 'status_badge.dart';

class DigitalPassportCard extends StatelessWidget {
  final VehiclePassportModel vehicle;
  final VoidCallback? onTap;

  const DigitalPassportCard({
    super.key,
    required this.vehicle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusLarge,
        boxShadow: isDark ? AppDimensions.cardShadowDark : AppDimensions.cardShadowLight,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppDimensions.borderRadiusLarge,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.metallicCardGradient
                  : const LinearGradient(
                      colors: [Color(0xFFFFFFFF), Color(0xFFF1F5F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: AppDimensions.borderRadiusLarge,
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Passport Chip & Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            gradient: AppColors.cyanGlowGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.directions_car_filled_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          vehicle.id,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: isDark ? AppColors.accent : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    StatusBadge(status: vehicle.status),
                  ],
                ),
                const SizedBox(height: 16),

                // Vehicle Name and Year
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Text(
                        vehicle.fullName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurfaceVariant : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '${vehicle.year}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // VIN Number
                Row(
                  children: [
                    Text(
                      'VIN: ',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        vehicle.vin,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                const Divider(height: 1),
                const SizedBox(height: 12),

                // Bottom stats: License Plate, Mileage, Service records count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // License Plate representation
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFF0F172A), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'AM',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            vehicle.licensePlate,
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Mileage
                    Row(
                      children: [
                        Icon(
                          Icons.speed_rounded,
                          size: 16,
                          color: isDark ? AppColors.accent : AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${vehicle.mileageKm.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} km',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),

                    // Arrow
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
