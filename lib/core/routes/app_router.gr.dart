// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddNewVehicleView]
class AddNewVehicleRoute extends PageRouteInfo<AddNewVehicleRouteArgs> {
  AddNewVehicleRoute({
    Key? key,
    VehiclePassportModel? vehicle,
    List<PageRouteInfo>? children,
  }) : super(
         AddNewVehicleRoute.name,
         args: AddNewVehicleRouteArgs(key: key, vehicle: vehicle),
         initialChildren: children,
       );

  static const String name = 'AddNewVehicleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewVehicleRouteArgs>(
        orElse: () => const AddNewVehicleRouteArgs(),
      );
      return AddNewVehicleView(key: args.key, vehicle: args.vehicle);
    },
  );
}

class AddNewVehicleRouteArgs {
  const AddNewVehicleRouteArgs({this.key, this.vehicle});

  final Key? key;

  final VehiclePassportModel? vehicle;

  @override
  String toString() {
    return 'AddNewVehicleRouteArgs{key: $key, vehicle: $vehicle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddNewVehicleRouteArgs) return false;
    return key == other.key && vehicle == other.vehicle;
  }

  @override
  int get hashCode => key.hashCode ^ vehicle.hashCode;
}

/// generated route for
/// [DossierHubView]
class DossierHubRoute extends PageRouteInfo<DossierHubRouteArgs> {
  DossierHubRoute({
    Key? key,
    DossierController? controller,
    List<PageRouteInfo>? children,
  }) : super(
         DossierHubRoute.name,
         args: DossierHubRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'DossierHubRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DossierHubRouteArgs>(
        orElse: () => const DossierHubRouteArgs(),
      );
      return DossierHubView(key: args.key, controller: args.controller);
    },
  );
}

class DossierHubRouteArgs {
  const DossierHubRouteArgs({this.key, this.controller});

  final Key? key;

  final DossierController? controller;

  @override
  String toString() {
    return 'DossierHubRouteArgs{key: $key, controller: $controller}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DossierHubRouteArgs) return false;
    return key == other.key && controller == other.controller;
  }

  @override
  int get hashCode => key.hashCode ^ controller.hashCode;
}

/// generated route for
/// [GarageManagerView]
class GarageManagerRoute extends PageRouteInfo<GarageManagerRouteArgs> {
  GarageManagerRoute({
    Key? key,
    GarageController? controller,
    VoidCallback? onVehicleSelected,
    List<PageRouteInfo>? children,
  }) : super(
         GarageManagerRoute.name,
         args: GarageManagerRouteArgs(
           key: key,
           controller: controller,
           onVehicleSelected: onVehicleSelected,
         ),
         initialChildren: children,
       );

  static const String name = 'GarageManagerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GarageManagerRouteArgs>(
        orElse: () => const GarageManagerRouteArgs(),
      );
      return GarageManagerView(
        key: args.key,
        controller: args.controller,
        onVehicleSelected: args.onVehicleSelected,
      );
    },
  );
}

class GarageManagerRouteArgs {
  const GarageManagerRouteArgs({
    this.key,
    this.controller,
    this.onVehicleSelected,
  });

  final Key? key;

  final GarageController? controller;

  final VoidCallback? onVehicleSelected;

  @override
  String toString() {
    return 'GarageManagerRouteArgs{key: $key, controller: $controller, onVehicleSelected: $onVehicleSelected}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GarageManagerRouteArgs) return false;
    return key == other.key &&
        controller == other.controller &&
        onVehicleSelected == other.onVehicleSelected;
  }

  @override
  int get hashCode =>
      key.hashCode ^ controller.hashCode ^ onVehicleSelected.hashCode;
}

/// generated route for
/// [MainShellView]
class MainShellRoute extends PageRouteInfo<MainShellRouteArgs> {
  MainShellRoute({
    Key? key,
    ShellController? controller,
    List<PageRouteInfo>? children,
  }) : super(
         MainShellRoute.name,
         args: MainShellRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MainShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainShellRouteArgs>(
        orElse: () => const MainShellRouteArgs(),
      );
      return MainShellView(key: args.key, controller: args.controller);
    },
  );
}

class MainShellRouteArgs {
  const MainShellRouteArgs({this.key, this.controller});

  final Key? key;

  final ShellController? controller;

  @override
  String toString() {
    return 'MainShellRouteArgs{key: $key, controller: $controller}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainShellRouteArgs) return false;
    return key == other.key && controller == other.controller;
  }

  @override
  int get hashCode => key.hashCode ^ controller.hashCode;
}

