import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/service.dart';
import 'package:logaluxe_users/model/service.dart';

class ServiceNotifier extends StateNotifier<List<ServiceModel>> {
  ServiceNotifier() : super(allServices);
  // Future<List<Service>> fetchServices(String categoryRef) async {
  //   try {
  //     var response = await http.get(Uri.parse("${dotenv.env["API_URL"]}"));
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}

var serviceNotifier = StateNotifierProvider<ServiceNotifier, List<ServiceModel>>(
  (ref) {
    return ServiceNotifier();
  },
);
