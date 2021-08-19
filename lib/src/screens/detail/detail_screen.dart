import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/screens/meet/meet_screen.dart';

import '../../core/extensions/context_extension.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/images/chat_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(flex: 5, child: ChatImage()),
              Spacer(),
              Expanded(
                child: Text(
                  'Title',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et velit suscipit, ultricies nisl sed, hendrerit enim. Vivamus consectetur, nunc in viverra tristique, magna augue sodales nunc,',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Expanded(
                child: Text(
                  'Active Users',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Divider(),
              Expanded(
                child: _buildActiveUserList(context),
              ),
              Divider(),
              Spacer(),
              _buildJoinButton(context)
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildActiveUserList(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, i) => Container(
        height: context.width / 5,
        width: context.width / 5,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: Center(
            child: Text('H',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }

  Container _buildJoinButton(BuildContext context) {
    return Container(
      width: context.width / 2,
      child: BaseButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MeetScreen()));
        },
        title: "Join",
      ),
    );
  }
}
