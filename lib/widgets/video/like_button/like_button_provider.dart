import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/widgets/video/like_button/cubit/like_button_cubit.dart';
import 'package:flutter_yt_v2/widgets/video/like_button/like_button.dart';

class LikeButtonProvider extends StatelessWidget {
  final int videoId;
  const LikeButtonProvider({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: LikeButtonCubit(),
        ),
        BlocProvider.value(
          value: getIt.get<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          // Если пользователь не авторизован, кнопку не показываем
          if (state is AuthorizedState) {
            return LikeButton(videoId: videoId);
          }
          return const SizedBox.shrink(); // Пустое место, если пользователь не авторизован
        },
      ),
    );
  }
}