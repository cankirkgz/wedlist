// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddEditItemRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddEditItemScreen(),
      );
    },
    ChecklistRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChecklistScreen(),
      );
    },
    CreateRoomRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateRoomScreen(),
      );
    },
    JoinRoomRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const JoinRoomScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [AddEditItemScreen]
class AddEditItemRoute extends PageRouteInfo<void> {
  const AddEditItemRoute({List<PageRouteInfo>? children})
      : super(
          AddEditItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddEditItemRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChecklistScreen]
class ChecklistRoute extends PageRouteInfo<void> {
  const ChecklistRoute({List<PageRouteInfo>? children})
      : super(
          ChecklistRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChecklistRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateRoomScreen]
class CreateRoomRoute extends PageRouteInfo<void> {
  const CreateRoomRoute({List<PageRouteInfo>? children})
      : super(
          CreateRoomRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateRoomRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [JoinRoomScreen]
class JoinRoomRoute extends PageRouteInfo<void> {
  const JoinRoomRoute({List<PageRouteInfo>? children})
      : super(
          JoinRoomRoute.name,
          initialChildren: children,
        );

  static const String name = 'JoinRoomRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
