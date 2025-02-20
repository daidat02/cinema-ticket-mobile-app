import 'package:flutter/material.dart';

class ListMovieScreen extends StatefulWidget {
  const ListMovieScreen({super.key});

  @override
  State<ListMovieScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ListMovie'),
      ),
    );
  }
}
