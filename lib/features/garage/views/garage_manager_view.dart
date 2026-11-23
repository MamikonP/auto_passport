import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/di/locator.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/billing_paywall_sheet.dart';
import '../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

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
                  l10n.myGarageTitle(activeController.totalVehiclesCount),
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
                  ),
                );
              }),

              GarageRegisterCard(
                isEmpty: items.isEmpty,
                onTap: () async {
                  final canAdd = Locator.billingController.canAddVehicle(
                    items.length,
                  );
                  if (!canAdd) {
                    final upgraded = await BillingPaywallSheet.show(context);
                    if (!upgraded || !context.mounted) return;
                  }
                  if (context.mounted) {
                    context.router.push(AddNewVehicleRoute());
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
