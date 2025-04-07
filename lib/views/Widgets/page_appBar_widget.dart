import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? showBackButton; // nullable

  const PageAppBarWidget({
    super.key,
    required this.title,
    this.showBackButton, // không gán mặc định
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading:
          showBackButton ?? true, // hiển thị mặc định nếu không truyền vào
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 148, 170, 237),
              Color(0xffEEF6FF),
            ],
          ),
        ),
      ),
      leadingWidth: 30,
      iconTheme: const IconThemeData(
        color: Color(0xff3B4054),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff3B4054),
            ),
          ),
          // Nếu bạn cần bật icon bên phải, bật phần này lên:
          // SvgPicture.asset(
          //   'assets/icons/close_icon.svg',
          //   height: 18,
          //   width: 18,
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
