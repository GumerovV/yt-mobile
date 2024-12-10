import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/data/models/user.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/data/services/video_service.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/widgets/video/like_button/cubit/like_button_state.dart';

class LikeButtonCubit extends Cubit<LikeButtonState> {
  LikeButtonCubit() : super(LikeButtonLoadingState());

  void likeVideo(String vidoeId) async {
    try{
      emit(LikeButtonLoadingState());
      await VideoService.updateLikes(vidoeId);
      bool isLiked = await checkLike(vidoeId);
      emit(LikeButtonLoadedState(isLiked: isLiked));
    }
    catch (e){
      emit(LikeButtonErrorState(err: e));
    }
  }

  void initializeButton(String videoId) async {
    emit(LikeButtonLoadingState());
    bool isLiked = await checkLike(videoId);
    emit(LikeButtonLoadedState(isLiked: isLiked));
  }

  Future<bool> checkLike(String videoId) async{
    final User profile = await getIt.get<UserRepository>().getProfile();
    bool isLiked = false;
    for (var like in profile.liked!) {
      like.id.toString() == videoId ? isLiked = true : isLiked = isLiked;
    }

    return isLiked;
  }
}