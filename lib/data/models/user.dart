import 'package:flutter_yt_v2/data/models/video.dart';

class User {
  String? email;
  String? name;
  bool? isVerified;
  int? subscribersCount;
  String? description;
  String? avatarPath;
  List<Video>? videos;
  List<User>? subscriptions;
  List<Video>? liked;

  User(
  this.name, this.isVerified, this.videos, this.subscriptions, this.liked, 
  {required this.email, required this.avatarPath, required this.description, required this.subscribersCount});

  User.fromJson(Map<String, dynamic> json) {
      email = json['email'] as String;
      name = json['name'] as String;
      isVerified = json['isVerified'] as bool;
      subscribersCount = json['subscribersCount'] ?? null;
      description = json['description'] ?? "";
      avatarPath = json['avatarPath'] as String;
      if (json['videos'] != null){
        videos = <Video>[]; 
        json['videos'].forEach((video) {
        videos!.add(Video.fromJson(video));
      });
      }
      if (json["subscriptions"] != null){
        subscriptions = <User>[];
        json["subscriptions"].forEach((user){
          subscriptions!.add(User.fromJson(user["toUser"]));
        });
      }
      if (json["liked"] != null){
         liked = <Video>[];
         json["liked"].forEach((video){
          liked!.add(Video.fromJson(video));
         });
      }
    }

}