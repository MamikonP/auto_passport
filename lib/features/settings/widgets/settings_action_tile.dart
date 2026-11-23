import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Color? borderColor;
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final bool isDestructive;

  const SettingsActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.borderColor,
    this.trailingIcon,
    this.trailingIconColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor =
        iconColor ??
        (isDestructive ? Colors.redAccent : AppColors.primaryLight);
    final effectiveTitleColor =
        titleColor ?? (isDestructive ? Colors.redAccent : Colors.white);
    final effectiveBorderColor =
        borderColor ??
        (isDestructive
            ? Colors.redAccent.withValues(alpha: 0.3)
            : AppColors.darkBorder);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: effectiveBorderColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: effectiveIconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: effectiveTitleColor,
                ),
              ),
            ),
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: trailingIconColor ?? AppColors.textMuted,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
