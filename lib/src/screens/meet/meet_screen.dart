import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/provider/agora_repository.dart';
import '../../core/extensions/context_extension.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class MeetScreen extends StatefulWidget {
  const MeetScreen({Key? key}) : super(key: key);

  @override
  _MeetScreenState createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  bool isMicOpen = true, isCameraOpen = true;

  void switchCamera() async {
    await context.read<AgoraRepository>().switchCamera();
  }

  void changeMic() async {
    isMicOpen = !isMicOpen;
    await context.read<AgoraRepository>().muteToggle(!isMicOpen);
    setState(() {});
  }

  void changeCamera() {
    setState(() {
      isCameraOpen = !isCameraOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: context.watch<AgoraRepository>().state == AgoraState.Loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Stack(
                children: [
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount:
                          context.watch<AgoraRepository>().users.length + 1,
                      itemBuilder: (_, i) => i == 0 && isCameraOpen
                          ? _buildMeetCard(RtcLocalView.SurfaceView())
                          : _buildMeetCard(
                              Text(
                                'H',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                  Positioned(
                      bottom: context.mediumValue,
                      left: context.lowValue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _buildButton(
                                buttonColor: Colors.red,
                                onPressed: () {
                                  context
                                      .read<AgoraRepository>()
                                      .leaveChannel();
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.call_end)),
                            SizedBox(
                              width: context.width * 0.05,
                            ),
                            _buildButton(
                                buttonColor: Colors.white,
                                onPressed: changeMic,
                                icon: Icon(
                                    isMicOpen ? Icons.mic : Icons.mic_off,
                                    color: Colors.black)),
                            SizedBox(
                              width: context.width * 0.05,
                            ),
                            _buildButton(
                                buttonColor: Colors.white,
                                onPressed: switchCamera,
                                icon: Icon(Icons.cameraswitch,
                                    color: Colors.black)),
                            SizedBox(
                              width: context.width * 0.05,
                            ),
                            _buildButton(
                                buttonColor: Colors.white,
                                onPressed: changeCamera,
                                icon: Icon(
                                    isCameraOpen
                                        ? Icons.videocam
                                        : Icons.videocam_off,
                                    color: Colors.black)),
                          ],
                        ),
                      ))
                ],
              ),
      ),
    );
  }

  Widget _buildButton(
      {required Color buttonColor,
      required VoidCallback onPressed,
      required Widget icon}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: buttonColor),
        onPressed: onPressed,
        child: icon);
  }

  Widget _buildMeetCard(Widget child) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.black,
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10), child: child)));
  }
}
