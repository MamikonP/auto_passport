import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/services/billing_service/billing_service.dart';
import '../../../core/services/vehicle_sync_codec.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../../core/widgets/billing_paywall_sheet.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_action_tile.dart';
import '../widgets/settings_currency_selector.dart';
import '../widgets/settings_segmented_group.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  final SettingsController? controller;

  const SettingsView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.settingsController;
    final billingController = Locator.billingController;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: false,
        title: Text(
          l10n.settingsAndPreferencesTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'v1.2.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final isProSubscribed = billingController.isProSubscribed;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              GestureDetector(
                onTap: isProSubscribed
                    ? null
                    : () => BillingPaywallSheet.show(context),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: AppDimensions.borderRadiusLarge,
                    border: Border.all(
                      color: isProSubscribed
                          ? const Color(0xFFF59E0B).withValues(alpha: 0.5)
                          : AppColors.darkBorder,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: isProSubscribed
                              ? AppColors.proBadgeGradient
                              : null,
                          color: isProSubscribed
                              ? null
                              : AppColors.darkSurfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.workspace_premium_rounded,
                          color: isProSubscribed
                              ? Colors.black
                              : AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.planStatusHeader,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: isProSubscribed
                                    ? const Color(0xFFF59E0B)
                                    : AppColors.primaryLight,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isProSubscribed
                                  ? l10n.proLifetimeMember
                                  : l10n.freePlanMember,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isProSubscribed
                                  ? l10n.allVehiclesAndExportsUnlocked
                                  : l10n.freePlanDescription,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isProSubscribed) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            l10n.upgradeActionLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                l10n.appLanguageLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              SettingsSegmentedGroup(
                options: const ['English', 'Հայերեն', 'Русский'],
                selectedOption: activeController.appLanguage,
                onSelected: activeController.setAppLanguage,
              ),
              const SizedBox(height: 18),
              Text(
                l10n.defaultDisplayCurrencyLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              SettingsCurrencySelector(
                selectedCurrency: activeController.displayCurrency,
                onSelected: activeController.setDisplayCurrency,
              ),
              const SizedBox(height: 18),
              Text(
                l10n.distanceAndSpeedUnitLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              SettingsSegmentedGroup(
                options: [l10n.kilometersOption, l10n.milesOption],
                selectedOption: activeController.distanceUnit == DistanceUnit.km
                    ? l10n.kilometersOption
                    : l10n.milesOption,
                onSelected: (val) {
                  activeController.setDistanceUnit(
                    val == l10n.kilometersOption || val.contains('km')
                        ? DistanceUnit.km
                        : DistanceUnit.miles,
                  );
                },
              ),
              const SizedBox(height: 22),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 14,
              //   ),
              //   decoration: BoxDecoration(
              //     color: AppColors.darkSurface,
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: AppColors.darkBorder),
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Row(
              //           children: [
              //             const Icon(
              //               Icons.cloud_done_rounded,
              //               color: AppColors.primaryLight,
              //               size: 20,
              //             ),
              //             const SizedBox(width: 12),
              //             Flexible(
              //               child: Text(
              //                 l10n.cloudBackupLabel,
              //                 style: const TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w600,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       const SizedBox(width: 8),
              //       Row(
              //         children: [
              //           Container(
              //             width: 8,
              //             height: 8,
              //             decoration: const BoxDecoration(
              //               color: AppColors.verified,
              //               shape: BoxShape.circle,
              //             ),
              //           ),
              //           const SizedBox(width: 6),
              //           Text(
              //             l10n.syncedStatus,
              //             style: const TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.w700,
              //               color: AppColors.verified,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 12),
              SettingsActionTile(
                icon: Icons.ios_share_rounded,
                iconColor: AppColors.primaryLight,
                title: l10n.exportEncryptedBackupLabel,
                trailingIcon: Icons.lock_outline_rounded,
                onTap: () => _showExportSyncSheet(context, activeController),
              ),
              const SizedBox(height: 12),
              SettingsActionTile(
                icon: Icons.download_rounded,
                iconColor: AppColors.verified,
                title: l10n.importEncryptedBackupLabel,
                trailingIcon: Icons.sync_rounded,
                onTap: () => _showImportSyncSheet(context, activeController),
              ),
              if (!isProSubscribed) ...[
                const SizedBox(height: 12),
                SettingsActionTile(
                  icon: Icons.restore_rounded,
                  iconColor: AppColors.primaryLight,
                  title: l10n.restorePurchasesButton,
                  onTap: () async {
                    final result = await billingController.restorePurchases();
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
                      SnackBar(content: Text(message), backgroundColor: color),
                    );
                  },
                ),
              ],
              const SizedBox(height: 12),
              SettingsActionTile(
                icon: Icons.delete_outline_rounded,
                title: l10n.clearLocalStorageLabel,
                isDestructive: true,
                onTap: () async {
                  final message = billingController.hasOnlyPerCarPasses
                      ? l10n.resetLocalDatabaseConsumableWarning
                      : l10n.resetLocalDatabaseMessage;
                  final confirmed = await AppConfirmationDialog.show(
                    context: context,
                    title: l10n.resetLocalDatabaseTitle,
                    message: message,
                    confirmText: l10n.resetAllConfirmButton,
                    cancelText: l10n.cancel,
                    isDestructive: true,
                  );
                  if (confirmed && context.mounted) {
                    await activeController.clearAllData();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.localDatabaseClearedToast),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showExportSyncSheet(
    BuildContext context,
    SettingsController activeController,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (activeController.vehiclesCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.noVehiclesToExportToast),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final syncCode = activeController.exportEncryptedVehicles();
    final preview = syncCode.length > 48
        ? '${syncCode.substring(0, 32)}••••••••${syncCode.substring(syncCode.length - 12)}'
        : syncCode;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
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
                    const Icon(
                      Icons.enhanced_encryption_rounded,
                      color: AppColors.primaryLight,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.exportBackupSheetTitle,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.exportBackupSheetSubtitle(
                    activeController.vehiclesCount,
                    activeController.totalRecordsCount,
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.darkBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Text(
                    preview,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: AppColors.primaryLight,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.copy_rounded, size: 18),
                    label: Text(
                      l10n.copySyncCodeButton,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: syncCode));
                      if (sheetContext.mounted) {
                        Navigator.of(sheetContext).pop();
                      }
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.syncCodeCopiedToast),
                            backgroundColor: AppColors.verified,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showImportSyncSheet(
    BuildContext context,
    SettingsController activeController,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final codeController = TextEditingController();
    bool replaceExisting = false;
    String? errorText;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                14,
                20,
                MediaQuery.of(sheetContext).viewInsets.bottom + 20,
              ),
              child: SafeArea(
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
                        const Icon(
                          Icons.sync_lock_rounded,
                          color: AppColors.verified,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.importBackupSheetTitle,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.importBackupSheetSubtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: codeController,
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.syncCodeFieldHint,
                        hintStyle: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                        errorText: errorText,
                        filled: true,
                        fillColor: AppColors.darkBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.darkBorder,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.darkBorder,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () async {
                          final data = await Clipboard.getData(
                            Clipboard.kTextPlain,
                          );
                          if (data?.text != null && data!.text!.isNotEmpty) {
                            setSheetState(() {
                              codeController.text = data.text!.trim();
                              errorText = null;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.content_paste_rounded,
                          size: 16,
                          color: AppColors.primaryLight,
                        ),
                        label: Text(
                          l10n.pasteFromClipboardButton,
                          style: const TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setSheetState(() => replaceExisting = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: !replaceExisting
                                    ? AppColors.primary
                                    : AppColors.darkSurfaceVariant,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: !replaceExisting
                                      ? AppColors.primaryLight
                                      : AppColors.darkBorder,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  l10n.mergeWithGarageOption,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: !replaceExisting
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setSheetState(() => replaceExisting = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: replaceExisting
                                    ? Colors.redAccent.withValues(alpha: 0.85)
                                    : AppColors.darkSurfaceVariant,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: replaceExisting
                                      ? Colors.redAccent
                                      : AppColors.darkBorder,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  l10n.replaceGarageOption,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: replaceExisting
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.verified,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.download_done_rounded, size: 18),
                        label: Text(
                          l10n.importVehiclesButton,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () async {
                          try {
                            final importedCount = await activeController
                                .importEncryptedVehicles(
                                  codeController.text,
                                  replaceExisting: replaceExisting,
                                );
                            if (sheetContext.mounted) {
                              Navigator.of(sheetContext).pop();
                            }
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    l10n.vehiclesImportedToast(importedCount),
                                  ),
                                  backgroundColor: AppColors.verified,
                                ),
                              );
                            }
                          } on VehicleSyncException {
                            setSheetState(() {
                              errorText = l10n.invalidSyncCodeError;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    codeController.dispose();
  }
}
