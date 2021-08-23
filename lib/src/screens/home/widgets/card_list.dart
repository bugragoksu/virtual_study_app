import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/model/category_model.dart';
import 'package:virtual_study_app/src/screens/detail/detail_screen.dart';

import 'course_card.dart';

class CardList extends StatelessWidget {
  final List<CourseModel> courses;
  const CardList({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: courses.length,
      itemBuilder: (_, index) => CourseCard(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailScreen(
                      course: courses[index],
                    )));
          },
          title: courses[index].title,
          imageURL: courses[index].img),
    );
  }
}
