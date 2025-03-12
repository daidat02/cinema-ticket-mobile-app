import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PageAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Đặt backgroundColor trong suốt để gradient hiển thị
      backgroundColor: Colors.transparent,
      elevation: 0,
      // Sử dụng flexibleSpace để thêm gradient
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 148, 170, 237), // Màu đậm ở dưới
              Color(0xffEEF6FF), // Màu sáng ở trên
            ],
          ),
        ),
      ),
      leadingWidth: 30,
      iconTheme: const IconThemeData(
        color: Color(0xff3B4054), // Màu của icon back
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
          // Nếu cần, có thể bật phần icon này
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
