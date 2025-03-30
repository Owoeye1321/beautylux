import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/slot.dart';
import 'package:logaluxe_users/model/user.dart';

class BookingModel {
  final ServiceModel? service;
  final List<ProductModel> products;
  final SlotModel? slot;
  final bool loadingState;
  BookingModel({this.service, required this.products, this.slot, required this.loadingState});
  int get total {
    int totalCost = 0;
    if (products.isNotEmpty) {
      totalCost += products.fold(0, (int sum, ProductModel product) => sum + (product.amount) as int);
    }

    if (service != null) {
      totalCost += service?.amount ?? 0;
    }
    return totalCost;
  }

  Map<String, dynamic> bookAppointment(String? firstName, String? lastName) {
    return {
      "total_amount": total?.toString() ?? "0",
      "slot_ref": slot?.slot_ref ?? "",
      "service_amount": service?.amount?.toString() ?? "0",
      "first_name": firstName ?? "",
      "last_name": lastName ?? "",
      "amount": total?.toString() ?? "0",
      "currency": service?.currency ?? "USD",
      "start_date": slot?.start_time?.toIso8601String() ?? "",
      "end_date": slot?.end_time?.toIso8601String() ?? "",
      "service_id": service?.id ?? "",
      "products": products.isNotEmpty
          ? products
              .map((product) => {
                    "id": product.id,
                    "count": 1,
                    "amount": product.amount.toString(),
                  })
              .toList()
          : [],
      "company_id": service?.company_id?.id ?? "",
    };
  }
}
