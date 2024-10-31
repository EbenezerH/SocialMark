
import 'package:flutter/material.dart';

import '../constant/constants.dart';
import '../theme/theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const MyAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      
      title: Column(
        children: [
          Text(title == null ? appName : title!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text(element,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ))
        ],
      ),
      centerTitle: true,
      actions: const [
        CircleAvatar(
        backgroundImage: AssetImage("assets/images/Vertical Lockup on White Background.jpg"),
        radius: 25,
      )]
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
