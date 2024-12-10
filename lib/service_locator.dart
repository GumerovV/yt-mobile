import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/videos/videos_cubit.dart';
import 'package:flutter_yt_v2/data/repositories/auth_repository.dart';
import 'package:flutter_yt_v2/data/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator(){
  //REPOSITORIES
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());

  //CUBIT
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(authRepository: getIt.get<AuthRepository>()));
  getIt.registerLazySingleton<VideosCubit>(() => VideosCubit());

  //STORAGE
  getIt.registerLazySingleton<GetStorage>(() => GetStorage());
}