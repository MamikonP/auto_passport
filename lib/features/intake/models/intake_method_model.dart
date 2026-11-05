import 'package:flutter/material.dart';

class IntakeMethodModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String? badgeText;
  final Color? badgeColor;

  const IntakeMethodModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.badgeText,
    this.badgeColor,
  });
}
