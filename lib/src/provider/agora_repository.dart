import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:virtual_study_app/agora_config.dart';
import 'package:virtual_study_app/src/service/firestore_service.dart';
import 'package:virtual_study_app/src/service/http_service.dart';

enum AgoraState { Init, Loading, Ready }

class AgoraRepository extends ChangeNotifier {
  RtcEngine? _engine;
  final String channelName;
  final String userId;
  final String courseId;
  final String categoryId;

  AgoraState _state = AgoraState.Init;

  AgoraRepository(
      {required this.courseId,
      required this.categoryId,
      required this.channelName,
      required this.userId}) {
    addUserToFirestore();
    initAgora();
  }
  AgoraState get state => _state;
  set state(AgoraState value) {
    _state = value;
    notifyListeners();
  }

  List<int> _users = <int>[];
  List<int> get users => _users;

  _addUser(int uid) {
    users.add(uid);
    notifyListeners();
  }

  _removeUser(int uid) {
    users.remove(uid);
    notifyListeners();
  }

  Future<void> initAgora() async {
    state = AgoraState.Loading;
    final token = await HttpService.instance
        .getToken(channelName: channelName, uid: userId);
    if (token.isEmpty) return;
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(height: 1920, width: 1080);
    await _engine!.setVideoEncoderConfiguration(configuration);
    await _engine!.joinChannelWithUserAccount(token, channelName, userId);
    state = AgoraState.Ready;
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine!.enableVideo();
    await _engine!.startPreview();
    await _engine!.setChannelProfile(ChannelProfile.Communication);
  }

  void _addAgoraEventHandlers() {
    _engine!.setEventHandler(
        RtcEngineEventHandler(tokenPrivilegeWillExpire: (_) async {
      final token = await HttpService.instance
          .getToken(channelName: channelName, uid: userId);
      await _engine!.renewToken(token);
    }, error: (code) {
      final info = 'onError: $code';
      print("AGORA ERROR ! : $info");
    }, joinChannelSuccess: (channel, uid, elapsed) {
      final info = 'onJoinChannel: $channel, uid: $uid';
      print("AGORA INFO ! : $info");
    }, leaveChannel: (stats) {
      _users.clear();
    }, userJoined: (uid, elapsed) {
      final info = 'userJoined: $uid';
      print("AGORA INFO ! : $info");
      _addUser(uid);
    }, userOffline: (uid, elapsed) {
      final info = 'userOffline: $uid';
      print("AGORA INFO ! : $info");
      _removeUser(uid);
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      final info = 'firstRemoteVideo: $uid ${width}x $height';
      print("AGORA INFO ! : $info");
    }));
  }

  leaveChannel() async {
    FirestoreService.instance.removeActiveUser(
        categoryId: categoryId, courseId: courseId, userId: userId);
    await _engine!.leaveChannel();
    await _engine!.destroy();
  }

  switchCamera() async {
    await _engine!.switchCamera();
  }

  muteToggle(bool value) async {
    await _engine!.muteLocalAudioStream(value);
  }

  Future<void> addUserToFirestore() async {
    await FirestoreService.instance.addActiveUser(
        categoryId: categoryId, courseId: courseId, userId: userId);
  }
}
