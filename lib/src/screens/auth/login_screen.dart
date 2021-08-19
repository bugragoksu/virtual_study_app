import 'package:flutter/material.dart';

import '../../widgets/images/chat_image.dart';
import '../../widgets/inputs/base_text_input.dart';
import 'widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passworController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChatImage(),
            SizedBox(
              height: height * 0.1,
            ),
            BaseTextInput(controller: emailController, hintText: "Email"),
            SizedBox(
              height: height * 0.025,
            ),
            BaseTextInput(controller: passworController, hintText: "Password"),
            SizedBox(
              height: height * 0.05,
            ),
            LoginButton(
                emailController: emailController,
                passwordController: passworController,
                onFinish: (success, err) {})
          ],
        ),
      ),
    );
  }
}
