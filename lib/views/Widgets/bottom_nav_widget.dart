import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 20,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: const Color(0xFF0094FF),
      unselectedItemColor: Colors.grey,
      selectedFontSize: 13, // Đặt cùng kích thước chữ
      unselectedFontSize: 13, // để tắt hiệu ứng phóng to
      type: BottomNavigationBarType.fixed, // Giữ kích thước cố định
      items: [
        _buildNavItem('assets/icons/ticket_star_icon.svg', 'Chọn Phim', 0),
        _buildNavItem('assets/icons/cinema_icon.svg', 'Chọn Rạp', 1),
        _buildNavItem('assets/icons/discount_icon.svg', 'Ưu Đãi', 2),
        _buildNavItem('assets/icons/me_icon.svg', 'Tôi', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String iconPath, String label, int index) {
    Color iconColor =
        selectedIndex == index ? const Color(0xFF0094FF) : Colors.grey;

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}
