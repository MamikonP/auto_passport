import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class InfoDescriptionBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const InfoDescriptionBox({
    super.key,
    required this.text,
    this.icon = Icons.info_outline_rounded,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  });

  const InfoDescriptionBox.warning({
    super.key,
    required this.text,
    this.icon = Icons.info_outline_rounded,
    this.iconColor = AppColors.warning,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final isWarning = iconColor == AppColors.warning;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isWarning
                ? AppColors.warningBg.withValues(alpha: 0.7)
                : AppColors.darkSurfaceVariant.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              borderColor ??
              (isWarning
                  ? AppColors.warning.withValues(alpha: 0.6)
                  : AppColors.darkBorder),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              icon,
              size: 16,
              color: iconColor ?? AppColors.primaryLight,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style:
                  textStyle ??
                  const TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

