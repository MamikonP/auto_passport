import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../models/record_detail_model.dart';

class RecordVerificationCard extends StatelessWidget {
  final RecordBreakdownModel breakdown;

  const RecordVerificationCard({
    super.key,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(color: const Color(0xFF78350F), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shield_outlined, size: 16, color: AppColors.warning),
              SizedBox(width: 6),
              Text(
                'Dossier Verification Status',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            breakdown.verificationNotes,
            style: const TextStyle(
              fontSize: 12,
              height: 1.45,
              color: Color(0xFFD4D4D8),
            ),
          ),
        ],
      ),
    );
  }
}
