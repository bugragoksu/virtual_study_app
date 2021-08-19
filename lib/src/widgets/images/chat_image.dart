import 'package:flutter/material.dart';

class ChatImage extends StatelessWidget {
  const ChatImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/chat.png",
      fit: BoxFit.fill,
    );
  }
}
