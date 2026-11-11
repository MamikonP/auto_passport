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
      id: 'service_log',
      title: 'Log Service Record',
      subtitle: 'Record repair details, cost, mileage & attach photo proofs',
      icon: Icons.build_circle_outlined,
      iconColor: Color(0xFF38BDF8),
      iconBgColor: Color(0xFF0C4A6E),
    ),
  ];
}
