import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/app_router.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/service_locator.dart';

@RoutePage()
class RootScreen extends StatelessWidget implements AutoRouteWrapper {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isAuth = state is AuthorizedState;

        return AutoTabsRouter(
          routes: const [
            HomeRoute(),
            TrendsRoute(),
            ProfileRoute(), // Ensure ProfileRoute is always included
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);
        
            return Scaffold(
              body: child,
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white10)),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: theme.primaryColor,
                  unselectedItemColor: Colors.white30,
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (index) {
                    if (index == 2 && !isAuth) {
                      context.router.replace(const LoginRoute());
                    } else {
                      tabsRouter.setActiveIndex(index);
                    }
                  },
                  items: [
                    const BottomNavigationBarItem(
                      label: 'Главная',
                      icon: Icon(Icons.home),
                    ),
                    const BottomNavigationBarItem(
                      label: 'Тренды',
                      icon: Icon(Icons.local_fire_department),
                    ),
                    BottomNavigationBarItem(
                      label: isAuth ? 'Профиль' : 'Войти',
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<AuthCubit>(),
      child: this,
    );
  }
}
