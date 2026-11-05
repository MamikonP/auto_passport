import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/add_vehicle/controllers/add_vehicle_controller.dart';
import '../../features/add_vehicle/views/add_new_vehicle_view.dart';
import '../../features/dossier/controllers/dossier_controller.dart';
import '../../features/dossier/views/dossier_hub_view.dart';
import '../../features/garage/controllers/garage_controller.dart';
import '../../features/garage/views/garage_manager_view.dart';
import '../../features/manual_entry/controllers/manual_entry_controller.dart';
import '../../features/manual_entry/views/manual_entry_form_view.dart';
import '../../features/record_detail/controllers/record_detail_controller.dart';
import '../../features/record_detail/views/record_detail_view.dart';
import '../../features/settings/controllers/settings_controller.dart';
import '../../features/settings/views/settings_view.dart';
import '../../features/shell/controllers/shell_controller.dart';
import '../../features/shell/views/main_shell_view.dart';
import '../../features/timeline/controllers/timeline_controller.dart';
import '../../features/timeline/views/timeline_feed_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainShellRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: GarageManagerRoute.page,
        ),
        AutoRoute(
          page: AddNewVehicleRoute.page,
        ),
        AutoRoute(
          page: TimelineFeedRoute.page,
        ),
        AutoRoute(
          page: RecordDetailRoute.page,
        ),
        AutoRoute(
          page: ManualEntryFormRoute.page,
        ),
        AutoRoute(
          page: DossierHubRoute.page,
        ),
        AutoRoute(
          page: SettingsRoute.page,
        ),
      ];
}
