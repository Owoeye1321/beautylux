import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/booking.dart';
import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/model/response.dart';
import 'package:logaluxe_users/model/service.dart';

class BookingNotifier extends StateNotifier<BookingModel> {
  BookingNotifier() : super(BookingModel(service: null, products: []));
  addService(ServiceModel service) {
    if (state.service == service) {
      return ResponseModel(message: "Service has already been booked", status: "Failed");
    }
    state = BookingModel(service: service, products: state.products);
    return ResponseModel(message: "Service added", status: "Success");
  }

  removeService(ServiceModel service) {
    state = BookingModel(service: null, products: state.products);
    return ResponseModel(message: "Service removed", status: "Success");
  }

  addProduct(ProductModel product) {
    if (state.products!.contains(product)) {
      return ResponseModel(message: "Product already exist", status: "Failed");
    }
    state = BookingModel(service: state.service, products: [...state.products!, product]);
    return ResponseModel(message: "Product added", status: "Success");
  }

  removeProduct(ProductModel product) {
    if (state.products!.contains(product)) {
      state = BookingModel(
        service: state.service,
        products:
            state.products!.where((eachProduct) => eachProduct.product_ref != product.product_ref).toList(),
      );
      return ResponseModel(message: "Product removed successfully", status: "Success");
    }
  }
}

var bookingProvider = StateNotifierProvider<BookingNotifier, BookingModel>((ref) {
  return BookingNotifier();
});
