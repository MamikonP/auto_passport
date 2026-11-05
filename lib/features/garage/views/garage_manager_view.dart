import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../controllers/garage_controller.dart';
import '../widgets/garage_register_card.dart';
import '../widgets/garage_vehicle_card.dart';

@RoutePage()
class GarageManagerView extends StatelessWidget {
  final GarageController? controller;
  final VoidCallback? onVehicleSelected;

  const GarageManagerView({super.key, this.controller, this.onVehicleSelected});

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.garageController;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        titleSpacing: 16,
        title: Observer(
          builder: (_) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.garage_rounded,
                  color: AppColors.primaryLight,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'My Garage (${activeController.totalVehiclesCount})',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text(
                  'Add Car',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  context.router.push(AddNewVehicleRoute());
                },
              ),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final items = activeController.garageItems;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
            children: [
              ...items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GarageVehicleCard(
                    item: item,
                    onTap: () {
                      activeController.selectVehicle(item.id);
                      if (onVehicleSelected != null) {
                        onVehicleSelected!();
                      } else {
                        context.router.push(TimelineFeedRoute());
                      }
                    },
                    onSelect: () {
                      activeController.selectVehicle(item.id);
                      if (onVehicleSelected != null) {
                        onVehicleSelected!();
                      } else {
                        context.router.push(TimelineFeedRoute());
                      }
                    },
                    onDelete: () async {
                      final confirmed = await AppConfirmationDialog.show(
                        context: context,
                        title: 'Remove Car from Garage',
                        message:
                            'Are you sure you want to remove "${item.fullName}"? All logged service records and passport history for this vehicle will be deleted.',
                        confirmText: 'Remove Car',
                        cancelText: 'Cancel',
                        isDestructive: true,
                      );
                      if (confirmed && context.mounted) {
                        activeController.deleteVehicle(item.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '✓ ${item.fullName} removed from garage',
                            ),
                            backgroundColor: AppColors.error,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                );
              }),

              GarageRegisterCard(
                isEmpty: items.isEmpty,
                onTap: () {
                  context.router.push(AddNewVehicleRoute());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
