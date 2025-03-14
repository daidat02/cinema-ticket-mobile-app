import 'package:flutter/material.dart';

class SubmitButtomWidget extends StatelessWidget {
  final VoidCallback submitForm;
  final String btnText;
  const SubmitButtomWidget(
      {super.key, required this.submitForm, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff3461FD),
          shadowColor: const Color(0xff3461FD),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: submitForm,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
