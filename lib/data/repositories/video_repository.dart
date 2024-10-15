import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/data/services/video_service.dart';

class VideoRepository {
  static Future<List<Video>> getVideos() async{
    try{
      final response = await VideoService.getVideos();
      final List<Video> videos = [];
      response.forEach((video){
        videos.add(Video.fromJson(video));
      });
      return videos;
    }
    catch (e){
      throw e;
    }
  }
}