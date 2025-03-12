import 'package:flutter/material.dart';
import 'package:shop/constants/colorStyle.dart';

class AppTextStyles {
  static TextStyle heading = const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.primary);

  static const TextStyle body = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
  );

  static const TextStyle titleHeading = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle caption = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: AppColors.gray);
}
