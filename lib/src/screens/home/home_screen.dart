import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/provider/category_repository.dart';
import 'package:virtual_study_app/src/provider/auth_repository.dart';
import 'package:virtual_study_app/src/screens/auth/auth_screen.dart';

import '../../widgets/texts/bold_text.dart';
import 'widgets/card_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CategoryRepository>().getCagories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<AuthRepository>().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => AuthScreen()),
                    (route) => false);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.25,
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: context.watch<CategoryRepository>().state ==
                      CategoryState.Loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          context.read<CategoryRepository>().categories!.length,
                      itemBuilder: (_, i) => Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: _buildCourseColumn(i),
                          ))),
        ),
      ),
    );
  }

  Column _buildCourseColumn(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: BoldText(
          text: context.read<CategoryRepository>().categories![index].title,
        )),
        Expanded(
            flex: 5,
            child: CardList(
                categoryId:
                    context.read<CategoryRepository>().categories![index].id,
                courses: context
                    .read<CategoryRepository>()
                    .categories![index]
                    .courses!)),
        Spacer(),
      ],
    );
  }
}
