import 'dart:convert';

import 'package:flutter_yt_v2/constants.dart';
import 'package:http/http.dart' as http;

class VideoService {
  static const VIDEO_API_URL = "$BASE_API_URL/video";

  static Future<dynamic> getVideos() async {
    try{
      final response = await http.get(Uri.parse(VIDEO_API_URL));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Успешная регистрация
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