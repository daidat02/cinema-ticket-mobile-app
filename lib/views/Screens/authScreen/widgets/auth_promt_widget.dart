import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthPromtWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const AuthPromtWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff3B4054),
            ),
            text: text1,
            children: [
              TextSpan(
                text: text2,
                style: const TextStyle(color: Color(0xff3461FD), fontSize: 14),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              )
            ]),
      ),
    );
  }
}
