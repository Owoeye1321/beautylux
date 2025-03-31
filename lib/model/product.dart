import 'dart:ffi';

class ProductModel {
  final String id;
  final String iamge_url_1;
  final String? iamge_url_2;
  final String? iamge_url_3;
  final String? iamge_url_4;
  final String? country;
  final String? state;
  final String? product_category;
  final String? currency;
  final String? service_id;
  final String name;
  final int amount;
  final String location;
  final String description;
  final String? status;
  final String product_ref;
  final String? company_id;
  const ProductModel({
    required this.id,
    required this.iamge_url_1,
    this.iamge_url_2,
    this.iamge_url_3,
    this.iamge_url_4,
    required this.amount,
    this.company_id,
    this.country,
    this.currency,
    required this.description,
    required this.location,
    required this.name,
    this.product_category,
    required this.product_ref,
    this.service_id,
    this.state,
    this.status,
  });

  static List<ProductModel> fromJsonList(Map<String, dynamic> data) {
    List<ProductModel> allProducts = [];
    for (Map<String, dynamic> eachProduct in data['data']) {
      ProductModel product = ProductModel(
        id: eachProduct['_id'],
        iamge_url_1: eachProduct['iamge_url_1'].toString(),
        amount: eachProduct['amount'],
        description: eachProduct['description'],
        location: eachProduct['location'],
        name: eachProduct['name'],
        product_ref: eachProduct['product_ref'],
      );
      allProducts.add(product);
    }
    return allProducts;
  }
}
