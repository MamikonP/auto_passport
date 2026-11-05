import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../../intake/views/intake_modal.dart';
import '../controllers/timeline_controller.dart';
import '../widgets/timeline_empty_garage_view.dart';
import '../widgets/timeline_entry_card.dart';
import '../widgets/timeline_filter_pill.dart';

@RoutePage()
class TimelineFeedView extends StatelessWidget {
  final TimelineController? controller;
  final VoidCallback? onOpenGarage;

  const TimelineFeedView({
    super.key,
    this.controller,
    this.onOpenGarage,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.timelineController;

    return Observer(
      builder: (_) {
        final vehicle = activeController.activeVehicle;
        final hasVehicle = vehicle != null;
        final entries = activeController.timelineEntries;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: vehicle == null
                ? const TimelineEmptyGarageView()
                : CustomScrollView(
                    slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (onOpenGarage != null) {
                                  onOpenGarage!();
                                } else {
                                  context.router.push(GarageManagerRoute());
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.darkSurfaceVariant,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.darkBorder),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Garage (${activeController.totalVehiclesCount} cars)',
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: AppColors.proBadgeGradient,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'PRO',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.fullName,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${vehicle.formattedMileage} • ${vehicle.formattedTotalSpent} tracked',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary, size: 22),
                              color: AppColors.darkSurface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: AppColors.darkBorder),
                              ),
                              tooltip: 'Car options',
                              onSelected: (value) async {
                                if (value == 'remove') {
                                  final confirmed = await AppConfirmationDialog.show(
                                    context: context,
                                    title: 'Remove Car from Garage',
                                    message: 'Are you sure you want to remove "${vehicle.fullName}"? All logged service records and passport history for this vehicle will be deleted.',
                                    confirmText: 'Remove Car',
                                    cancelText: 'Cancel',
                                    isDestructive: true,
                                  );
                                  if (confirmed && context.mounted) {
                                    activeController.deleteVehicle(vehicle.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('✓ ${vehicle.fullName} removed from garage'),
                                        backgroundColor: AppColors.error,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'remove',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'Remove Car',
                                        style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Category Filter Pills
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          TimelineFilterPill(
                            label: 'All (${vehicle.serviceRecords.length})',
                            isSelected: activeController.selectedCategoryFilter == 'All',
                            onTap: () => activeController.setCategoryFilter('All'),
                          ),
                          const SizedBox(width: 8),
                          TimelineFilterPill(
                            label: 'Suspension',
                            isSelected: activeController.selectedCategoryFilter == 'Suspension',
                            onTap: () => activeController.setCategoryFilter('Suspension'),
                          ),
                          const SizedBox(width: 8),
                          TimelineFilterPill(
                            label: 'Brakes',
                            isSelected: activeController.selectedCategoryFilter == 'Brakes',
                            onTap: () => activeController.setCategoryFilter('Brakes'),
                          ),
                          const SizedBox(width: 8),
                          TimelineFilterPill(
                            label: 'Oil & Filter',
                            isSelected: activeController.selectedCategoryFilter == 'Oil & Filter',
                            onTap: () => activeController.setCategoryFilter('Oil & Filter'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Vertical Timeline Rail
                if (entries.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'No service records found in this category',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = entries[index];
                          return TimelineEntryCard(
                            item: item,
                            onTap: () {
                              context.router.push(
                                RecordDetailRoute(recordId: item.id, vehicleId: vehicle.id),
                              );
                            },
                            onDelete: () async {
                              final confirmed = await AppConfirmationDialog.show(
                                context: context,
                                title: 'Delete Service Record',
                                message: 'Are you sure you want to delete "${item.record.title}"? This action cannot be undone.',
                                confirmText: 'Delete',
                                cancelText: 'Cancel',
                                isDestructive: true,
                              );
                              if (confirmed && context.mounted) {
                                activeController.deleteRecord(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('✓ Service record deleted successfully'),
                                    backgroundColor: AppColors.error,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        childCount: entries.length,
                      ),
                    ),
                  ),
                    ],
                  ),
          ),
          floatingActionButton: hasVehicle
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: FloatingActionButton.extended(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 6,
                    icon: const Icon(Icons.add_rounded, size: 20),
                    label: const Text(
                      'Log Service',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    onPressed: () => IntakeModal.show(context),
                  ),
                )
              : null,
        );
      },
    );
  }
}
