import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/utils/format_date.dart';
import 'package:flutter_yt_v2/utils/format_number.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  final bool smallVideoItem;
  final bool withoutUser;
  const VideoItem({super.key, required this.video, this.smallVideoItem = false, this.withoutUser = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(VideoDetailRoute(id: video.id!));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            border: !smallVideoItem ? const Border(bottom: BorderSide(color: Colors.white10)) : const Border(),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                SizedBox(
                  child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      "$BASE_URL/${video.thumbnailPath}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                              ),
                ),
              Positioned(
                right: 8, // Отступ справа
                bottom: 8, // Отступ снизу
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 5,
                    ),
                    color: Colors.black.withOpacity(0.7), // Полупрозрачный фон
                    child: Text(
                      "${video.duration.toString()} мин.",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
                ],
              ),
              !smallVideoItem ? const SizedBox(height: 10): const SizedBox(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  !smallVideoItem && !withoutUser ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "$BASE_URL/${video.user!.avatarPath}",
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.person_pin,
                            size: 42,
                            color: Colors.white30,
                          ),
                        );
                      },
                    ),
                  ) : const SizedBox(),
                 !smallVideoItem ? const SizedBox(width: 15) : const SizedBox.shrink(),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !smallVideoItem ? Text(
                          video.name.toString(),
                          maxLines: 2,
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                        ) :
                        Text(
                          video.name.toString(),
                          maxLines: 2,
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        !smallVideoItem && !withoutUser || video.user?.name?.isNotEmpty == true || video.user?.email?.isNotEmpty == true ? Text(
                          "${video.user?.name?.isNotEmpty == true ? video.user!.name : video.user?.email} · ${formatNumber(video.views ?? 0)} views",
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white38, fontSize: 12),
                          overflow: TextOverflow.ellipsis,  
                        ) : Container(),
                        Text(
                          timeAgo(DateTime.parse(video.createdAt.toString())),
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white38, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  !smallVideoItem ? const SizedBox(width: 15) : const SizedBox.shrink(),
                ],
              ),
              !smallVideoItem ? const SizedBox(height: 15) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
