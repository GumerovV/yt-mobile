import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_cubit.dart';
import 'package:flutter_yt_v2/data/repositories/auth_repository.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/screens/auth/login_screen.dart';
import 'package:flutter_yt_v2/screens/home/home_screen.dart';
import 'package:flutter_yt_v2/screens/profile_screen/profile_screen.dart';
import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_cubit.dart';

class AppRouter {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthCubit _authCubit;

  AppRouter()
      : _authRepository = AuthRepository(),
        _userRepository = UserRepository(),
        _authCubit = AuthCubit(authRepository: AuthRepository());

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(  // Используем .value для передачи уже существующего кубита
            value: _authCubit,
            child: const LoginScreen(),
          ),
        );
      case PROFILE_ROUTE:
        return MaterialPageRoute(
          builder: (_) {
            // Проверяем состояние аутентификации
            final isAuthenticated = _authCubit.state is AuthorizedState;
            if (!isAuthenticated) {
              return BlocProvider.value(  // Используем .value для передачи уже существующего кубита
                value: _authCubit,
                child: const LoginScreen(),
              ); // Перенаправление на экран входа
            }
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _authCubit, // Передаем AuthCubit
                ),
                BlocProvider(
                  create: (context) => ProfileScreenCubit(userRepository: _userRepository), // Передаем ProfileScreenCubit
                ),
              ],
              child: const ProfileScreen(), // Экран профиля использует оба кубита
            );
          },
        );
      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(value: VideosCubit(), child: const HomeScreen(),),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(), // Страница по умолчанию
        );
    }
  }
}
