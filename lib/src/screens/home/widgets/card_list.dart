import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_study_app/src/model/category_model.dart';
import 'package:virtual_study_app/src/provider/user_repository.dart';
import 'package:virtual_study_app/src/screens/detail/detail_screen.dart';

import 'course_card.dart';

class CardList extends StatelessWidget {
  final String categoryId;
  final List<CourseModel> courses;
  const CardList({Key? key, required this.categoryId, required this.courses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: courses.length,
      itemBuilder: (_, index) => CourseCard(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                      create: (_) => UserRepository(),
                      child: DetailScreen(
                        categoryId: categoryId,
                        course: courses[index],
                      ),
                    )));
          },
          title: courses[index].title,
          imageURL: courses[index].img),
    );
  }
}
