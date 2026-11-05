import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../controllers/dossier_controller.dart';
import '../widgets/dossier_customization_card.dart';
import '../widgets/dossier_empty_view.dart';
import '../widgets/dossier_passport_summary_card.dart';
import '../widgets/dossier_public_link_card.dart';

@RoutePage()
class DossierHubView extends StatelessWidget {
  final DossierController? controller;

  const DossierHubView({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.dossierController;

    return Observer(
      builder: (context) {
        final vehicle = activeController.activeVehicle;
        final hasVehicle = vehicle != null;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          appBar: AppBar(
            backgroundColor: AppColors.darkBackground,
            elevation: 0,
            centerTitle: false,
            title: const Text(
              'Buyer Resale Dossier',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            actions: [
              if (hasVehicle)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.verifiedBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.verified, width: 1),
                      ),
                      child: const Text(
                        'READY',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: AppColors.verified,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          body: vehicle == null
              ? const DossierEmptyView()
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  children: [
                    DossierPublicLinkCard(publicUrl: activeController.publicUrl),
                    const SizedBox(height: 16),
                    DossierPassportSummaryCard(vehicle: vehicle),
                    const SizedBox(height: 16),
                    DossierCustomizationCard(
                      includePartBoxPhotos: activeController.includePartBoxPhotos,
                      onToggleIncludePartBoxPhotos: activeController.toggleIncludePartBoxPhotos,
                      includeCostTotals: activeController.includeCostTotals,
                      onToggleIncludeCostTotals: activeController.toggleIncludeCostTotals,
                      watermarkWithVin: activeController.watermarkWithVin,
                      onToggleWatermarkWithVin: activeController.toggleWatermarkWithVin,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: AppDimensions.borderRadiusLarge,
                        border: Border.all(color: AppColors.darkBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Lifetime Vehicle Pass',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Unlimited PDF exports for this car',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '\$14.99',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          bottomSheet: hasVehicle
              ? Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  decoration: const BoxDecoration(
                    color: AppColors.darkBackground,
                    border: Border(top: BorderSide(color: AppColors.darkBorder, width: 1)),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.download_rounded, size: 20),
                      label: const Text(
                        'Download Certified PDF Dossier',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✓ Certified PDF Dossier generated and downloaded'),
                            backgroundColor: AppColors.verified,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
