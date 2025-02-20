import 'package:flutter/material.dart';
import 'package:shop/routes/routes.dart';
import 'package:shop/views/Screens/main_page.dart';

void main() {
  runApp(const MyApp());
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
