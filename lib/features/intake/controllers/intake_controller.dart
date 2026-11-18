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
      id: 'voice_log',
      title: 'Voice Quick Log',
      subtitle: 'Speak repair details — auto-extracts service, cost & mileage',
      icon: Icons.mic_rounded,
      iconColor: Color(0xFFA855F7),
      iconBgColor: Color(0xFF3B0764),
      badgeText: 'Speech-to-Text',
      badgeColor: Color(0xFF8B5CF6),
    ),
    IntakeMethodModel(
      id: 'manual_entry',
      title: 'Manual Service Entry',
      subtitle: 'Enter repair details, cost, mileage & attach photo or receipt proofs',
      icon: Icons.build_circle_outlined,
      iconColor: Color(0xFF38BDF8),
      iconBgColor: Color(0xFF0C4A6E),
    ),
  ];
}