/// generated route for
/// [ManualEntryFormView]
class ManualEntryFormRoute extends PageRouteInfo<ManualEntryFormRouteArgs> {
  ManualEntryFormRoute({
    Key? key,
    String? initialProofType,
    ManualEntryController? controller,
    List<PageRouteInfo>? children,
  }) : super(
         ManualEntryFormRoute.name,
         args: ManualEntryFormRouteArgs(
           key: key,
           initialProofType: initialProofType,
           controller: controller,
         ),
         initialChildren: children,
       );

  static const String name = 'ManualEntryFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ManualEntryFormRouteArgs>(
        orElse: () => const ManualEntryFormRouteArgs(),
      );
      return ManualEntryFormView(
        key: args.key,
        initialProofType: args.initialProofType,
        controller: args.controller,
      );
    },
  );
}

class ManualEntryFormRouteArgs {
  const ManualEntryFormRouteArgs({
    this.key,
    this.initialProofType,
    this.controller,
  });

  final Key? key;

  final String? initialProofType;

  final ManualEntryController? controller;

  @override
  String toString() {
    return 'ManualEntryFormRouteArgs{key: $key, initialProofType: $initialProofType, controller: $controller}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ManualEntryFormRouteArgs) return false;
    return key == other.key &&
        initialProofType == other.initialProofType &&
        controller == other.controller;
  }

  @override
  int get hashCode =>
      key.hashCode ^ initialProofType.hashCode ^ controller.hashCode;
}

/// generated route for
/// [RecordDetailView]
class RecordDetailRoute extends PageRouteInfo<RecordDetailRouteArgs> {
  RecordDetailRoute({
    Key? key,
    required String recordId,
    String? vehicleId,
    RecordDetailController? controller,
    List<PageRouteInfo>? children,
  }) : super(
         RecordDetailRoute.name,
         args: RecordDetailRouteArgs(
           key: key,
           recordId: recordId,
           vehicleId: vehicleId,
           controller: controller,
         ),
         initialChildren: children,
       );

  static const String name = 'RecordDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecordDetailRouteArgs>();
      return RecordDetailView(
        key: args.key,
        recordId: args.recordId,
        vehicleId: args.vehicleId,
        controller: args.controller,
      );
    },
  );
}

class RecordDetailRouteArgs {
  const RecordDetailRouteArgs({
    this.key,
    required this.recordId,
    this.vehicleId,
    this.controller,
  });

  final Key? key;

  final String recordId;

  final String? vehicleId;

  final RecordDetailController? controller;

  @override
  String toString() {
    return 'RecordDetailRouteArgs{key: $key, recordId: $recordId, vehicleId: $vehicleId, controller: $controller}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecordDetailRouteArgs) return false;
    return key == other.key &&
        recordId == other.recordId &&
        vehicleId == other.vehicleId &&
        controller == other.controller;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      recordId.hashCode ^
      vehicleId.hashCode ^
      controller.hashCode;
}

/// generated route for
/// [SettingsView]
class SettingsRoute extends PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    Key? key,
    SettingsController? controller,
    List<PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>(
        orElse: () => const SettingsRouteArgs(),
      );
      return SettingsView(key: args.key, controller: args.controller);
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, this.controller});

  final Key? key;

  final SettingsController? controller;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, controller: $controller}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SettingsRouteArgs) return false;
    return key == other.key && controller == other.controller;
  }

  @override
  int get hashCode => key.hashCode ^ controller.hashCode;
}

/// generated route for
/// [TimelineFeedView]
class TimelineFeedRoute extends PageRouteInfo<TimelineFeedRouteArgs> {
  TimelineFeedRoute({
    Key? key,
    TimelineController? controller,
    VoidCallback? onOpenGarage,
    List<PageRouteInfo>? children,
  }) : super(
         TimelineFeedRoute.name,
         args: TimelineFeedRouteArgs(
           key: key,
           controller: controller,
           onOpenGarage: onOpenGarage,
         ),
         initialChildren: children,
       );

  static const String name = 'TimelineFeedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimelineFeedRouteArgs>(
        orElse: () => const TimelineFeedRouteArgs(),
      );
      return TimelineFeedView(
        key: args.key,
        controller: args.controller,
        onOpenGarage: args.onOpenGarage,
      );
    },
  );
}

class TimelineFeedRouteArgs {
  const TimelineFeedRouteArgs({this.key, this.controller, this.onOpenGarage});

  final Key? key;

  final TimelineController? controller;

  final VoidCallback? onOpenGarage;

  @override
  String toString() {
    return 'TimelineFeedRouteArgs{key: $key, controller: $controller, onOpenGarage: $onOpenGarage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TimelineFeedRouteArgs) return false;
    return key == other.key &&
        controller == other.controller &&
        onOpenGarage == other.onOpenGarage;
  }

  @override
  int get hashCode =>
      key.hashCode ^ controller.hashCode ^ onOpenGarage.hashCode;
}
