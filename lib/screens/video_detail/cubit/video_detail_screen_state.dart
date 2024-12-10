import 'package:flutter_yt_v2/data/models/video.dart';

abstract class VideoDetailScreenState {}

class VideoDetailLoadingState extends VideoDetailScreenState {}

class VideoDetailLoadedState extends VideoDetailScreenState {
  final Video video;

  VideoDetailLoadedState({required this.video}); 
}

class VideoDetailErrorState extends VideoDetailScreenState {
  final Object err;

  VideoDetailErrorState({required this.err});
}