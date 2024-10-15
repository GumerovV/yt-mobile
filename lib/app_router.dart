import 'package:auto_route/auto_route.dart';
import 'package:flutter_yt_v2/screens/auth/login_screen.dart';
import 'package:flutter_yt_v2/screens/home/home_screen.dart';
import 'package:flutter_yt_v2/screens/profile_screen/profile_screen.dart';
import 'package:flutter_yt_v2/screens/root_screen.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RootRoute.page, initial: true, path: "/", children: [
      AutoRoute(page: LoginRoute.page, initial: true, path: "auth"),
      AutoRoute(page: HomeRoute.page, path: "home"),
      AutoRoute(page: ProfileRoute.page, path: "profile"),
    ]),
  ];
}