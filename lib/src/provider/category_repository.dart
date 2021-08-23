import 'package:flutter/material.dart';
import 'package:virtual_study_app/src/model/category_model.dart';
import 'package:virtual_study_app/src/service/firestore_service.dart';

enum CategoryState { Init, Loading, Loaded, Error }

class CategoryRepository extends ChangeNotifier {
  CategoryState _state = CategoryState.Init;
  CategoryState get state => _state;
  set state(CategoryState value) {
    _state = value;
    notifyListeners();
  }

  List<CategoryModel>? _categories;
  List<CategoryModel>? get categories {
    return _categories;
  }

  set categories(List<CategoryModel>? value) {
    _categories = value;
    notifyListeners();
  }

  CategoryRepository() {
    getCagories();
  }

  Future<void> getCagories() async {
    try {
      state = CategoryState.Loading;
      categories = await FirestoreService.instance.getCategories();
      Future.delayed(
          Duration(milliseconds: 500), () => state = CategoryState.Loaded);
    } catch (e) {
      print(e);
      state = CategoryState.Error;
    }
  }
}
