import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/categories.dart';
import 'package:logaluxe_users/model/category.dart';

class CategoryProviderModel {
  CategoryModel? activeCategory;
  List<CategoryModel> data;
  CategoryProviderModel({this.activeCategory, required this.data});
}

class CategoryNotifier extends StateNotifier<CategoryProviderModel> {
  CategoryNotifier() : super(CategoryProviderModel(activeCategory: null, data: []));

  Future<CategoryProviderModel> fetchCategory() async {
    try {
      final response = await http.get(
        Uri.parse("${dotenv.env['API_URL']!}/service/category"),
      );
      if (response.statusCode == 200) {
        state = CategoryProviderModel(
            data: CategoryModel.jsonList(jsonDecode(response.body)), activeCategory: state.activeCategory);
        return state;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  setActiveCategory(CategoryModel category) {
    state = CategoryProviderModel(data: state.data, activeCategory: category);
  }
}

var categoryNotifier = StateNotifierProvider<CategoryNotifier, CategoryProviderModel>(
  (ref) {
    return CategoryNotifier();
  },
);
