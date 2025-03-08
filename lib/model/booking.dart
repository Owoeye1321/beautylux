import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/model/service.dart';

class BookingModel {
  final ServiceModel? service;
  final List<ProductModel> products;
  const BookingModel({this.service, required this.products});
  int get total {
    int totalCost = 0;
    if (this.products != [] && this.products.length > 0) {
      totalCost += this
          .products
          .map((product) => product.amount as List<int>)
          .reduce((sum, amount) => sum + amount) as int;
    }
    if (this.service != null) totalCost += this.service?.amount! as int;
    return totalCost;
  }
}
