import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YtAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YtAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      title: SvgPicture.asset('assets/logo.svg', width: 70, height: 35,),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded, color: Colors.white70,))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}