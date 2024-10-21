import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/cubit/subscribe_button_cubit.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/subscribe_button.dart';

class SubscribeButtonProvider extends StatelessWidget {
  final int userId;

  const SubscribeButtonProvider({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: SubscribeButtonCubit(),
        ),
        BlocProvider.value(
          value: getIt.get<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          // Если пользователь не авторизован, кнопку не показываем
          if (state is AuthorizedState && state.userData.id != userId) {
            return SubscribeButton(userId: userId);
          }
          return const SizedBox.shrink(); // Пустое место, если пользователь не авторизован
        },
      ),
    );
  }
}
