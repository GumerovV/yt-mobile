import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_cubit.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_state.dart';
import 'package:flutter_yt_v2/widgets/video/video_list.dart';

@RoutePage()
class TrendsScreen extends StatelessWidget implements AutoRouteWrapper{
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VideosCubit>().getMostPopular();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<VideosCubit>().getMostPopular();
      },
      child: BlocBuilder<VideosCubit, VideosState>(
        builder: (context, state) {
          if (state is VideosLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state is VidoesLoadedState){
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: true,
                  title: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 55, // Ширина SVG
                    height: 27, // Высота SVG
                  ),
                  automaticallyImplyLeading: false,
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
                VideoList(videos: state.videos),
              ],
            );
          }
          if (state is VideosErrorState){
            return Center(child: Text("${state.err}"),);
          }
    
          return const SizedBox();
        },
      )
    );
  }
  
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosCubit(),
      child: this,
    );
  }
}