import 'package:flutter/material.dart';

class WhiteProgressIndicator extends StatelessWidget {
  const WhiteProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
