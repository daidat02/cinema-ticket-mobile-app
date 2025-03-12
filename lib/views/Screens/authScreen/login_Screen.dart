import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/constants/TextStyle.dart';
import 'package:shop/services/API/api_auth_service.dart';
import 'package:shop/views/Screens/authScreen/widgets/LoginHeaderSectionWidget.dart';
import 'package:shop/views/Screens/authScreen/widgets/ReusableTextFormField.dart';
import 'package:shop/views/Widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // call api
  final authService = ApiAuthService();

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      // Form hợp lệ, xử lý dữ liệu
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final userData = {
        "phoneNumber": email,
        "password": password,
      };
      try {
        final response = await authService.login(userData);
        ToastWidget.show(context, response['message']);
      } catch (e) {
        print(e);
        ToastWidget.show(context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginHeaderSectionWidget(),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ReusableTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ReusableTextFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Quên Mật Khẩu',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xff7C8BA0), fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
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
                      onPressed: _submitLogin,
                      child: const Text(
                        'Đăng Nhập',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const NewWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RichText(
        textAlign: TextAlign.left,
        text: const TextSpan(
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff3B4054),
            ),
            text: 'Bạn Chưa có tài Khoản? ',
            children: [
              TextSpan(
                  text: 'Đăng Ký',
                  style: TextStyle(color: Color(0xff3461FD), fontSize: 14))
            ]),
      ),
    );
  }
}
