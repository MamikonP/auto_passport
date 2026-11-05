import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TimelineProofBadge extends StatelessWidget {
  final String badge;

  const TimelineProofBadge({
    super.key,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.check_circle_outline_rounded;
    Color color = AppColors.textSecondary;
    Color bg = AppColors.darkSurfaceVariant;

    if (badge.contains('Photo Proof')) {
      icon = Icons.camera_alt_rounded;
      color = const Color(0xFFF59E0B);
      bg = const Color(0xFF451A03);
    } else if (badge.contains('Parts Box')) {
      icon = Icons.inventory_2_outlined;
      color = const Color(0xFF38BDF8);
      bg = const Color(0xFF0C4A6E);
    } else if (badge.contains('Idram')) {
      icon = Icons.payment_rounded;
      color = AppColors.idramOrange;
      bg = const Color(0xFF431407);
    } else if (badge.contains('Invoice') || badge.contains('Receipt')) {
      icon = Icons.receipt_long_rounded;
      color = AppColors.verified;
      bg = AppColors.verifiedBg;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            badge,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
