import 'package:flutter/material.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';

class DossierPassportSummaryCard extends StatelessWidget {
  final VehiclePassportModel vehicle;
  final DistanceUnit? displayDistanceUnit;

  const DossierPassportSummaryCard({
    super.key,
    required this.vehicle,
    this.displayDistanceUnit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final includedRecords = vehicle.serviceRecords
        .where((r) => r.includeInDossier)
        .toList();

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
              Expanded(
                child: Text(
                  l10n.officialVehicleHealthPassportHeader,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                  l10n.verifiedEntriesBadge(includedRecords.length),
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
            l10n.vinAndMileageSummary(
              vehicle.maskedVin,
              vehicle.formattedMileageIn(
                displayDistanceUnit ?? vehicle.distanceUnit,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.darkDivider, height: 1),
          const SizedBox(height: 10),
          ...includedRecords.take(3).map((r) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.verified, fontSize: 13)),
                  Expanded(
                    child: Text(
                      '${r.formattedDate}: ${r.title} — ${r.proofBadges.isNotEmpty ? r.proofBadges.first : l10n.loggedFallbackBadge}',
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
