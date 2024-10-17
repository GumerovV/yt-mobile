import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/data/models/user.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final double width;
  final double height;
  
  const UserAvatar({super.key, required this.user, this.width = 42, this.height = 42});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              "$BASE_URL/${user.avatarPath}",
              width: width,
              height: height,
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
          );
  }
}