import 'package:flutter_yt_v2/data/models/user.dart';
import 'package:flutter_yt_v2/data/services/user_service.dart';
import 'package:get_storage/get_storage.dart';

class UserRepository {
  final GetStorage _storage = GetStorage();

  Future<User> getProfile() async{
    try {
      dynamic profile = await UserService.getProfile(_storage);
      return User.fromJson(profile);
    } 
    catch (e) {
      throw e;
    }
  }

  Future<bool> subscribeToUser(userId) async {
    try{
      bool isSubscribed = await UserService.subscribeToUser(userId, _storage);
      return isSubscribed;
    }
    catch (e){
      throw e;
    }
  }
}