import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/model/service.dart';

class BookingModel {
  final ServiceModel? service;
  final List<ProductModel> products;
  const BookingModel({this.service, required this.products});
}
