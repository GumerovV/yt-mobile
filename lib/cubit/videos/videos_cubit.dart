import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_state.dart';
import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/data/repositories/video_repository.dart';

class VideosCubit extends Cubit<VideosState>{
  VideosCubit() : super(VideosLoadingState());

  void getVideos() async {
    try{
      final List<Video> videos = await VideoRepository.getVideos();
      emit(VidoesLoadedState(videos: videos));
    }
    catch (e){
      emit(VideosErrorState(err: e));
    }
  }
}