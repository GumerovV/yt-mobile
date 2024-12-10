import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/widgets/error_snackbar.dart';
import 'package:flutter_yt_v2/widgets/video/like_button/cubit/like_button_cubit.dart';
import 'package:flutter_yt_v2/widgets/video/like_button/cubit/like_button_state.dart';

class LikeButton extends StatelessWidget {
  final int videoId;
  const LikeButton({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    context.read<LikeButtonCubit>().initializeButton(videoId.toString());
    final theme = Theme.of(context);

    return BlocListener<LikeButtonCubit, LikeButtonState>(
      listener: (context, state) {
        if (state is LikeButtonErrorState){
          errorSnackBar(state.err.toString());
        }
      },
      child: BlocBuilder<LikeButtonCubit, LikeButtonState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state is LikeButtonLoadingState 
                ? null // Отключить кнопку во время загрузки
                : () => context.read<LikeButtonCubit>().likeVideo(videoId.toString()),
            style: ElevatedButton.styleFrom(
              backgroundColor:  state is LikeButtonLoadedState && !state.isLiked ? Colors.red : Colors.white30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(1),
              minimumSize: const Size(40, 40)
            ),
            child: state is LikeButtonLoadingState // Условие для отображения индикатора загрузки
                ? const SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: CircularProgressIndicator(
                      color: Colors.white, // Цвет индикатора
                      strokeWidth: 2.0,
                    ),
                  )
                :  Icon(
                    state is LikeButtonLoadedState && state.isLiked
                        ? Icons.heart_broken
                        : Icons.heart_broken,
                    color: Colors.white,
                    size: 17,
                  ),
          ); 
        },
      ),
    );
  }
}