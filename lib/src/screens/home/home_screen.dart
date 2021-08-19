import 'package:flutter/material.dart';

import '../../widgets/texts/bold_text.dart';
import 'widgets/card_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.25,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (_, i) => Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: _buildCourseColumn(),
                    )),
          ),
        ),
      ),
    );
  }

  Column _buildCourseColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: BoldText(
          text: "Computer Science",
        )),
        Expanded(flex: 5, child: CardList()),
        Spacer(),
      ],
    );
  }
}
