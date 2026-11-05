import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/di/locator.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../controllers/intake_controller.dart';
import '../widgets/intake_option_card.dart';

class IntakeModal extends StatelessWidget {
  final IntakeController? controller;

  const IntakeModal({
    super.key,
    this.controller,
  });

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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log Service Proof',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Choose how you want to document this repair:',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...activeController.intakeMethods.map((method) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: IntakeOptionCard(
                  method: method,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(ManualEntryFormRoute(initialProofType: method.id));
                  },
                ),
              );
            }),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.router.push(ManualEntryFormRoute());
                },
                child: const Text(
                  'Skip auto-extract and enter manually →',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
