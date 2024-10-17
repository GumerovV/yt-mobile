import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/app_router.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_state.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/utils/format_number.dart';
import 'package:flutter_yt_v2/widgets/error_snackbar.dart';
import 'package:flutter_yt_v2/widgets/user_avatar.dart';
import 'package:flutter_yt_v2/widgets/video/video_list.dart';
import 'package:flutter_yt_v2/widgets/video/video_list_horizontal.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
  class ProfileScreen extends StatelessWidget implements AutoRouteWrapper {
    const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
      context.read<ProfileScreenCubit>().getProfile();
      final theme = Theme.of(context);
      
      return Scaffold(
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProfileScreenCubit>().getProfile();
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          snap: true,
                          title: const Text("Профиль", style: TextStyle(color: Colors.white),),
                          centerTitle: true,
                          automaticallyImplyLeading: false,
                          actions: [
                            IconButton(icon: const Icon(Icons.exit_to_app_sharp, color: Colors.white70,), onPressed: context.read<AuthCubit>().logout,),
                          ],
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                color: const Color.fromARGB(255, 31, 29, 43),
                              ),
                          ),
                          pinned: false,
                          floating: true, // Позволяет AppBar плавно появляться и исчезать
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  UserAvatar(user: state.profile, width: 100, height: 100,),
                                  const SizedBox(width: 25,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${state.profile.name}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                      Text("${state.profile.email}", style: const TextStyle(color: Colors.white30)),
                                      Text("${formatNumber(state.profile.subscribersCount ?? 0)} subscribers", style: const TextStyle(color: Colors.white30)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text("Мои видео >", style: theme.textTheme.bodyLarge,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        VideoListHorizontal(videos: state.profile.videos ?? []),
                        SliverToBoxAdapter(
                          child: 
                              Row(
                                children: [
                                  Text("Понравившиеся видео >", style: theme.textTheme.bodyLarge,),
                                ],
                              ),
                        ),
                        VideoListHorizontal(videos: state.profile.liked ?? []),
                        SliverToBoxAdapter(
                          child: 
                              Row(
                                children: [
                                  Text("Подписки >", style: theme.textTheme.bodyLarge,),
                                ],
                              ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 100, // Задаем высоту для корректного отображения аватаров и текстов
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal, // Горизонтальный скроллинг
                              itemCount: state.profile.subscriptions!.length,
                              itemBuilder: (context, index) {
                                final sub = state.profile.subscriptions![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Отступы между элементами
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center, // Выравнивание по левому краю внутри колонки
                                    children: [
                                      UserAvatar(user: sub), // Аватар пользователя
                                      const SizedBox(height: 5),
                                      Text(
                                        sub.name!.isNotEmpty == true ? sub.name! : sub.email!,
                                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white30),
                                      ),
                                      Text("${formatNumber(sub.subscribersCount ?? 0)} подписч.", style: theme.textTheme.bodySmall?.copyWith(color: Colors.white30),),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                );
              }
          
              if (state is ProfileErrorState){
                //ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("Ошибка авторизации: ${state.err}".toString()));
                //context.router.navigate(const LoginRoute());
                return RefreshIndicator(
                  onRefresh: () async { context.read<ProfileScreenCubit>().getProfile();},
                  child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: Center(child: Text(state.err.toString()),))
                    ],
                  )
                );
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
                BlocProvider.value(
                  value: getIt.get<AuthCubit>(),
                  child: this,
                ),
                BlocProvider.value(
                  value: ProfileScreenCubit(userRepository: getIt.get<UserRepository>()),
                  child: this,
                ),
              ],
              child: this,
            );
      }
  }