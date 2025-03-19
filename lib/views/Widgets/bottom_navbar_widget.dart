import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget(
      {super.key, required this.selectedIndex, required this.onItemTapped});
  final Function(int) onItemTapped;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
              color: Color(0xffC8E1FF),
              borderRadius: BorderRadius.all(Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 225, 238, 253),
                    offset: Offset(0, 0),
                    blurRadius: 10)
              ]),
          child: GNav(
              gap: 8, // Khoảng cách giữa icon và label
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tabBackgroundColor: const Color.fromARGB(
                  255, 255, 255, 255), // Màu nền của tab được chọn
              activeColor:
                  const Color(0xff3461FD), // Màu icon + text khi được chọn
              iconSize: 24,
              textStyle: const TextStyle(
                  color: Color(0xff3461FD),
                  fontWeight: FontWeight.bold), // Màu chữ khi chọn
              color: const Color.fromARGB(
                  255, 0, 0, 0), // Màu icon + text khi không chọn
              selectedIndex: selectedIndex,
              onTabChange: onItemTapped,
              tabs: const [
                GButton(
                  icon: Iconsax.home,
                  text: 'Trang Chủ',
                ),
                GButton(
                  icon: Iconsax.camera,
                  text: 'Rạp Phim',
                ),
                GButton(
                  icon: Iconsax.heart,
                  text: 'Yêu Thích',
                ),
                GButton(
                  icon: Iconsax.user,
                  text: 'Cá Nhân',
                ),
              ])),
    );
  }
}
