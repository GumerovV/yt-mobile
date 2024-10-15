import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/data/models/video.dart';
import 'package:flutter_yt_v2/utils/format_date.dart';
import 'package:flutter_yt_v2/utils/format_number.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  const VideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white10)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                 AspectRatio(
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
            const SizedBox(height: 10),
            Row(
              children: [
                ClipRRect(
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
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.name.toString(),
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${video.user?.name?.isNotEmpty == true ? video.user!.name : video.user?.email} · ${formatNumber(video.views ?? 0)} views",
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white38, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        timeAgo(DateTime.parse(video.createdAt.toString())),
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white38, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
