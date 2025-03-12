import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ToastWidget {
  static void show(BuildContext context, String message) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 17),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: const Color(0xff3461FD),
      messageText: Text(
        message,
        style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.w400),
      ),
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          Icons.info_outline,
          size: 32.0,
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 1),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
