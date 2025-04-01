import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/model/product.dart';

class ProductProviderModel {
  final List<ProductModel> products;
  final bool loadingState;
  const ProductProviderModel({required this.products, required this.loadingState});
}

class ProductNotifier extends StateNotifier<ProductProviderModel> {
  ProductNotifier() : super(ProductProviderModel(products: [], loadingState: false));

  Future<List<ProductModel>> fetchProduct(String company_id) async {
    state = ProductProviderModel(products: state.products, loadingState: true);
    try {
      var response =
          await http.get(Uri.parse('${dotenv.env['API_URL']}/product/company?company_id=${company_id}'));
      if (response.statusCode == 200) {
        state = ProductProviderModel(
            products: ProductModel.fromJsonList(jsonDecode(response.body)), loadingState: false);
        return state.products;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

var productProvider =
    StateNotifierProvider<ProductNotifier, ProductProviderModel>((ref) => ProductNotifier());
