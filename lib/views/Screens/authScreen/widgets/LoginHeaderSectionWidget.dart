import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/constants/TextStyle.dart';

class LoginHeaderSectionWidget extends StatelessWidget {
  final String titleHeader;
  const LoginHeaderSectionWidget({super.key, required this.titleHeader});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(titleHeader, style: AppTextStyles.heading),
          const Text(
            'Chào bạn, sẵn sàng khám phá những điều mới chưa?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xff61677D)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: 160,
                height: 60,
                decoration: const BoxDecoration(
                    color: Color(0xffF5F9FE),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/facebook_icon.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Facebook',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff61677D)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                width: 160,
                height: 60,
                decoration: const BoxDecoration(
                    color: Color(0xffF5F9FE),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/google_icon.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Google',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff61677D)),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Color(0xffE0E5EC), // Màu đường kẻ
                  thickness: 1, // Độ dày
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Hoặc',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff61677D)),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Color(0xffE0E5EC), // Màu đường kẻ
                  thickness: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
