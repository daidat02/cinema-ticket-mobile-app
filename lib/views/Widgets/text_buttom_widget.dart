import 'package:flutter/material.dart';

class TextButtonWidget extends StatefulWidget {
  final String buttonText;
  final String pathName;
  final int activeColor; // Màu khi được nhấn vào
  final int? defaultColor; // Màu mặc định
  const TextButtonWidget({
    super.key,
    required this.buttonText,
    required this.pathName,
    required this.activeColor,
    this.defaultColor,
  });

  @override
  State<TextButtonWidget> createState() => _TextButtomState();
}

class _TextButtomState extends State<TextButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
        Navigator.pushNamed(context, widget.pathName).then((value) {
          setState(() {
            isPressed = false;
          });
        });
      },
      child: Text(
        widget.buttonText,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isPressed ? Color(widget.activeColor) : Colors.black),
      ),
    );
  }
}
