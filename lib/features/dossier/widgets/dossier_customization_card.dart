import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';

class DossierCustomizationCard extends StatelessWidget {
  final bool includePartBoxPhotos;
  final ValueChanged<bool?> onToggleIncludePartBoxPhotos;
  final bool includeCostTotals;
  final ValueChanged<bool?> onToggleIncludeCostTotals;
  final bool watermarkWithVin;
  final ValueChanged<bool?> onToggleWatermarkWithVin;

  const DossierCustomizationCard({
    super.key,
    required this.includePartBoxPhotos,
    required this.onToggleIncludePartBoxPhotos,
    required this.includeCostTotals,
    required this.onToggleIncludeCostTotals,
    required this.watermarkWithVin,
    required this.onToggleWatermarkWithVin,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.borderRadiusLarge,
        side: BorderSide(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          CheckboxListTile(
            activeColor: AppColors.primary,
            title: Text(
              l10n.includePartBoxPhotos,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            value: includePartBoxPhotos,
            onChanged: onToggleIncludePartBoxPhotos,
          ),
          const Divider(color: AppColors.darkDivider, height: 1),
          CheckboxListTile(
            activeColor: AppColors.primary,
            title: Text(
              l10n.includeCostCurrencyTotals,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            value: includeCostTotals,
            onChanged: onToggleIncludeCostTotals,
          ),
          const Divider(color: AppColors.darkDivider, height: 1),
          CheckboxListTile(
            activeColor: AppColors.primary,
            title: Text(
              l10n.watermarkWithVin,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            value: watermarkWithVin,
            onChanged: onToggleWatermarkWithVin,
          ),
        ],
      ),
    );
  }
}
