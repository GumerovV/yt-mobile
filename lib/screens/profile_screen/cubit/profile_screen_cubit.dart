import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:flutter_yt_v2/screens/profile_screen/cubit/profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState>{
  final UserRepository userRepository;

  ProfileScreenCubit({required this.userRepository}) : super(ProfileLoadingState());

  Future<void> getProfile() async{
    try {
      final profile = await userRepository.getProfile();
      emit(ProfileFullFieldedState(profile: profile));
    }
    catch (e) {
      emit(ProfileErrorState(err: e));
    }
  }
}