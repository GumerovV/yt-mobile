import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/app_router.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/data/repositories/auth_repository.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_state.dart';

@RoutePage()
  class ProfileScreen extends StatelessWidget implements AutoRouteWrapper {
    const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
      context.read<ProfileScreenCubit>().getProfile();

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Профиль"),
          actions: [IconButton(onPressed: () => context.read<AuthCubit>().logout(), icon: const Icon(Icons.exit_to_app))],
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print("$state");
            if (state is NoAuthState){
             context.router.navigate(const LoginRoute());
            }
          },
          child: BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
            builder: (context, state) {
              if (state is ProfileLoadingState){
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileFullFieldedState){
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          "$BASE_URL/${state.profile.avatarPath}",
                            fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ); // Если произошла ошибка загрузки
                                },
                        ),
                      )
                    ],
                  ),
                );
              }
          
              if (state is ProfileErrorState){
                return Center(child: Text(state.err.toString()),);
              }
          
              return const SizedBox();
            }
            ),
        ),
        );
    }
    
      @override
      Widget wrappedRoute(BuildContext context) {
        return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AuthCubit(authRepository: AuthRepository()),
                  child: this,
                ),
                BlocProvider(
                  create: (context) => ProfileScreenCubit(userRepository: UserRepository()),
                  child: this,
                ),
              ],
              child: const ProfileScreen(), // Экран профиля использует оба кубита
            );
      }
  }