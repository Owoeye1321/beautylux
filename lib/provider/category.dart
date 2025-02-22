import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/categories.dart';
import 'package:logaluxe_users/model/category.dart';

class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  CategoryNotifier() : super(allCategories);
}

var categoryNotifier = StateNotifierProvider<CategoryNotifier, List<CategoryModel>>(
  (ref) {
    return CategoryNotifier();
  },
);
