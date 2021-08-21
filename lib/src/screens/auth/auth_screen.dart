import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/screens/home/home_screen.dart';

import '../../widgets/images/chat_image.dart';
import '../../widgets/inputs/base_text_input.dart';
import 'widgets/sign_button.dart';
import '../../core/extensions/context_extension.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passworController = TextEditingController();
  bool isLogin = false;

  void changePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChatImage(),
            SizedBox(
              height: context.highValue,
            ),
            BaseTextInput(
                isPassword: false,
                controller: emailController,
                hintText: "Email"),
            SizedBox(
              height: context.height * 0.025,
            ),
            BaseTextInput(
                isPassword: true,
                controller: passworController,
                hintText: "Password"),
            SizedBox(
              height: context.mediumValue,
            ),
            SignButton(
                isLogin: isLogin,
                emailController: emailController,
                passwordController: passworController,
                onFinish: (success, err) {
                  if (success) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                        (route) => false);
                  }
                }),
            SizedBox(
              height: context.lowValue,
            ),
            TextButton(
                onPressed: () {
                  changePage();
                },
                child: Text(
                  !isLogin ? 'Already have an account' : "Create an account",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
