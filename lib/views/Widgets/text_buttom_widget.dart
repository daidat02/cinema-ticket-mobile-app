import 'package:flutter/material.dart';

class TextButtonWidget extends StatefulWidget {
  final String buttonText;
  final String pathName;
  final int activeColor;
  final int? defaultColor;
  final bool? isReleased; // Thêm tham số isReleased
  final String? titleAppbar;

  const TextButtonWidget(
      {super.key,
      required this.buttonText,
      required this.pathName,
      required this.activeColor,
      this.defaultColor,
      this.isReleased,
      this.titleAppbar // Thêm vào constructor
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
        Navigator.pushNamed(
          context,
          widget.pathName,
          arguments: {
            'isReleased': widget.isReleased,
            'titleAppbar': widget.titleAppbar
          }, // Truyền isReleased qua arguments
        ).then((value) {
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
          color: isPressed ? Color(widget.activeColor) : Colors.black,
        ),
      ),
    );
  }
}
