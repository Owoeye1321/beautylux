import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String category_name;
  final String category_ref;
  CategoryModel({required this.id, required this.category_name, required this.category_ref});
  static List<CategoryModel> jsonList(Map<String, dynamic> data) {
    List<CategoryModel> allCategories = [];
    for (Map<String, dynamic> eachCategory in data['data']) {
      var category_ref = eachCategory["category_ref"].toString() == "null"
          ? ObjectKey(eachCategory["id"]).toString()
          : eachCategory["category_ref"];
      var category_id =
          eachCategory["_id"].toString() == "null" ? ObjectKey(category_ref).toString() : eachCategory["_id"];
      CategoryModel category = CategoryModel(
        id: category_id,
        category_name: eachCategory['category_name'],
        category_ref: category_ref,
      );
      allCategories.add(category);
    }
    return allCategories;
  }
}
