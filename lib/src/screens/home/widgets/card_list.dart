import 'package:flutter/material.dart';

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
            print(index);
          },
          title: "Algorithms",
          imageURL: "imageURL"),
    );
  }
}
