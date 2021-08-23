import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_study_app/src/model/category_model.dart';

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
          id: categoryElement.data().id,
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
                CourseModel.fromJson(snapshot.data()!),
            toFirestore: (course, _) => {})
        .get();
    result.docs.forEach((element) {
      courses.add(element.data());
    });
    return courses;
  }
}
