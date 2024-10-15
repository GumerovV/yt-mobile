import 'package:flutter_yt_v2/data/models/user.dart';

class Comment {
    int? id;
    String? createdAt;
    String? updatedAt;
    String? message;
    User? user;

    Comment({this.id, this.createdAt, this.updatedAt, this.message, this.user}); 

    Comment.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        createdAt = json['createdAt'];
        updatedAt = json['updatedAt'];
        message = json['message'];
        user = json['user'] != null ? User?.fromJson(json['user']) : null;
    }
}