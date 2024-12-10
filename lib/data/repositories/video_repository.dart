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

  static Future<List<Video>> getMostPopular() async{
    try{
      final response = await VideoService.getMostPopular();
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

  static Future<Video> getVideoById(String id) async{
    try{
      final video = await VideoService.getVideoById(id);
      return Video.fromJson(video);
    }
    catch (e){
      throw e;
    }
  }

  static Future<void> updateLikes(String videoId) async {
    try{
      VideoService.updateLikes(videoId);
    }
    catch (e){
      throw e;
    }
  }
}