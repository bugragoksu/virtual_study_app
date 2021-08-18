import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const BaseButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero)),
    );
  }
}
