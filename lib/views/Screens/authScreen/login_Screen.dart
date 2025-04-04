import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/TextStyle.dart';
import 'package:shop/models/User.dart';
import 'package:shop/providers/authProvider.dart';
import 'package:shop/services/API/api_auth_service.dart';
import 'package:shop/views/Screens/authScreen/widgets/LoginHeaderSectionWidget.dart';
import 'package:shop/views/Screens/authScreen/widgets/ReusableTextFormField.dart';
import 'package:shop/views/Screens/authScreen/widgets/auth_promt_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
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
        LoadingOverlay.show(context);
        final response = await authService.login(userData);
        User user = User.fromJson(response['user']);
        String accessToken = response['accessToken'];
        String refreshToken = response['refreshToken'];

        // Cập nhật AuthProvider
        Provider.of<AuthProvider>(context, listen: false).setUser(user);
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamed(context, '/');
        SuccessToastWidget.show(context, response['message']);
        LoadingOverlay.hide();
      } catch (e) {
        print(e);
        LoadingOverlay.hide();
        SuccessToastWidget.show(
            context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Tự động điều chỉnh kích thước khi bàn phím mở

      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              child: SvgPicture.asset(
                'assets/logo/logo_text.svg',
                height: 50,
              ),
            ),
            const LoginHeaderSectionWidget(
              titleHeader: 'Đăng Nhập',
            ),
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
                  AuthPromtWidget(
                    text1: 'Bạn Chưa Có Tài Khoản? ',
                    text2: 'Đăng ký',
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
