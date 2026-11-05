import 'package:flutter/material.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';

class TimelineEntryModel {
  final ServiceRecordModel record;
  final Currency currency;
  final bool isLast;

  const TimelineEntryModel({
    required this.record,
    required this.currency,
    required this.isLast,
  });

  String get id => record.id;
  String get title => record.title;
  String get description => record.description;
  int get mileageKm => record.mileageKm;
  String get formattedCost => record.formattedCost(currency);
  List<String> get proofBadges => record.proofBadges;
  ServiceCategory get category => record.category;

  Color get nodeColor {
    if (category == ServiceCategory.suspension) {
      return const Color(0xFFF59E0B);
    } else if (category == ServiceCategory.brakes) {
      return const Color(0xFF38BDF8);
    } else if (category == ServiceCategory.oilFilter) {
      return const Color(0xFF10B981);
    }
    return AppColors.primary;
  }
}
