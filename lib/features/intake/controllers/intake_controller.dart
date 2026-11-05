import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/repository/vehicle_repository.dart';
import '../models/intake_method_model.dart';

part 'intake_controller.g.dart';

class IntakeController = IntakeControllerBase with _$IntakeController;

abstract class IntakeControllerBase with Store {
  final VehicleRepository? repository;

  IntakeControllerBase({this.repository});

  final List<IntakeMethodModel> intakeMethods = const [
    IntakeMethodModel(
      id: 'part_photo',
      title: 'Photo of Part or Lift',
      subtitle: 'Brand-new parts box, label, or car on lift',
      icon: Icons.camera_alt_rounded,
      iconColor: Color(0xFFF59E0B),
      iconBgColor: Color(0xFF451A03),
    ),
    IntakeMethodModel(
      id: 'payment_screenshot',
      title: 'Payment App Screenshot',
      subtitle: 'Auto-parse amount & date from Idram / Telcell / Bank',
      icon: Icons.credit_card_rounded,
      iconColor: Color(0xFF38BDF8),
      iconBgColor: Color(0xFF0C4A6E),
    ),
    IntakeMethodModel(
      id: 'voice_log',
      title: 'Voice Quick Log',
      subtitle: 'Speak Armenian/Russian: "Changed front pads..."',
      icon: Icons.mic_rounded,
      iconColor: Color(0xFFA855F7),
      iconBgColor: Color(0xFF3B0764),
      badgeText: 'AI Parser',
      badgeColor: Color(0xFF8B5CF6),
    ),
    IntakeMethodModel(
      id: 'paper_receipt',
      title: 'Paper Receipt / Door Sticker',
      subtitle: 'Auto-scan Liqui Moly oil sticker or parts receipt',
      icon: Icons.receipt_long_rounded,
      iconColor: Color(0xFF10B981),
      iconBgColor: Color(0xFF064E3B),
    ),
  ];
}
