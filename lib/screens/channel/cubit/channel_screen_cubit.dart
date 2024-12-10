import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/data/models/user.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/screens/channel/cubit/channel_screen_state.dart';

class ChannelScreenCubit extends Cubit<ChannelScreenState> {
  ChannelScreenCubit() : super(ChannelLoadingState());

  void getUserById(String userId) async {
    try{
      emit(ChannelLoadingState());
      final User user = await UserRepository.getUserById(userId);
      emit(ChannelLoadedState(user: user));
    }
    catch (e){
      emit(ChannelErrorState(err: e));
    }
  }
}