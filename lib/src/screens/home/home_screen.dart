import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/provider/user_repository.dart';
import 'package:virtual_study_app/src/screens/auth/auth_screen.dart';

import '../../widgets/texts/bold_text.dart';
import 'widgets/card_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                await context.read<UserRepository>().signOut();
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
