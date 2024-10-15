import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/app_router.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AutoTabsRouter(
      routes: const [
        LoginRoute(),
        HomeRoute(),
        ProfileRoute(),
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
                onTap: tabsRouter.setActiveIndex,
                items: const [
                  BottomNavigationBarItem(
                    label: 'Войти',
                    icon: Icon(Icons.check),
                  ),
                  BottomNavigationBarItem(
                    label: 'Главная',
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Профиль',
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}