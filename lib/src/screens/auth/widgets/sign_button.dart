import 'package:flutter/material.dart';

import '../../../widgets/buttons/base_button.dart';

class SignButton extends StatelessWidget {
  final bool isLogin;
  final Function(bool success, String message) onFinish;
  final TextEditingController emailController, passwordController;
  const SignButton(
      {Key? key,
      required this.isLogin,
      required this.onFinish,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: double.infinity,
        height: height * 0.06,
        child: BaseButton(
          onPressed: () {
            print(emailController.text);
            print(passwordController.text);
          },
          title: isLogin ? "Sign up" : "Sign in",
        ));
  }
}
