import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_title_widget.dart';
import 'package:shop/views/Widgets/text_buttom_widget.dart';

Widget sectionHeader(String sectionTitle, String buttonText, color,
    String pathName, bool? isReleased) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sectionTitleWidget(sectionTitle),
        Row(
          children: [
            TextButtonWidget(
              buttonText: buttonText,
              activeColor: color,
              pathName: pathName,
              isReleased: isReleased,
              titleAppbar:
                  sectionTitle, // Truyền isReleased vào TextButtonWidget
            ),
            SvgPicture.asset(
              'assets/icons/arrow_right_icon.svg',
              height: 18,
              width: 18,
            ),
          ],
        )
      ],
    ),
  );
}
