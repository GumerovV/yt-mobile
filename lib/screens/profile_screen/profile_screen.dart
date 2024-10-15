  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_yt_v2/constants.dart';
  import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
  import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_cubit.dart';
  import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_state.dart';

  class ProfileScreen extends StatelessWidget {
    const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
      context.read<ProfileScreenCubit>().getProfile();  

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Профиль"),
          actions: [IconButton(onPressed: () => context.read<AuthCubit>().logout(), icon: const Icon(Icons.exit_to_app))],
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is NoAuthState){
              Navigator.pushReplacementNamed(context, "/");
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
  }