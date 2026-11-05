import 'package:flutter/material.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class DossierPassportSummaryCard extends StatelessWidget {
  final VehiclePassportModel vehicle;

  const DossierPassportSummaryCard({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'OFFICIAL VEHICLE HEALTH PASSPORT',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.verifiedBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'VERIFIED (${vehicle.verifiedRecordsCount} ENTRIES)',
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: AppColors.verified,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'VIN: ${vehicle.maskedVin}  •  Mileage: ${vehicle.formattedMileage}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.darkDivider, height: 1),
          const SizedBox(height: 10),
          ...vehicle.serviceRecords.take(3).map((r) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.verified, fontSize: 13)),
                  Expanded(
                    child: Text(
                      '${r.formattedDate}: ${r.title} — ${r.proofBadges.isNotEmpty ? r.proofBadges.first : "Logged"}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE2E8F0),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
