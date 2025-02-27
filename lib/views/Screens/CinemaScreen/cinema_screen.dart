import 'package:flutter/material.dart';

class CinemaScreen extends StatefulWidget {
  const CinemaScreen({super.key});
  @override
  State<CinemaScreen> createState() => _CinemaState();
}

class _CinemaState extends State<CinemaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cinema Screen'),
      ),
    );
  }
}
