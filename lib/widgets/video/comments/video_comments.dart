import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/data/models/comment.dart';
import 'package:flutter_yt_v2/widgets/video/comments/video_comment_item.dart';

class VideoComments extends StatelessWidget {
  final List<Comment> comments;
  const VideoComments({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            "Комментарии", 
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 17, 
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) => VideoCommentItem(comment: comments[index]),
            ),
          ),
        ],
      ),
    );
  }
}
