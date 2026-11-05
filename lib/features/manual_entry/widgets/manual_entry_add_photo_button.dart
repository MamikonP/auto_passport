import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ManualEntryAddPhotoButton extends StatelessWidget {
  final VoidCallback onTap;

  const ManualEntryAddPhotoButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.darkBorder,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, size: 20, color: AppColors.primaryLight),
            SizedBox(height: 4),
            Text(
              '+ Photo',
              style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
