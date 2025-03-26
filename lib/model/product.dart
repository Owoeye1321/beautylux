import 'dart:ffi';

class ProductModel {
  final String id;
  final String? iamge_url_1;
  final String? iamge_url_2;
  final String? iamge_url_3;
  final String? iamge_url_4;
  final String? country;
  final String? state;
  final String? product_category;
  final String? currency;
  final String? service_id;
  final String? name;
  final int amount;
  final String? location;
  final String? description;
  final String? status;
  final String? product_ref;
  final String? company_id;
  const ProductModel({
    required this.id,
    this.iamge_url_1,
    this.iamge_url_2,
    this.iamge_url_3,
    this.iamge_url_4,
    required this.amount,
    this.company_id,
    this.country,
    this.currency,
    this.description,
    this.location,
    this.name,
    this.product_category,
    this.product_ref,
    this.service_id,
    this.state,
    this.status,
  });
}
