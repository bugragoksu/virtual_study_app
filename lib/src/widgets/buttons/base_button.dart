import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/widgets/white_progress_indicator.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
  const BaseButton(
      {Key? key,
      required this.isLoading,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: isLoading ? WhiteProgressIndicator() : Text(title),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero)),
    );
  }
}
