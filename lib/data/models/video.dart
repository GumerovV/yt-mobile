import 'package:flutter_yt_v2/data/models/comment.dart';
import 'package:flutter_yt_v2/data/models/user.dart';

class Video {
    int? id;
    String? createdAt;
    String? updatedAt;
    String? name;
    bool? isPublic;
    int? views;
    int? likesCount;
    int? duration;
    String? description;
    String? videoPath;
    String? thumbnailPath;
    User? user;
    List<Comment?>? comments;

    Video({this.id, this.createdAt, this.updatedAt, this.name, this.isPublic, this.views, this.likesCount, this.duration, this.description, this.videoPath, this.thumbnailPath, this.user, this.comments}); 

    Video.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        createdAt = json['createdAt'];
        updatedAt = json['updatedAt'];
        name = json['name'];
        isPublic = json['isPublic'];
        views = json['views'];
        likesCount = json['likesCount'];
        duration = json['duration'];
        description = json['description'];
        videoPath = json['videoPath'];
        thumbnailPath = json['thumbnailPath'];
        user = json['user'] != null ? User?.fromJson(json['user']) : null;
        if (json['comments'] != null) {
         comments = <Comment>[];
         json['comments'].forEach((v) {
         comments!.add(Comment.fromJson(v));
        });
      }
    }
}
