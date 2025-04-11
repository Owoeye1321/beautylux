import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/user.dart';
import 'package:logaluxe_users/model/user.dart';

class UserProviderModel {
  List<UserModel> serviceProviders;
  List<UserModel> defaultServiceProviders;
  List<UserModel> staffs;
  String order;
  bool loadingState;
  UserProviderModel(
      {required this.staffs,
      required this.serviceProviders,
      required this.defaultServiceProviders,
      required this.loadingState,
      required this.order});
}

class UserNotifier extends StateNotifier<UserProviderModel> {
  UserNotifier()
      : super(UserProviderModel(
            staffs: [],
            serviceProviders: [],
            defaultServiceProviders: [],
            loadingState: true,
            order: 'default'));
  Future<UserProviderModel> getServiceProviders() async {
    try {
      var response = await http.get(Uri.parse("${dotenv.env["API_URL"]}/service/provider"));
      if (response.statusCode == 200) {
        List<UserModel> data = UserModel.fromJsonList(jsonDecode(response.body));
        state = UserProviderModel(
            staffs: state.staffs,
            order: state.order,
            serviceProviders: data,
            defaultServiceProviders: data,
            loadingState: false);
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

  setServiceProviders(List<UserModel> users) {
    List<UserModel> serviceProviders = [];
    String order = state.order;
    if (state.order == 'asc') {
      serviceProviders = [...users]..sort(
          (a, b) => a.business_name.toLowerCase().compareTo(
                b.business_name.toLowerCase(),
              ),
        );
    } else if (state.order == 'default') {
      serviceProviders = users;
    } else if (state.order == 'desc') {
      serviceProviders = [...users]..sort(
          (a, b) => b.business_name.toLowerCase().compareTo(
                a.business_name.toLowerCase(),
              ),
        );
    }
    state = UserProviderModel(
        staffs: state.staffs,
        serviceProviders: serviceProviders,
        loadingState: state.loadingState,
        order: state.order,
        defaultServiceProviders: state.defaultServiceProviders);
    return state;
  }

  Future<UserProviderModel> getServiceProviderStaffs(String company_id, String token) async {
    try {
      var response = await http.get(Uri.parse("${dotenv.env["API_URL"]}/auth/staff?company_id=${company_id}"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        state = UserProviderModel(
            staffs: UserModel.fromJsonList(jsonDecode(response.body)),
            loadingState: false,
            defaultServiceProviders: state.defaultServiceProviders,
            order: state.order,
            serviceProviders: state.serviceProviders);
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

  filterUsers() {
    List<UserModel> serviceProviders = [];
    String order = state.order;
    if (state.order == 'asc') {
      serviceProviders = [...state.defaultServiceProviders]..sort(
          (a, b) => b.business_name.toLowerCase().compareTo(
                a.business_name.toLowerCase(),
              ),
        );
      order = 'desc';
    } else if (state.order == 'desc') {
      serviceProviders = state.defaultServiceProviders;
      order = 'default';
    } else if (state.order == 'default') {
      serviceProviders = [...state.defaultServiceProviders]..sort(
          (a, b) => a.business_name.toLowerCase().compareTo(
                b.business_name.toLowerCase(),
              ),
        );
      order = 'asc';
    }
    state = UserProviderModel(
        staffs: state.staffs,
        serviceProviders: serviceProviders,
        defaultServiceProviders: state.defaultServiceProviders,
        loadingState: state.loadingState,
        order: order);
  }
}

var userProvider = StateNotifierProvider<UserNotifier, UserProviderModel>(
  (ref) {
    return UserNotifier();
  },
);
