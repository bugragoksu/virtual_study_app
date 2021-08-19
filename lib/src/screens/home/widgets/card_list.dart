import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/screens/detail/detail_screen.dart';

import 'course_card.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (_, index) => CourseCard(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => DetailScreen()));
          },
          title: "Algorithms",
          imageURL: "imageURL"),
    );
  }
}
