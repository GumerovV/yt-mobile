// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChannelRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChannelRouteArgs>(
          orElse: () => ChannelRouteArgs(userId: pathParams.getInt('userId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ChannelScreen(
          key: args.key,
          userId: args.userId,
        )),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomeScreen()),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const LoginScreen()),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ProfileScreen()),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RootScreen()),
      );
    },
    TrendsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const TrendsScreen()),
      );
    },
    VideoDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VideoDetailRouteArgs>(
          orElse: () => VideoDetailRouteArgs(id: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: VideoDetailScreen(
          key: args.key,
          id: args.id,
        )),
      );
    },
  };
}

/// generated route for
/// [ChannelScreen]
class ChannelRoute extends PageRouteInfo<ChannelRouteArgs> {
  ChannelRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          ChannelRoute.name,
          args: ChannelRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
          initialChildren: children,
        );

  static const String name = 'ChannelRoute';

  static const PageInfo<ChannelRouteArgs> page =
      PageInfo<ChannelRouteArgs>(name);
}

class ChannelRouteArgs {
  const ChannelRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'ChannelRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RootScreen]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TrendsScreen]
class TrendsRoute extends PageRouteInfo<void> {
  const TrendsRoute({List<PageRouteInfo>? children})
      : super(
          TrendsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrendsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VideoDetailScreen]
class VideoDetailRoute extends PageRouteInfo<VideoDetailRouteArgs> {
  VideoDetailRoute({
    Key? key,
    required int id,
    List<PageRouteInfo>? children,
  }) : super(
          VideoDetailRoute.name,
          args: VideoDetailRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'VideoDetailRoute';

  static const PageInfo<VideoDetailRouteArgs> page =
      PageInfo<VideoDetailRouteArgs>(name);
}

class VideoDetailRouteArgs {
  const VideoDetailRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'VideoDetailRouteArgs{key: $key, id: $id}';
  }
}
