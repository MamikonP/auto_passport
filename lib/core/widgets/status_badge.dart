import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/vehicle_model.dart';
import '../../l10n/app_localizations.dart';

class StatusBadge extends StatelessWidget {
  final PassportStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, bgColor, textColor, icon) = switch (status) {
      PassportStatus.verified => (
          l10n?.verified ?? 'Verified',
          AppColors.verified.withValues(alpha: 0.15),
          AppColors.verified,
          Icons.verified_rounded,
        ),
      PassportStatus.pending => (
          l10n?.pending ?? 'Pending',
          AppColors.pending.withValues(alpha: 0.15),
          AppColors.pending,
          Icons.schedule_rounded,
        ),
      PassportStatus.expired => (
          l10n?.expired ?? 'Expired',
          AppColors.expired.withValues(alpha: 0.15),
          AppColors.expired,
          Icons.warning_amber_rounded,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
