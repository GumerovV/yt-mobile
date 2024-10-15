import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_cubit.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_state.dart';
import 'package:flutter_yt_v2/screens/profile_screen/profile_screen.dart';
import 'package:flutter_yt_v2/widgets/video/video_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
            return  CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: true,
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
                SliverList.builder(
                  itemCount: state.videos.length,
                  itemBuilder: (context, index) {
                    return VideoItem(video: state.videos[index]);
                  },
                ),
              ],
            );
          }
          if (state is VideosErrorState){
            return Center(child: Text("Somthing went wrong...\n${state.err.toString()}"),);
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: theme.primaryColor,
          unselectedItemColor: Colors.white30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
