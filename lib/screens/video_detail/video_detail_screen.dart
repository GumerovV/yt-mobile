import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_state.dart';
import 'package:flutter_yt_v2/screens/video_detail/cubit/video_detail_screen_cubit.dart';
import 'package:flutter_yt_v2/screens/video_detail/cubit/video_detail_screen_state.dart';
import 'package:flutter_yt_v2/utils/format_number.dart';
import 'package:flutter_yt_v2/widgets/channel_info.dart';
import 'package:flutter_yt_v2/widgets/video/video_player.dart';

@RoutePage()
class VideoDetailScreen extends StatelessWidget implements AutoRouteWrapper{
  final int id;

  const VideoDetailScreen({super.key, @PathParam("id") required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<VideoDetailScreenCubit>().getVideoById(id.toString());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<VideoDetailScreenCubit, VideoDetailScreenState>(
        builder: (context, state) {
          if (state is VideoDetailLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state is VideoDetailLoadedState){
            return Column(
              children: [
                CustomVideoPlayer(videoUrl: state.video.videoPath!),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.video.name}",
                        style: theme.textTheme.bodyLarge!.copyWith(fontSize: 17),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(formatNumber(state.video.views!), style: const TextStyle(color: Colors.white30)),
                          const SizedBox(width: 5,),
                          const Icon(Icons.remove_red_eye_rounded, color: Colors.white30, size: 17,),
                          const SizedBox(width: 10,),
                          Text(formatNumber(state.video.likesCount!), style: const TextStyle(color: Colors.white30)),
                          const SizedBox(width: 5,),
                          const Icon(Icons.heart_broken, color: Colors.white30, size: 17,),
                        ],
                      ),
                    ],
                  ),
                ),
                ChannelInfo(user: state.video.user!, videoId: state.video.id!,),
              ],
            );
          }
          if (state is VideoDetailErrorState){
             return Center(child: Text("${state.err}"),);
          }

          return const SizedBox();
        },
      ),
    );
  }
  
  @override
  Widget wrappedRoute(BuildContext context) {
   return BlocProvider(
    create: (context) => VideoDetailScreenCubit(),
    child: this,
   );
  }
}