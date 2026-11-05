import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../models/garage_item_model.dart';

class GarageVehicleCard extends StatelessWidget {
  final GarageItemModel item;
  final VoidCallback onTap;
  final VoidCallback onSelect;
  final VoidCallback onDelete;

  const GarageVehicleCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = item.isActive;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.darkBorder,
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: isActive ? AppDimensions.cardShadowDark : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppDimensions.borderRadiusLarge,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.darkSurfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.directions_car_rounded,
                        color: isActive ? AppColors.primaryLight : AppColors.textSecondary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.fullName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.specSummary,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      )
                    else
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryLight,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: onSelect,
                        child: const Text(
                          'Select',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.textMuted),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Remove car',
                      onPressed: onDelete,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'VIN: ${item.maskedVin}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    letterSpacing: 1.1,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Odometer',
                              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.formattedMileage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Records',
                              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${item.verifiedRecordsCount} Verified',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.verified,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Total Spent',
                              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.formattedTotalSpent,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
