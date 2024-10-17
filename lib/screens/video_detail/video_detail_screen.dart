import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_state.dart';
import 'package:flutter_yt_v2/screens/video_detail/cubit/video_detail_screen_cubit.dart';
import 'package:flutter_yt_v2/screens/video_detail/cubit/video_detail_screen_state.dart';
import 'package:flutter_yt_v2/widgets/video/video_player.dart';

@RoutePage()
class VideoDetailScreen extends StatelessWidget implements AutoRouteWrapper{
  final int id;

  const VideoDetailScreen({super.key, @PathParam("id") required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<VideoDetailScreenCubit>().getVideoById(id.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Video $id"),
      ),
      body: BlocBuilder<VideoDetailScreenCubit, VideoDetailScreenState>(
        builder: (context, state) {
          if (state is VideoDetailLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state is VideoDetailLoadedState){
            return CustomVideoPlayer(videoUrl: state.video.videoPath!);
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