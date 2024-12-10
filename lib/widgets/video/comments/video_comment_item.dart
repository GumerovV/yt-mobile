import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/data/models/comment.dart';
import 'package:flutter_yt_v2/widgets/user_avatar.dart';

class VideoCommentItem extends StatelessWidget {
  final Comment comment;
  const VideoCommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          UserAvatar(user: comment.user!),
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${comment.user!.name!.isNotEmpty ? comment.user!.name : comment.user!.email}", style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,),),
              Text("${comment.message}"),
            ],
          ),
        ],
      ),
    );
  }
}