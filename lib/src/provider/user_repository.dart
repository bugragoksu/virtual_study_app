import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum UserState { Init, Loading, Unauthenticated, Authenticated }

class UserRepository extends ChangeNotifier {
  User? _user;
  UserState _state = UserState.Init;

  UserRepository() {
    checkUser();
  }

  User get user => user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }

  UserState get state => _state;
  set state(UserState state) {
    _state = state;
    notifyListeners();
  }

  void checkUser() {
    state = UserState.Loading;
    var result = FirebaseAuth.instance.currentUser;
    if (result != null) {
      user = result;
      state = UserState.Authenticated;
    } else {
      state = UserState.Unauthenticated;
    }
  }

  Future<bool> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      state = UserState.Loading;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user!;
      state = UserState.Authenticated;
      return true;
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      state = UserState.Unauthenticated;
      return false;
    }
  }

  Future<bool> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      state = UserState.Loading;
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user!;
      state = UserState.Authenticated;
      return true;
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      state = UserState.Unauthenticated;
      return false;
    }
  }

  Future<void> signOut() async {
    state = UserState.Loading;
    await FirebaseAuth.instance.signOut();
    state = UserState.Unauthenticated;
  }
}
