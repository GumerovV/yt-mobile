import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/data/models/user.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/widgets/error_snackbar.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/cubit/subscribe_button_cubit.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/cubit/subscribe_button_state.dart';

class SubscribeButton extends StatelessWidget {
  final int userId;

  const SubscribeButton({super.key, required this.userId});

  @override 
  Widget build(BuildContext context) {
    context.read<SubscribeButtonCubit>().initializeButton(userId);
    final theme = Theme.of(context);

    return BlocListener<SubscribeButtonCubit, SubscribeButtonState>(
      listener: (context, state) {
        if (state is SubscribeButtonErrorState){
          errorSnackBar(state.err.toString());
        }
      },
      child: BlocBuilder<SubscribeButtonCubit, SubscribeButtonState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state is SubscribeButtonLoadingState 
                ? null // Отключить кнопку во время загрузки
                : () => context.read<SubscribeButtonCubit>().subscribeToUser(userId), // Вызов метода при нажатии
            style: ElevatedButton.styleFrom(
              backgroundColor:  state is SubscribeButtonLoadedState && !state.isSubscribed ? theme.primaryColor : Colors.white30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: state is SubscribeButtonLoadingState // Условие для отображения индикатора загрузки
                  ? const SizedBox(
                      width: 22.0,
                      height: 22.0,
                      child: CircularProgressIndicator(
                        color: Colors.white, // Цвет индикатора
                        strokeWidth: 2.0,
                      ),
                    )
                  :  Text(
                      state is SubscribeButtonLoadedState && state.isSubscribed
                          ? 'Вы подписаны'
                          : 'Подписаться',
                      style: const TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
            ),
          );
        },
      ),
    );
  }
}