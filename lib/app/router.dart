import 'package:auto_route/auto_route.dart';
import 'package:wedlist/features/auth/view/welcome_screen.dart';
import 'package:wedlist/features/auth/view/create_room_screen.dart';
import 'package:wedlist/features/auth/view/join_room_screen.dart';
import 'package:wedlist/features/checklist/view/checklist_screen.dart';
import 'package:wedlist/features/checklist/view/add_edit_item_screen.dart';
import 'package:wedlist/features/settings/view/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, initial: true),
        AutoRoute(page: CreateRoomRoute.page),
        AutoRoute(page: JoinRoomRoute.page),
        AutoRoute(page: ChecklistRoute.page),
        AutoRoute(page: AddEditItemRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
