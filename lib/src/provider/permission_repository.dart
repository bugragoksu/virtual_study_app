import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum MicrophoneState { Granted, Denied, Muted, Unmuted }
enum CameraState { Granted, Denied, Show, Hide }

class PermissionRepository extends ChangeNotifier {
  MicrophoneState _microphoneState = MicrophoneState.Denied;
  MicrophoneState get microphoneState => _microphoneState;
  set microphoneState(MicrophoneState state) {
    _microphoneState = state;
    notifyListeners();
  }

  CameraState _cameraState = CameraState.Denied;
  CameraState get cameraState => _cameraState;
  set cameraState(CameraState state) {
    _cameraState = state;
    notifyListeners();
  }

  PermissionRepository() {
    _checkCamerePermission();
    _checkMicPermission();
  }

  _checkCamerePermission() async {
    final status = await Permission.camera.status;
    if (_checkStatus(status)) {
      cameraState = CameraState.Granted;
    }
  }

  _checkMicPermission() async {
    final status = await Permission.microphone.status;
    if (_checkStatus(status)) {
      microphoneState = MicrophoneState.Granted;
    }
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (_checkStatus(status)) {
      cameraState = CameraState.Granted;
      return true;
    }
    cameraState = CameraState.Denied;
    return false;
  }

  Future<bool> requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (_checkStatus(status)) {
      microphoneState = MicrophoneState.Granted;
      return true;
    }
    microphoneState = MicrophoneState.Denied;
    return false;
  }

  bool _checkStatus(PermissionStatus status) {
    return status == PermissionStatus.granted;
  }
}
