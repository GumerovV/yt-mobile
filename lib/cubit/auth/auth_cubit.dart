import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/data/repositories/auth_repository.dart';
import 'package:get_storage/get_storage.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepository authRepository;
  final GetStorage _storage = GetStorage();

  AuthCubit({required this.authRepository}) : super(NoAuthState());

  void login(email, password) async{
    emit(AuthLoadingState());
    try{
      final userData = await authRepository.login(email, password);
      print(userData);
      _storage.write('accessToken', userData.accessToken);
      emit(AuthorizedState(userData: userData));
    }
    catch (e){
      print('error!!!');
      emit(AuthErrorState(e: e));
    }
  }

  void logout(){
    _storage.remove('accessToken');
    emit(NoAuthState());
  }
}