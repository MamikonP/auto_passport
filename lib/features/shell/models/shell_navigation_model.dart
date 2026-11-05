import 'package:flutter/material.dart';

enum ShellTab {
  timeline,
  scan,
  dossier,
  settings,
}

class ShellNavItem {
  final int index;
  final ShellTab tab;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isScanButton;

  const ShellNavItem({
    required this.index,
    required this.tab,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.isScanButton = false,
  });

  static const List<ShellNavItem> defaultItems = [
    ShellNavItem(
      index: 0,
      tab: ShellTab.timeline,
      icon: Icons.access_time_rounded,
      activeIcon: Icons.access_time_filled_rounded,
      label: 'Timeline',
    ),
    ShellNavItem(
      index: 1,
      tab: ShellTab.scan,
      icon: Icons.document_scanner_outlined,
      activeIcon: Icons.document_scanner_rounded,
      label: 'Scan',
      isScanButton: true,
    ),
    ShellNavItem(
      index: 2,
      tab: ShellTab.dossier,
      icon: Icons.description_outlined,
      activeIcon: Icons.description_rounded,
      label: 'Dossier',
    ),
    ShellNavItem(
      index: 3,
      tab: ShellTab.settings,
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label: 'Settings',
    ),
  ];
}
