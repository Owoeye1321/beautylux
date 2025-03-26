import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logaluxe_users/model/category.dart';
import 'package:logaluxe_users/model/user.dart';

class ServiceModel {
  final String id;
  final String name;
  final String service_duration;
  final String location;
  final String service_ref;
  final UserModel company_id;
  final CategoryModel category_id;
  final int amount;
  final String country;
  final String state;
  final bool active;
  final String currency;
  final String image_url;
  final String opening_time;
  final String closing_time;
  final String createdAt;
  final String updatedAt;
  final String description;
  ServiceModel(
      {required this.id,
      required this.name,
      required this.service_duration,
      required this.location,
      required this.service_ref,
      required this.company_id,
      required this.category_id,
      required this.amount,
      required this.country,
      required this.state,
      required this.active,
      required this.opening_time,
      required this.closing_time,
      required this.createdAt,
      required this.currency,
      required this.updatedAt,
      required this.description,
      required this.image_url});

  static List<ServiceModel> fromResponse(Map<String, dynamic> data) {
    List<ServiceModel> allServices = [];
    for (Map<String, dynamic> eachService in data['data']) {
      ServiceModel service = ServiceModel(
        id: eachService['_id'],
        name: eachService['name'],
        service_duration: eachService['service_duration'],
        location: '',
        service_ref: eachService['service_ref'],
        company_id: UserModel(
          token: '',
          id: eachService['company_id']['_id'],
          first_name: eachService['company_id']['first_name'],
          bio: '',
          business_address: '',
          business_name: '',
          company_id: '',
        ),
        category_id: CategoryModel(id: '', category_name: '', category_ref: ''),
        amount: int.parse(eachService['amount'].toString()),
        country: '',
        state: '',
        active: false,
        opening_time: '',
        closing_time: '',
        createdAt: '',
        currency: eachService['currency'].toString(),
        updatedAt: '',
        description: eachService['description'],
        image_url: '',
      );
      allServices.add(service);
    }
    return allServices;
  }
}
