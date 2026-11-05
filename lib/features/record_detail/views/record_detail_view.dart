import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../controllers/record_detail_controller.dart';
import '../widgets/record_facility_card.dart';
import '../widgets/record_investment_card.dart';
import '../widgets/record_verification_card.dart';

@RoutePage()
class RecordDetailView extends StatelessWidget {
  final String recordId;
  final String? vehicleId;
  final RecordDetailController? controller;

  const RecordDetailView({
    super.key,
    required this.recordId,
    this.vehicleId,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.recordDetailController;
    final breakdown = activeController.getRecordDetail(recordId, vehicleId: vehicleId);
    final record = breakdown.record;

    Future<void> handleDelete() async {
      final confirmed = await AppConfirmationDialog.show(
        context: context,
        title: 'Delete Service Record',
        message: 'Are you sure you want to delete "${record.title}"? This action cannot be undone and will update your vehicle lifetime totals.',
        confirmText: 'Delete Record',
        cancelText: 'Cancel',
        isDestructive: true,
        icon: Icons.delete_outline_rounded,
      );

      if (confirmed && context.mounted) {
        activeController.deleteRecord(record.id, vehicleId: vehicleId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Service record deleted successfully'),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 2),
          ),
        );
        context.router.maybePop();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: TextButton.icon(
          onPressed: () => context.router.maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: AppColors.primaryLight),
          label: const Text(
            'Timeline',
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: const Text(
          'Service Breakdown',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
            tooltip: 'Delete Record',
            onPressed: handleDelete,
          ),
          Observer(
            builder: (_) => TextButton(
              onPressed: () {
                activeController.toggleEditMode();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(activeController.isEditMode ? 'Edit mode enabled' : 'Edit mode saved'),
                    backgroundColor: AppColors.primaryDark,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Text(
                activeController.isEditMode ? 'Done' : 'Edit',
                style: const TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warningBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.warning, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded, size: 12, color: AppColors.warning),
                      SizedBox(width: 4),
                      Text(
                        'PHOTO-VERIFIED PART',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.darkBorder, width: 1),
                  ),
                  child: Text(
                    'Odometer: ${record.mileageKm.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} km',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              breakdown.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 18),

            RecordInvestmentCard(breakdown: breakdown),
            const SizedBox(height: 16),
            RecordFacilityCard(breakdown: breakdown),
            const SizedBox(height: 16),
            RecordVerificationCard(breakdown: breakdown),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                label: const Text(
                  'Delete Service Record',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                onPressed: handleDelete,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: const BoxDecoration(
          color: AppColors.darkBackground,
          border: Border(top: BorderSide(color: AppColors.darkBorder, width: 1)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Observer(
            builder: (_) => ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: activeController.isIncludedInDossier ? AppColors.primary : AppColors.darkSurfaceVariant,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                activeController.isIncludedInDossier ? Icons.check_circle_rounded : Icons.description_outlined,
                size: 18,
              ),
              label: Text(
                activeController.isIncludedInDossier ? '✓ Included in Resale Dossier' : 'Include in Resale Dossier',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                activeController.toggleIncludedInDossier();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(activeController.isIncludedInDossier
                        ? '✓ Verified and linked to public dossier certificate'
                        : 'Excluded from public dossier certificate'),
                    backgroundColor: activeController.isIncludedInDossier ? AppColors.verified : AppColors.warning,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
