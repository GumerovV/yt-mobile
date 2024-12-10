import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/data/models/user.dart';
import 'package:flutter_yt_v2/utils/format_number.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/subscribe_button_provider.dart';
import 'package:flutter_yt_v2/widgets/user_avatar.dart';
import 'package:flutter_yt_v2/widgets/video/like_button/like_button_provider.dart';

class ChannelInfo extends StatelessWidget {
  final User user;
  final int videoId;
  
  const ChannelInfo({super.key, required this.user, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.white10))
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  UserAvatar(user: user),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!.isNotEmpty == true ? user.name! : user.email!,
                          style: theme.textTheme.bodySmall!.copyWith(fontSize: 17),
                          overflow: TextOverflow.ellipsis, // предотвращение переполнения текста
                        ),
                        Text(
                          "${formatNumber(user.subscribersCount ?? 0)} subscribers",
                          style: const TextStyle(color: Colors.white30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                LikeButtonProvider(videoId: videoId),
                const SizedBox(width: 5,),
                SubscribeButtonProvider(userId: user.id!.toInt()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}