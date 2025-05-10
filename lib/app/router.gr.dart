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
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AddEditItemRouteArgs>(
          orElse: () =>
              AddEditItemRouteArgs(roomId: pathParams.getString('roomId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddEditItemScreen(
          key: args.key,
          roomId: args.roomId,
          item: args.item,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    ChecklistRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChecklistRouteArgs>(
          orElse: () =>
              ChecklistRouteArgs(roomId: pathParams.getString('roomId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChecklistScreen(
          key: args.key,
          roomId: args.roomId,
        ),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordScreen(),
      );
    },
    JoinRoomRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const JoinRoomScreen(),
      );
    },
    RoomCreatedRoute.name: (routeData) {
      final args = routeData.argsAs<RoomCreatedRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RoomCreatedScreen(
          key: args.key,
          roomId: args.roomId,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
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
class AddEditItemRoute extends PageRouteInfo<AddEditItemRouteArgs> {
  AddEditItemRoute({
    Key? key,
    required String roomId,
    ChecklistItem? item,
    List<PageRouteInfo>? children,
  }) : super(
          AddEditItemRoute.name,
          args: AddEditItemRouteArgs(
            key: key,
            roomId: roomId,
            item: item,
          ),
          rawPathParams: {'roomId': roomId},
          initialChildren: children,
        );

  static const String name = 'AddEditItemRoute';

  static const PageInfo<AddEditItemRouteArgs> page =
      PageInfo<AddEditItemRouteArgs>(name);
}

class AddEditItemRouteArgs {
  const AddEditItemRouteArgs({
    this.key,
    required this.roomId,
    this.item,
  });

  final Key? key;

  final String roomId;

  final ChecklistItem? item;

  @override
  String toString() {
    return 'AddEditItemRouteArgs{key: $key, roomId: $roomId, item: $item}';
  }
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChecklistScreen]
class ChecklistRoute extends PageRouteInfo<ChecklistRouteArgs> {
  ChecklistRoute({
    Key? key,
    required String roomId,
    List<PageRouteInfo>? children,
  }) : super(
          ChecklistRoute.name,
          args: ChecklistRouteArgs(
            key: key,
            roomId: roomId,
          ),
          rawPathParams: {'roomId': roomId},
          initialChildren: children,
        );

  static const String name = 'ChecklistRoute';

  static const PageInfo<ChecklistRouteArgs> page =
      PageInfo<ChecklistRouteArgs>(name);
}

class ChecklistRouteArgs {
  const ChecklistRouteArgs({
    this.key,
    required this.roomId,
  });

  final Key? key;

  final String roomId;

  @override
  String toString() {
    return 'ChecklistRouteArgs{key: $key, roomId: $roomId}';
  }
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

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
/// [RoomCreatedScreen]
class RoomCreatedRoute extends PageRouteInfo<RoomCreatedRouteArgs> {
  RoomCreatedRoute({
    Key? key,
    required String roomId,
    List<PageRouteInfo>? children,
  }) : super(
          RoomCreatedRoute.name,
          args: RoomCreatedRouteArgs(
            key: key,
            roomId: roomId,
          ),
          initialChildren: children,
        );

  static const String name = 'RoomCreatedRoute';

  static const PageInfo<RoomCreatedRouteArgs> page =
      PageInfo<RoomCreatedRouteArgs>(name);
}

class RoomCreatedRouteArgs {
  const RoomCreatedRouteArgs({
    this.key,
    required this.roomId,
  });

  final Key? key;

  final String roomId;

  @override
  String toString() {
    return 'RoomCreatedRouteArgs{key: $key, roomId: $roomId}';
  }
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
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

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
