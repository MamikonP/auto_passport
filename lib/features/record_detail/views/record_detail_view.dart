import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/enums/proof_classification.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/record_detail_controller.dart';
import '../widgets/record_facility_card.dart';
import '../widgets/record_investment_card.dart';
import '../widgets/record_verification_card.dart';

@RoutePage()
class RecordDetailView extends StatelessWidget {
  final String recordId;
  final String? vehicleId;
  final RecordDetailController? controller;

  const RecordDetailView({
    super.key,
    required this.recordId,
    this.vehicleId,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.recordDetailController;
    final l10n = AppLocalizations.of(context)!;

    return Observer(
      builder: (_) {
        final breakdown = activeController.getRecordDetail(
          recordId,
          vehicleId: vehicleId,
        );
        final record = breakdown.record;

        Future<void> handleDelete() async {
          final confirmed = await AppConfirmationDialog.show(
            context: context,
            title: l10n.deleteServiceRecordTitle,
            message: l10n.deleteRecordLongMessage(record.title),
            confirmText: l10n.deleteRecordConfirmButton,
            cancelText: l10n.cancel,
            isDestructive: true,
            icon: Icons.delete_outline_rounded,
          );

          if (confirmed && context.mounted) {
            activeController.deleteRecord(record.id, vehicleId: vehicleId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.serviceRecordDeletedToast),
                backgroundColor: AppColors.error,
                duration: const Duration(seconds: 2),
              ),
            );
            context.router.maybePop();
          }
        }

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          appBar: AppBar(
            backgroundColor: AppColors.darkBackground,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.router.maybePop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14,
                color: AppColors.primaryLight,
              ),
            ),
            centerTitle: true,
            title: Text(
              l10n.serviceBreakdownTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.router.push(
                    ManualEntryFormRoute(record: record, vehicleId: vehicleId),
                  );
                },
                child: Text(
                  l10n.edit,
                  style: const TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (_) {
                        final isFormal =
                            record.proofClassification ==
                            ProofClassification.formalStoreReceipt;
                        final badgeColor = isFormal
                            ? AppColors.verified
                            : AppColors.warning;
                        final badgeBg = isFormal
                            ? AppColors.verifiedBg
                            : AppColors.warningBg;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: badgeColor, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isFormal
                                    ? Icons.receipt_long_rounded
                                    : Icons.verified_rounded,
                                size: 12,
                                color: badgeColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isFormal
                                    ? l10n.officialStoreReceiptBadge
                                    : l10n.photoVerifiedPartBadge,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                  color: badgeColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurfaceVariant,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.darkBorder,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        l10n.odometerValueBadge(
                          record.mileageKm.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (m) => '${m[1]},',
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  breakdown.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 18),
                RecordInvestmentCard(breakdown: breakdown),
                const SizedBox(height: 16),
                RecordFacilityCard(breakdown: breakdown),
                const SizedBox(height: 16),
                RecordVerificationCard(breakdown: breakdown),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: BorderSide(
                        color: Colors.redAccent.withValues(alpha: 0.4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.delete_outline_rounded, size: 18),
                    label: Text(
                      l10n.deleteServiceRecordTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: handleDelete,
                  ),
                ),
              ],
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
              child: Observer(
                builder: (_) => ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: activeController.isIncludedInDossier
                        ? AppColors.primary
                        : AppColors.darkSurfaceVariant,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    activeController.isIncludedInDossier
                        ? Icons.check_circle_rounded
                        : Icons.description_outlined,
                    size: 18,
                  ),
                  label: Text(
                    activeController.isIncludedInDossier
                        ? l10n.includedInResaleDossier
                        : l10n.includeInResaleDossier,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    activeController.toggleIncludedInDossier();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          activeController.isIncludedInDossier
                              ? l10n.verifiedAndLinkedToDossierToast
                              : l10n.excludedFromDossierToast,
                        ),
                        backgroundColor: activeController.isIncludedInDossier
                            ? AppColors.verified
                            : AppColors.warning,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
