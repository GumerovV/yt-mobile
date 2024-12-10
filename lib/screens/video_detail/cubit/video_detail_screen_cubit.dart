import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/data/repositories/video_repository.dart';
import 'package:flutter_yt_v2/screens/video_detail/cubit/video_detail_screen_state.dart';

class VideoDetailScreenCubit extends Cubit<VideoDetailScreenState> {
  VideoDetailScreenCubit() : super(VideoDetailLoadingState());

  void getVideoById(String id) async {
    try{
      emit(VideoDetailLoadingState());
      final Video video = await VideoRepository.getVideoById(id);
      print(video);
      emit(VideoDetailLoadedState(video: video));
    }
    catch (e){
      emit(VideoDetailErrorState(err: e));
    }
  }
}