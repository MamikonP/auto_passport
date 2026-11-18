import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../models/shell_navigation_model.dart';

class ShellBottomNavItem extends StatelessWidget {
  final ShellNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const ShellBottomNavItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  String _localizedLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (item.tab) {
      case ShellTab.timeline:
        return l10n.navTimeline;
      case ShellTab.scan:
        return l10n.navScan;
      case ShellTab.dossier:
        return l10n.navDossier;
      case ShellTab.settings:
        return l10n.navSettings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? item.activeIcon : item.icon,
                  size: 22,
                  color: isSelected
                      ? AppColors.primaryLight
                      : AppColors.textSecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  _localizedLabel(context),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
