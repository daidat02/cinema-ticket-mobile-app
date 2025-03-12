import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const ReusableTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: const Color(0xff3461FD),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff7C8BA0), fontSize: 16),
          filled: true,
          fillColor: const Color(0xffF5F9FE),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff3461FD), width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3461FD), width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(15)))),
      validator: validator,
    );
  }
}
