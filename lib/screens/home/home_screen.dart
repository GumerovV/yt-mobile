import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_cubit.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_state.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/widgets/video/video_item.dart';
import 'package:flutter_yt_v2/widgets/video/video_list.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
  @override
  Widget wrappedRoute(BuildContext context) {
   return BlocProvider.value(
    value: getIt.get<VideosCubit>(),
    child: this,
   );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _screens = [
   "/",
   PROFILE_ROUTE,
   HOME_ROUTE,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushReplacementNamed(context, _screens[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.read<VideosCubit>().getVideos();

    return Scaffold(
      body: BlocBuilder<VideosCubit, VideosState>(
        builder: (context, state) {
          if (state is VideosLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VidoesLoadedState){
            return  RefreshIndicator(
              onRefresh: () async {
                context.read<VideosCubit>().getVideos();
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    snap: true,
                    automaticallyImplyLeading: false,
                    title: SvgPicture.asset(
                      'assets/logo.svg',
                      width: 55, // Ширина SVG
                      height: 27, // Высота SVG
                    ),
                    actions: [
                      IconButton(icon: const Icon(Icons.search, color: Colors.white70,), onPressed: (){},),
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
                  VideoList(videos: state.videos),
                ],
              ),
            );
          }
          if (state is VideosErrorState){
            return Center(child: Text("Somthing went wrong...\n${state.err.toString()}"),);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
