import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_study_app/src/model/category_model.dart';
import 'package:virtual_study_app/src/model/user_model.dart';

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

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    var result = await FirebaseFirestore.instance
        .collection("categories")
        .withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) =>
                CategoryModel.fromJson(snapshot.data()!),
            toFirestore: (category, _) => {})
        .get();
    result.docs.forEach((categoryElement) async {
      var courses = await _getCoursesFromFirebase(categoryElement.id);
      CategoryModel categoryModel = new CategoryModel(
          id: categoryElement.id,
          title: categoryElement.data().title,
          courses: courses);
      categories.add(categoryModel);
    });
    return categories;
  }

  Future<List<CourseModel>> _getCoursesFromFirebase(String documentId) async {
    List<CourseModel> courses = [];
    var result = await FirebaseFirestore.instance
        .collection('categories')
        .doc(documentId)
        .collection('courses')
        .withConverter<CourseModel>(
            fromFirestore: (snapshot, _) =>
                CourseModel.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (course, _) => {})
        .get();
    result.docs.forEach((element) {
      courses.add(element.data());
    });
    return courses;
  }

  Future<List<UserModel>> getActiveUsers(
      String categorieId, String courseId) async {
    List<UserModel> users = [];
    var result = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categorieId)
        .collection('courses')
        .doc(courseId)
        .collection('active_users')
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => {})
        .get();
    result.docs.forEach((element) {
      users.add(element.data());
    });
    return users;
  }

  Future<UserModel> _getUser(String uid) async {
    UserModel? userModel;
    var result = await _getUserQueryDocumentSnapshot(uid);
    result.docs.forEach((element) {
      userModel = element.data();
    });
    return userModel!;
  }

  Future<QuerySnapshot<UserModel>> _getUserQueryDocumentSnapshot(
      String uid) async {
    var result = await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: uid)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => {})
        .get();

    return result;
  }

  Future<void> addActiveUser(
      {required String categoryId,
      required String courseId,
      required String userId}) async {
    var user = await _getUser(userId);
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .collection('courses')
        .doc(courseId)
        .collection('active_users')
        .add({"id": user.id, "email": user.email});
  }

  Future<void> removeActiveUser(
      {required String categoryId,
      required String courseId,
      required String userId}) async {
    var result = await FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .collection('courses')
        .doc(courseId)
        .collection('active_users')
        .where('id', isEqualTo: userId)
        .get()
        .then((value) => value);

    result.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('courses')
          .doc(courseId)
          .collection('active_users')
          .doc(element.id)
          .delete();
    });
  }
}
