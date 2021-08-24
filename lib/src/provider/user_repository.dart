import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/model/user_model.dart';
import 'package:virtual_study_app/src/service/firestore_service.dart';

enum UserState { Init, Loading, Loaded, Error }

class UserRepository extends ChangeNotifier {
  UserState _state = UserState.Init;
  UserState get state => _state;
  set state(UserState value) {
    _state = value;
    notifyListeners();
  }

  List<UserModel>? _users;
  List<UserModel>? get users => _users;
  set users(List<UserModel>? value) {
    _users = value;
    notifyListeners();
  }

  Future<List<UserModel>> getActiveUserForCourse(
      String categorieId, String courseId) async {
    try {
      state = UserState.Loading;
      users =
          await FirestoreService.instance.getActiveUsers(categorieId, courseId);
      state = UserState.Loaded;
      return users!;
    } catch (e) {
      state = UserState.Error;
      return [];
    }
  }
}
