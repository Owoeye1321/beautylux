import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/service.dart';
import 'package:logaluxe_users/model/service.dart';

class ServiceNotifier extends StateNotifier<List<ServiceModel>> {
  ServiceNotifier() : super(allServices);
}

var serviceNotifier = StateNotifierProvider<ServiceNotifier, List<ServiceModel>>(
  (ref) {
    return ServiceNotifier();
  },
);
