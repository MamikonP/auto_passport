import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/di/locator.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/intake_controller.dart';
import '../models/intake_method_model.dart';
import '../widgets/intake_option_card.dart';
import 'voice_service_log_sheet.dart';

class IntakeModal extends StatelessWidget {
  final IntakeController? controller;

  const IntakeModal({super.key, this.controller});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const IntakeModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.intakeController;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusExtraLarge),
          topRight: Radius.circular(AppDimensions.radiusExtraLarge),
        ),
        border: Border(
          top: BorderSide(color: AppColors.darkBorder, width: 1.5),
          left: BorderSide(color: AppColors.darkBorder, width: 1.5),
          right: BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: SafeArea(
        top: false,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.logServiceProofTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.logServiceProofSubtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...activeController.intakeMethods.map((method) {
              final isVoice = method.id == 'voice_log';
              final localizedMethod = IntakeMethodModel(
                id: method.id,
                title: isVoice
                    ? l10n.intakeVoiceLogTitle
                    : l10n.intakeManualEntryTitle,
                subtitle: isVoice
                    ? l10n.intakeVoiceLogSubtitle
                    : l10n.intakeManualEntrySubtitle,
                icon: method.icon,
                iconColor: method.iconColor,
                iconBgColor: method.iconBgColor,
                badgeText: isVoice
                    ? l10n.intakeVoiceLogBadge
                    : method.badgeText,
                badgeColor: method.badgeColor,
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: IntakeOptionCard(
                  method: localizedMethod,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (method.id == 'voice_log') {
                      VoiceServiceLogSheet.show(context);
                    } else {
                      context.router.push(ManualEntryFormRoute());
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
