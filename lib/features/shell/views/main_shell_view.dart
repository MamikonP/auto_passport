import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../dossier/views/dossier_hub_view.dart';
import '../../garage/views/garage_manager_view.dart';
import '../../settings/views/settings_view.dart';
import '../../timeline/views/timeline_feed_view.dart';
import '../controllers/shell_controller.dart';
import '../models/shell_navigation_model.dart';
import '../widgets/shell_bottom_nav_item.dart';

@RoutePage()
class MainShellView extends StatelessWidget {
  final ShellController? controller;

  const MainShellView({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.shellController;

    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: IndexedStack(
          index: activeController.currentIndex,
          children: [
            activeController.showingGarage
                ? GarageManagerView(
                    onVehicleSelected: () {
                      activeController.closeGarage();
                    },
                  )
                : TimelineFeedView(
                    onOpenGarage: () {
                      activeController.openGarage();
                    },
                  ),
            const SizedBox.shrink(), // Scan tab triggers modal
            const DossierHubView(),
            const SettingsView(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.darkSurface,
            border: Border(
              top: BorderSide(color: AppColors.darkBorder, width: 1),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ShellNavItem.defaultItems.map((item) {
                  return ShellBottomNavItem(
                    item: item,
                    isSelected: activeController.currentIndex == item.index,
                    onTap: () {
                      if (item.isScanButton) {
                        context.router.push(ManualEntryFormRoute());
                      } else {
                        activeController.setIndex(item.index);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
