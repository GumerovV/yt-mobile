import 'dart:math';

import 'package:flutter_yt_v2/data/models/video.dart';

List<Video> shuffleVideos(List<Video> videos) {
  final random = Random();
  final shuffledVideos = List<Video>.from(videos);
  
  shuffledVideos.shuffle(random);
  
  return shuffledVideos;
}
