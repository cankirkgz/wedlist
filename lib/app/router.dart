import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wedlist/features/auth/view/auth_screen.dart';
import 'package:wedlist/features/auth/view/forgot_password_screen.dart';
import 'package:wedlist/features/auth/view/welcome_screen.dart';
import 'package:wedlist/features/auth/view/create_room_screen.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/checklist/view/checklist_screen.dart';
import 'package:wedlist/features/checklist/view/add_edit_item_screen.dart';
import 'package:wedlist/features/room/view/join_room_screen.dart';
import 'package:wedlist/features/room/view/room_created_screen.dart';
import 'package:wedlist/features/settings/view/settings_screen.dart';
import 'package:wedlist/features/shared/view/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: RoomCreatedRoute.page),
        AutoRoute(page: JoinRoomRoute.page),
        AutoRoute(page: CreateRoomRoute.page),
        AutoRoute(page: ChecklistRoute.page),
        AutoRoute(page: AddEditItemRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
