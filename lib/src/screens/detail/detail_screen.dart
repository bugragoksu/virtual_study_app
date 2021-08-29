import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/model/category_model.dart';
import 'package:virtual_study_app/src/provider/agora_repository.dart';
import 'package:virtual_study_app/src/provider/auth_repository.dart';
import 'package:virtual_study_app/src/provider/permission_repository.dart';
import 'package:virtual_study_app/src/provider/user_repository.dart';
import 'package:virtual_study_app/src/screens/meet/meet_screen.dart';

import '../../core/extensions/context_extension.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/images/chat_image.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final CourseModel course;
  final String categoryId;
  const DetailScreen({Key? key, required this.categoryId, required this.course})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<UserRepository>()
        .getActiveUserForCourse(widget.categoryId, widget.course.id));
  }

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
                  widget.course.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  widget.course.desc,
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
                child: context.watch<UserRepository>().state ==
                            UserStateEnum.Loading ||
                        context.watch<UserRepository>().users == null
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : _buildActiveUserList(context),
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
      itemCount: context.read<UserRepository>().users!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, i) => Container(
        height: context.width / 5,
        width: context.width / 5,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: Center(
            child: Text(
                context.read<UserRepository>().users![i].email[0].toUpperCase(),
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }

  Container _buildJoinButton(BuildContext context) {
    return Container(
      width: context.width / 2,
      child: BaseButton(
        isLoading: false,
        onPressed: () async {
          bool cameraBool = _checkCameraPermission();
          if (cameraBool) {
            await context
                .read<PermissionRepository>()
                .requestCameraPermission();
          }
          bool micBool = _checkMicPermission();
          if (micBool) {
            await context.read<PermissionRepository>().requestMicPermission();
          }
          cameraBool = _checkCameraPermission();
          micBool = _checkMicPermission();
          if (!cameraBool && !micBool)
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                    lazy: false,
                    create: (_) => AgoraRepository(
                        courseId: widget.course.id,
                        categoryId: widget.categoryId,
                        channelName: widget.course.id,
                        userId: context.read<AuthRepository>().user!.uid),
                    child: MeetScreen())));
        },
        title: "Join",
      ),
    );
  }

  bool _checkCameraPermission() {
    final cameraState = context.read<PermissionRepository>().cameraState;
    return cameraState == CameraState.Denied;
  }

  bool _checkMicPermission() {
    final micState = context.read<PermissionRepository>().microphoneState;
    return micState == MicrophoneState.Denied;
  }
}
