import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PageAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.blue,
        leadingWidth: 30,
        iconTheme: const IconThemeData(
          color: Colors.white, // Màu của icon back
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // SvgPicture.asset(
            //   'assets/icons/close_icon.svg',
            //   height: 18,
            //   width: 18,
            // ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
