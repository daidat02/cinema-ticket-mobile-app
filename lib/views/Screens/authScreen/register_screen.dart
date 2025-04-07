import 'package:flutter/material.dart';
import 'package:shop/services/API/api_auth_service.dart';
import 'package:shop/views/Screens/authScreen/widgets/LoginHeaderSectionWidget.dart';
import 'package:shop/views/Screens/authScreen/widgets/ReusableTextFormField.dart';
import 'package:shop/views/Screens/authScreen/widgets/auth_promt_widget.dart';
import 'package:shop/views/Screens/authScreen/widgets/submit_buttom_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/toast_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final authService = ApiAuthService();

  void _submitRegister() async {
    if (_formKey.currentState!.validate()) {
      final name = _name.text.trim();
      final phoneNumber = _phoneNumber.text.trim();
      final email = _email.text.trim();
      final password = _password.text.trim();

      print("$name, $phoneNumber, $email, $password");
      final registerData = {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password
      };
      try {
        LoadingOverlay.show(context);
        final response = await authService.register(registerData);
        Navigator.pushNamed(context, '/login');
        SuccessToastWidget.show(context, response['message']);
        LoadingOverlay.hide();
      } catch (e) {
        LoadingOverlay.hide();
        SuccessToastWidget.show(context, '$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LoginHeaderSectionWidget(
                titleHeader: 'Đăng Ký',
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ReusableTextFormField(
                        controller: _name,
                        hintText: 'Tên',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tên';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReusableTextFormField(
                        controller: _phoneNumber,
                        hintText: 'Số điện thoại',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Số điện thoại phải có 10 chữ số (0-9)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReusableTextFormField(
                        controller: _email,
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReusableTextFormField(
                        controller: _password,
                        hintText: 'Mật Khẩu',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SubmitButtomWidget(
                          submitForm: _submitRegister, btnText: 'Đăng Ký'),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthPromtWidget(
                        text1: 'Bạn Đã Có Tài Khoản? ',
                        text2: 'Đăng Nhập',
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
