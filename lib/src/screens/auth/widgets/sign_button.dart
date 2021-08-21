import 'package:flutter/material.dart';
import '../../../provider/user_repository.dart';
import 'package:provider/provider.dart';
import '../../../widgets/buttons/base_button.dart';

class SignButton extends StatefulWidget {
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
  _SignButtonState createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  bool loading = false;

  changeLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: double.infinity,
        height: height * 0.06,
        child: BaseButton(
          isLoading: loading,
          onPressed: () async {
            changeLoading();
            var result = widget.isLogin
                ? await context.read<UserRepository>().signInWithEmailPassword(
                    email: widget.emailController.text.trim(),
                    password: widget.passwordController.text.trim())
                : await context
                    .read<UserRepository>()
                    .registerUsingEmailPassword(
                        email: widget.emailController.text.trim(),
                        password: widget.passwordController.text.trim());
            changeLoading();
            widget.onFinish(result, result ? "" : "Something went wrong");
          },
          title: !widget.isLogin ? "Sign up" : "Sign in",
        ));
  }
}
