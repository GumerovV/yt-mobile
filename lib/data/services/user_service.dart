import 'dart:convert';

import 'package:flutter_yt_v2/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class UserService {
  static Future<dynamic> getProfile(GetStorage storage) async {
    // Получаем токен из GetStorage
    print("User Service");
    try {
      final String? accessToken = storage.read('accessToken');
      
      final response = await http.get(
        Uri.parse("$BASE_API_URL/user/profile"), 
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Добавляем заголовок авторизации
        },
      );

      print(response.body);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Успешная регистрация
      } 
      else {
          final errorResponse = jsonDecode(response.body);
          throw errorResponse['message'];
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<bool> subscribeToUser(int userId, GetStorage storage) async {
    try{
      final String? accessToken = storage.read('accessToken');
      final response = await http.patch(Uri.parse("$BASE_API_URL/user/subscribe/$userId"), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },);
        print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['message'];
      }
    }
    catch (e){
      throw e;
    }
  }
}
