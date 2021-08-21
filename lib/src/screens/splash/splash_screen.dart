import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_repository.dart';
import '../../widgets/images/chat_image.dart';
import '../auth/auth_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  late UserRepository _userRepository;
  @override
  Widget build(BuildContext context) {
    _userRepository = Provider.of<UserRepository>(context);
    checkAndNavigateUser(_userRepository, context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ChatImage(),
        ),
      ),
    );
  }

  void checkAndNavigateUser(UserRepository repo, BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (repo.state == UserState.Authenticated) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => AuthScreen()), (route) => false);
      }
    });
  }
}
