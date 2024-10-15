import 'package:flutter_yt_v2/data/models/video.dart';

abstract class VideosState {}

class VideosLoadingState extends VideosState {}

class VidoesLoadedState extends VideosState {
  final List<Video> videos;

  VidoesLoadedState({required this.videos});
}

class VideosErrorState extends VideosState {
  final Object err;

  VideosErrorState({required this.err});
}