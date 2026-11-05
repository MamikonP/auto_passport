import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class GarageRegisterCard extends StatelessWidget {
  final bool isEmpty;
  final VoidCallback onTap;

  const GarageRegisterCard({
    super.key,
    required this.isEmpty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.darkSurface.withValues(alpha: 0.5),
          borderRadius: AppDimensions.borderRadiusLarge,
          border: Border.all(
            color: AppColors.darkBorder,
            style: BorderStyle.solid,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.primaryLight,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isEmpty ? 'Register First Vehicle' : 'Register Another Vehicle',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Track DIY repairs, parts, and increase resale value',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
