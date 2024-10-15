import 'package:flutter_yt_v2/data/models/user_data.dart';
import 'package:flutter_yt_v2/data/services/auth_service.dart';

class AuthRepository {
  
  Future<UserData> login(email, password) async{
    print('Repo!!!');
    try {
      dynamic userData = await AuthService.login(email, password);
      return UserData.fromJson(userData);
    }
    catch (e) {
      throw e;
    }
  }
}