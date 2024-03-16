import 'package:flutter/material.dart';

class CategoryFilterProfileProvider extends ChangeNotifier {
  String categorySelected = "Info";

  void changeCategory(String currentCategory) {
    categorySelected = currentCategory;
    notifyListeners();
  }
  notifyListeners();

}
