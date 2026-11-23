import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/billing_paywall_sheet.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/dossier_controller.dart';
import '../widgets/dossier_customization_card.dart';
import '../widgets/dossier_empty_view.dart';
import '../widgets/dossier_passport_summary_card.dart';
import '../widgets/dossier_public_link_card.dart';

@RoutePage()
class DossierHubView extends StatelessWidget {
  final DossierController? controller;

  const DossierHubView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.dossierController;
    final l10n = AppLocalizations.of(context)!;

    return Observer(
      builder: (context) {
        final vehicle = activeController.activeVehicle;
        final hasVehicle = vehicle != null;
        final isUnlocked = activeController.isDossierUnlockedForActiveVehicle;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          appBar: AppBar(
            backgroundColor: AppColors.darkBackground,
            elevation: 0,
            centerTitle: false,
            title: Text(
              l10n.buyerResaleDossierTitle,
              style: const TextStyle(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.verifiedBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.verified, width: 1),
                      ),
                      child: Text(
                        l10n.readyBadge,
                        style: const TextStyle(
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
                    DossierPublicLinkCard(
                      publicUrl: activeController.publicUrl,
                    ),
                    const SizedBox(height: 16),
                    DossierPassportSummaryCard(
                      vehicle: vehicle,
                      displayDistanceUnit: activeController.distanceUnit,
                    ),
                    const SizedBox(height: 16),
                    DossierCustomizationCard(
                      includePartBoxPhotos:
                          activeController.includePartBoxPhotos,
                      onToggleIncludePartBoxPhotos:
                          activeController.toggleIncludePartBoxPhotos,
                      includeCostTotals: activeController.includeCostTotals,
                      onToggleIncludeCostTotals:
                          activeController.toggleIncludeCostTotals,
                      watermarkWithVin: activeController.watermarkWithVin,
                      onToggleWatermarkWithVin:
                          activeController.toggleWatermarkWithVin,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: isUnlocked
                          ? null
                          : () => BillingPaywallSheet.show(
                                context,
                                vehicle: vehicle,
                              ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.darkSurface,
                          borderRadius: AppDimensions.borderRadiusLarge,
                          border: Border.all(
                            color: isUnlocked
                                ? AppColors.verified.withValues(alpha: 0.5)
                                : AppColors.darkBorder,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.lifetimeVehiclePass,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.unlimitedPdfExports,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isUnlocked)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.verifiedBg,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.verified),
                                ),
                                child: Text(
                                  l10n.unlockedBadge,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.verified,
                                  ),
                                ),
                              )
                            else
                              Text(
                                activeController.vehiclePassPrice,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          bottomSheet: hasVehicle
              ? Container(
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
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: activeController.isBusy
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              isUnlocked
                                  ? Icons.download_rounded
                                  : Icons.lock_open_rounded,
                              size: 20,
                            ),
                      label: Text(
                        isUnlocked
                            ? l10n.downloadCertifiedPdfDossier
                            : l10n.unlockAndDownloadPdfButton(
                                activeController.vehiclePassPrice,
                              ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: activeController.isBusy
                          ? null
                          : () async {
                              try {
                                bool canDownload = isUnlocked;
                                if (!canDownload) {
                                  canDownload = await BillingPaywallSheet.show(
                                    context,
                                    vehicle: vehicle,
                                  );
                                }
                                if (!canDownload || !context.mounted) return;

                                final ok = await activeController
                                    .downloadDossierPdf();
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      ok
                                          ? l10n.certifiedPdfGeneratedToast
                                          : l10n.failedToExportPdfDossierToast,
                                    ),
                                    backgroundColor: ok
                                        ? AppColors.verified
                                        : AppColors.error,
                                  ),
                                );
                              } catch (e, stackTrace) {
                                debugPrint(
                                  'Failed to export PDF dossier: $e\n$stackTrace',
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l10n.failedToExportPdfDossierToast,
                                      ),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                }
                              }
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
