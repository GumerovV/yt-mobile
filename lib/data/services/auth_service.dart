import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_yt_v2/constants.dart';

class AuthService {
  static Future<dynamic> login(String email, String password) async {
    print('Service!!!');
    try {
      final response = await http.post(
        Uri.parse("$BASE_API_URL/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Успешный вход
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['message']; // Сообщение об ошибке
      }
    } catch (e) {
      print('Login error: $e');
      throw e;
    }
  }

  static Future<dynamic> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_API_URL/auth/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Успешная регистрация
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['message'];
      }
    } catch (e) {
      print('Register error: $e');
      throw e;
    }
  }
}
