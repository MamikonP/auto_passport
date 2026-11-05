import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/di/locator.dart';
import '../../../core/models/vehicle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/app_confirmation_dialog.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_currency_selector.dart';
import '../widgets/settings_segmented_group.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  final SettingsController? controller;

  const SettingsView({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final activeController = controller ?? Locator.settingsController;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Settings & Preferences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'v1.2.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppDimensions.borderRadiusLarge,
                  border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4), width: 1.2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: AppColors.proBadgeGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.workspace_premium_rounded, color: Colors.black, size: 22),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PLAN STATUS',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              color: Color(0xFFF59E0B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Pro Lifetime Member',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'All vehicles & PDF exports unlocked',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'App Language (Լեզու)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              SettingsSegmentedGroup(
                options: const ['English', 'Հայերեն', 'Русский'],
                selectedOption: activeController.appLanguage,
                onSelected: activeController.setAppLanguage,
              ),
              const SizedBox(height: 18),
              const Text(
                'Default Display Currency',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              SettingsCurrencySelector(
                selectedCurrency: activeController.displayCurrency,
                onSelected: activeController.setDisplayCurrency,
              ),
              const SizedBox(height: 18),
              const Text(
                'Distance & Speed Unit',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              SettingsSegmentedGroup(
                options: const ['Kilometers (km)', 'Miles (mi)'],
                selectedOption: activeController.distanceUnit == DistanceUnit.km ? 'Kilometers (km)' : 'Miles (mi)',
                onSelected: (val) {
                  activeController.setDistanceUnit(
                    val.contains('km') ? DistanceUnit.km : DistanceUnit.miles,
                  );
                },
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.cloud_done_rounded, color: AppColors.primaryLight, size: 20),
                          SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              'Cloud Backup (Supabase)',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.verified,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Synced',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.verified,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✓ Raw records exported as JSON/CSV'),
                      backgroundColor: AppColors.primaryDark,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.ios_share_rounded, color: AppColors.textSecondary, size: 20),
                            SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                'Export Raw Records (JSON / CSV)',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final confirmed = await AppConfirmationDialog.show(
                    context: context,
                    title: 'Reset Local Database',
                    message: 'Are you sure you want to clear all data? All registered vehicles and service records will be erased.',
                    confirmText: 'Reset All',
                    cancelText: 'Cancel',
                    isDestructive: true,
                  );
                  if (confirmed && context.mounted) {
                    await activeController.clearAllData();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✓ Local database cleared (Clean slate)'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Clear Local Storage (Reset to Empty)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
