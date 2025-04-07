import 'package:flutter/material.dart';
import 'package:shop/views/Screens/CinemaScreen/cinema_screen.dart';
import 'package:shop/views/Screens/HomeScreen/home_page.dart';
import 'package:shop/views/Screens/ProfileScreen/profile_screen.dart';
import 'package:shop/views/Screens/authScreen/login_Screen.dart';
import 'package:shop/views/Screens/authScreen/register_screen.dart';
import 'package:shop/views/Screens/favoriteScreen/favorite_movie_screen.dart';
import 'package:shop/views/Widgets/bottom_navbar_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MyHomePage(),
    const CinemaScreen(),
    const FavoriteMoviesScreen(),
    const ProfileScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hiển thị các màn hình theo _selectedIndex
          Stack(
            children: List.generate(_screens.length, (index) {
              return Offstage(
                offstage: _selectedIndex != index,
                child: _screens[index],
              );
            }),
          ),
          // Navbar ở phía dưới
          Positioned(
            left: 0,
            right: 0,
            bottom: 0, // Khoảng cách từ bottom
            child: BottomNavBarWidget(
              selectedIndex: _selectedIndex,
              onItemTapped: onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
