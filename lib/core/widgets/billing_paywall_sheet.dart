import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../l10n/app_localizations.dart';
import '../controllers/billing_controller.dart';
import '../di/locator.dart';
import '../models/vehicle_passport_model.dart';
import '../services/billing_service/billing_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

/// Bottom sheet offering:
/// 1) One-Time Lifetime Pass for [vehicle] (when [vehicle] is provided)
/// 2) AutoPassport Pro Subscription (Monthly / Yearly) for multi-car garage & all PDF exports
/// 3) Restore Purchases
class BillingPaywallSheet extends StatefulWidget {
  final VehiclePassportModel? vehicle;
  final BillingController? billingController;

  const BillingPaywallSheet({
    super.key,
    this.vehicle,
    this.billingController,
  });

  /// Shows the paywall and returns `true` if a purchase unlocked access.
  static Future<bool> show(
    BuildContext context, {
    VehiclePassportModel? vehicle,
    BillingController? billingController,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => BillingPaywallSheet(
        vehicle: vehicle,
        billingController: billingController,
      ),
    );
    return result ?? false;
  }

  @override
  State<BillingPaywallSheet> createState() => _BillingPaywallSheetState();
}

class _BillingPaywallSheetState extends State<BillingPaywallSheet> {
  bool _yearlySelected = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final billingController =
        widget.billingController ?? Locator.billingController;
    final vehicle = widget.vehicle;

    return Observer(
      builder: (_) {
        final isBusy =
            billingController.isPurchasing || billingController.isLoading;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.darkBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: AppColors.proBadgeGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        vehicle != null
                            ? l10n.unlockDossierForVehicleTitle(
                                vehicle.fullName,
                              )
                            : l10n.upgradeToProTitle,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if (vehicle == null) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.multiCarSubscriptionSubtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 16),

                // Option 1: One-Time Pass for THIS car only
                if (vehicle != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground,
                      borderRadius: AppDimensions.borderRadiusLarge,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                l10n.oneTimeCarPassOptionTitle,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              billingController.vehiclePassPrice,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.oneTimeCarPassOptionSubtitle(vehicle.fullName),
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: isBusy
                                ? null
                                : () async {
                                    final ok = await billingController
                                        .purchaseVehiclePass(vehicle.id);
                                    if (!context.mounted) return;
                                    if (ok) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            l10n.vehiclePassUnlockedToast(
                                              vehicle.fullName,
                                            ),
                                          ),
                                          backgroundColor: AppColors.verified,
                                        ),
                                      );
                                      Navigator.of(context).pop(true);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            l10n.purchaseFailedToast,
                                          ),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }
                                  },
                            child: isBusy
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    l10n.unlockThisCarButton(
                                      billingController.vehiclePassPrice,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Option 2: Pro Subscription (Monthly / Yearly)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: AppDimensions.borderRadiusLarge,
                    border: Border.all(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.55),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.proSubscriptionOptionTitle,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.proSubscriptionOptionSubtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _BillingPlanChip(
                              label: l10n.monthlyBillingLabel,
                              price: billingController.proMonthlyPrice,
                              isSelected: !_yearlySelected,
                              onTap: () =>
                                  setState(() => _yearlySelected = false),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _BillingPlanChip(
                              label: l10n.yearlyBillingLabel,
                              price: billingController.proYearlyPrice,
                              isSelected: _yearlySelected,
                              onTap: () =>
                                  setState(() => _yearlySelected = true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF59E0B),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isBusy
                              ? null
                              : () async {
                                  final ok = await billingController
                                      .purchaseProSubscription(
                                        yearly: _yearlySelected,
                                      );
                                  if (!context.mounted) return;
                                  if (ok) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          l10n.proSubscriptionActivatedToast,
                                        ),
                                        backgroundColor: AppColors.verified,
                                      ),
                                    );
                                    Navigator.of(context).pop(true);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(l10n.purchaseFailedToast),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  }
                                },
                          child: isBusy
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(
                                  l10n.subscribeProButton(
                                    _yearlySelected
                                        ? billingController.proYearlyPrice
                                        : billingController.proMonthlyPrice,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: isBusy
                        ? null
                        : () async {
                            final result = await billingController
                                .restorePurchases();
                            if (!context.mounted) return;
                            final (message, color) = switch (result) {
                              RestorePurchasesResult.restored => (
                                l10n.purchasesRestoredToast,
                                AppColors.verified,
                              ),
                              RestorePurchasesResult.nothingToRestore => (
                                l10n.noPurchasesToRestoreToast,
                                AppColors.warning,
                              ),
                              RestorePurchasesResult.failed => (
                                l10n.restorePurchasesFailedToast,
                                AppColors.error,
                              ),
                            };
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: color,
                              ),
                            );
                            if (result == RestorePurchasesResult.restored) {
                              Navigator.of(context).pop(true);
                            }
                          },
                    child: Text(
                      l10n.restorePurchasesButton,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BillingPlanChip extends StatelessWidget {
  final String label;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const _BillingPlanChip({
    required this.label,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF59E0B).withValues(alpha: 0.16)
              : AppColors.darkBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFFF59E0B) : AppColors.darkBorder,
            width: isSelected ? 1.4 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? const Color(0xFFF59E0B)
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
