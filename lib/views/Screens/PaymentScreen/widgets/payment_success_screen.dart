import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/constants/TextStyle.dart';
import 'package:shop/views/Screens/authScreen/widgets/submit_buttom_widget.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String ticketId;
  const PaymentSuccessScreen({super.key, required this.ticketId});

  @override
  void _checkTicket() {
    print('check vé: $ticketId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 70),
              child: SvgPicture.asset(
                'assets/logo/logo_text.svg',
                height: 55,
              ),
            ),
            Text('Thanh Toán Thành Công', style: AppTextStyles.heading),
            const Text(
              'Chúc Mừng Bạn Đã Đặt Vé Thành Công',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff61677D)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 70),
              child: SvgPicture.asset(
                'assets/icons/icon_checkmark_outline.svg',
                height: 150,
              ),
            ),
            SubmitButtomWidget(
                submitForm: _checkTicket, btnText: 'Xem Chi Tiết Vé'),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text(
                'Quay Lại Trang Chủ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff3461FD)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
