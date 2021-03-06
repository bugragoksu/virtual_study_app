import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_study_app/src/service/firestore_service.dart';

enum UserState { Init, Loading, Unauthenticated, Authenticated }

class AuthRepository extends ChangeNotifier {
  User? _user;
  UserState _state = UserState.Init;

  AuthRepository() {
    checkUser();
  }

  User? get user => _user;
  set user(User? user) {
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
      await FirestoreService.instance.addUser(
          id: user!.uid, name: user!.displayName ?? "", email: user!.email!);
      state = UserState.Authenticated;
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
