import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/User.dart';
import 'package:shop/providers/authProvider.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/views/Screens/main_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('vi', null);

  // Kiểm tra xem đã lưu Access Token và thông tin user chưa
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');
  final userData = prefs.getString('user');

  User? user;
  if (token != null && userData != null) {
    // Chuyển đổi dữ liệu JSON sang model User
    user = User.fromJson(jsonDecode(userData));
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(user: user, accessToken: token),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent, // Xóa hiệu ứng sóng khi nhấn
        highlightColor: Colors.transparent, // Xóa hiệu ứng sáng khi nhấn giữ
        hoverColor: Colors.transparent, // Xóa hiệu ứng hover trên desktop
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: const MainPage(),
      onGenerateRoute: generateRoute,
    );
  }
}
