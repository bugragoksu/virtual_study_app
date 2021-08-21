import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirestoreService {
  FirestoreService._privateConstructor();

  static final FirestoreService _instance =
      FirestoreService._privateConstructor();

  static FirestoreService get instance => _instance;
  Future<void> addUser(
      {required String id, required String name, required String email}) async {
    await FirebaseFirestore.instance
        .collection("user")
        .add({'id': id, 'name': name, 'email': email})
        .then((value) => print("User Added"))
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
  }
}
