import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/widgets/video/video_item.dart';

class VideoList extends StatelessWidget {
  final List<Video> videos;
  final bool smallVideoItem;
  final bool withoutUser;

  const VideoList({super.key, required this.videos, this.smallVideoItem = false, this.withoutUser = false});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: VideoItem(video: videos[index], smallVideoItem: smallVideoItem, withoutUser: withoutUser,),
                    );
                  },
                );
  }
}