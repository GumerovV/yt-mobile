import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/screens/auth/login_screen.dart';
import 'package:flutter_yt_v2/screens/channel/channel_screen.dart';
import 'package:flutter_yt_v2/screens/home/home_screen.dart';
import 'package:flutter_yt_v2/screens/profile_screen/profile_screen.dart';
import 'package:flutter_yt_v2/screens/root_screen.dart';
import 'package:flutter_yt_v2/screens/trends/trends_screen.dart';
import 'package:flutter_yt_v2/screens/video_detail/video_detail_screen.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true, path: "/"),
    AutoRoute(page: RootRoute.page, path: "/", children: [
      AutoRoute(page: HomeRoute.page, path: "home"),
      AutoRoute(page: TrendsRoute.page, path: "trends"),
      AutoRoute(page: ProfileRoute.page, path: "profile"),
    ]),
    AutoRoute(page: VideoDetailRoute.page, path: "/video/:id"),
    AutoRoute(page: ChannelRoute.page, path: "/channel/:id"),
  ];
}