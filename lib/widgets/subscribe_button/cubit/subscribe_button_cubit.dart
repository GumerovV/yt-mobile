import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/data/models/user.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/data/services/user_service.dart';
import 'package:flutter_yt_v2/service_locator.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/cubit/subscribe_button_state.dart';

class SubscribeButtonCubit extends Cubit<SubscribeButtonState>{
  SubscribeButtonCubit() : super(SubscribeButtonLoadingState());

  void subscribeToUser(int userId) async {
    try{
      emit(SubscribeButtonLoadingState());
      final isSubscribed = await getIt.get<UserRepository>().subscribeToUser(userId);
      emit(SubscribeButtonLoadedState(isSubscribed: isSubscribed));
    }
    catch (e){
      emit(SubscribeButtonErrorState(err: e));
    }
  }

  void initializeButton(int userId) async {
    User profile = await getIt.get<UserRepository>().getProfile();
    bool isSubscribed = false;
    for (var sub in profile.subscriptions!) {
      sub.id == userId ? isSubscribed = true : isSubscribed = isSubscribed;
    }
    emit(SubscribeButtonLoadedState(isSubscribed: isSubscribed));
  }
}