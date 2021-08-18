import 'package:flutter/material.dart';

class BaseTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BaseTextInput(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
