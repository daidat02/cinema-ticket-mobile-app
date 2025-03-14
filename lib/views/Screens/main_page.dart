import 'package:flutter/material.dart';
import 'package:shop/views/Screens/CinemaScreen/cinema_screen.dart';
import 'package:shop/views/Screens/DiscountScreen/discount_screen.dart';
import 'package:shop/views/Screens/HomeScreen/home_page.dart';
import 'package:shop/views/Screens/ProfileScreen/profile_screen.dart';
import 'package:shop/views/Screens/authScreen/login_Screen.dart';
import 'package:shop/views/Screens/authScreen/register_screen.dart';
import 'package:shop/views/Widgets/bottom_nav_widget.dart';

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
    const LoginScreen(),
    const RegisterScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex, onItemTapped: onItemTapped));
  }
}
