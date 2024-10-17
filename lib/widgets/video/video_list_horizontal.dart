import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/widgets/video/video_item.dart';

class VideoListHorizontal extends StatelessWidget {
  final List<Video> videos;

  const VideoListHorizontal({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return videos.length > 0 ? SliverToBoxAdapter(
      child: SizedBox(
        height: 210,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0), // Опциональный отступ между элементами
              child: VideoItem(video: videos[index], smallVideoItem: true,),
            );
          },
        ),
      ),
    ) : 
    const SliverToBoxAdapter(child: Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(child: Text("Видео не найдены...", style: TextStyle(color: Colors.white30),)),
    ));
  }
}
