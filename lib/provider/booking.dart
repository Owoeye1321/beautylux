import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/model/booking.dart';
import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/model/response.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/slot.dart';

class BookingNotifier extends StateNotifier<BookingModel> {
  BookingNotifier() : super(BookingModel(service: null, products: [], loadingState: false, slot: null));
  addService(ServiceModel service) {
    if (state.service == service) {
      return ResponseModel(message: "Service has already been booked", status: "Failed");
    }
    state = BookingModel(service: service, products: state.products, loadingState: state.loadingState);
    return ResponseModel(message: "Service added", status: "Success");
  }

  removeService(ServiceModel service) {
    state = BookingModel(service: null, products: state.products, loadingState: state.loadingState);
    return ResponseModel(message: "Service removed", status: "Success");
  }

  addProduct(ProductModel product) {
    var existingProduct = state.products.where((each) => each.id == product.id).toList();
    if (existingProduct.isNotEmpty) {
      return ResponseModel(message: "Product already exist", status: "Failed");
    }
    state = BookingModel(
        service: state.service, products: [...state.products, product], loadingState: state.loadingState);
    return ResponseModel(message: "Product added", status: "Success");
  }

  removeProduct(ProductModel product) {
    state = BookingModel(
      service: state.service,
      loadingState: state.loadingState,
      products:
          state.products.where((eachProduct) => eachProduct.product_ref != product.product_ref).toList(),
    );
    return ResponseModel(message: "Product removed successfully", status: "Success");
  }

  addBookingSlot(SlotModel slot) {
    state = BookingModel(
        products: state.products, service: state.service, slot: slot, loadingState: state.loadingState);
  }

  Future<Map<String, dynamic>> bookAppointment(
      BookingModel bookingModel, String token, String? firstName, String? lastName) async {
    if (state.slot == null) {
      throw Exception("Kindly select available slot");
    }

    state =
        BookingModel(products: state.products, service: state.service, slot: state.slot, loadingState: true);
    try {
      var response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/customer/initiate-appointment'),
        body: jsonEncode(
          bookingModel.bookAppointment(
            firstName,
            lastName,
          ),
        ),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      state = BookingModel(
          products: state.products, service: state.service, slot: state.slot, loadingState: false);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return {"message": data['message']};
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      state = BookingModel(
          products: state.products, service: state.service, slot: state.slot, loadingState: false);
      throw Exception(e.toString());
    }
  }
}

var bookingProvider = StateNotifierProvider<BookingNotifier, BookingModel>((ref) {
  return BookingNotifier();
});
