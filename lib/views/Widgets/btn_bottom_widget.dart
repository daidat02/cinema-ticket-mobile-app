import 'package:flutter/material.dart';

class BtnBottomWidget<T> extends StatelessWidget {
  final String title;
  final T data;
  final Function(T) onPressed;
  const BtnBottomWidget(
      {super.key,
      required this.title,
      required this.data,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3461FD), // Màu nền
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Bo góc
            ),
          ),
          onPressed: () => onPressed(data),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700), // Màu chữ
          ),
        ),
      ),
    );
  }
}
