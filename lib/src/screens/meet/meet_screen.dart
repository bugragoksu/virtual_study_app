import 'package:flutter/material.dart';

import '../../core/extensions/context_extension.dart';

class MeetScreen extends StatefulWidget {
  const MeetScreen({Key? key}) : super(key: key);

  @override
  _MeetScreenState createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  bool isMicOpen = true, isCameraOpen = true;

  void changeMic() {
    setState(() {
      isMicOpen = !isMicOpen;
    });
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
        child: Stack(
          children: [
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 19,
                itemBuilder: (_, i) => Container(
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              'H',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    )),
            Positioned(
                bottom: context.mediumValue,
                left: context.width / 6.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.call_end)),
                    SizedBox(
                      width: context.width * 0.1,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: changeMic,
                        child: Icon(isMicOpen ? Icons.mic : Icons.mic_off,
                            color: Colors.black)),
                    SizedBox(
                      width: context.width * 0.1,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: changeCamera,
                        child: Icon(
                          isCameraOpen ? Icons.videocam : Icons.videocam_off,
                          color: Colors.black,
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
