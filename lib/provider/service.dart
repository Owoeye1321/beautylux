import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/service.dart';
import 'package:logaluxe_users/model/service.dart';

class ServiceProviderModel {
  bool loadingState;
  List<ServiceModel> data;
  ServiceProviderModel({required this.loadingState, required this.data});
}

class ServiceNotifier extends StateNotifier<ServiceProviderModel> {
  ServiceNotifier() : super(ServiceProviderModel(loadingState: true, data: []));
  Future<ServiceProviderModel> fetchServices(String categoryId, String companyId) async {
    try {
      var response = await http.get(Uri.parse(
          "${dotenv.env["API_URL"]}/service/provider-services?category_id=${categoryId}&company_id=${companyId}"));
      if (response.statusCode == 200) {
        state = ServiceProviderModel(
            loadingState: false, data: ServiceModel.fromResponse(jsonDecode(response.body)));
        return state;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  resetServices() {
    state = ServiceProviderModel(loadingState: true, data: []);
  }
}

var serviceProvider = StateNotifierProvider<ServiceNotifier, ServiceProviderModel>(
  (ref) {
    return ServiceNotifier();
  },
);
