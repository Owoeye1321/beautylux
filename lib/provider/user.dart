import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/user.dart';
import 'package:logaluxe_users/model/user.dart';

class UserProviderModel {
  List<UserModel> serviceProviders;
  List<UserModel> staffs;
  bool loadingState;
  UserProviderModel({required this.staffs, required this.serviceProviders, required this.loadingState});
}

class UserNotifier extends StateNotifier<UserProviderModel> {
  UserNotifier() : super(UserProviderModel(staffs: [], serviceProviders: [], loadingState: true));
  Future<UserProviderModel> getServiceProviders() async {
    try {
      var response = await http.get(Uri.parse("${dotenv.env["API_URL"]}/service/provider"));
      if (response.statusCode == 200) {
        state = UserProviderModel(
            staffs: state.staffs,
            serviceProviders: UserModel.fromJsonList(jsonDecode(response.body)),
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

  Future<UserProviderModel> getServiceProviderStaffs(String company_id, String token) async {
    try {
      var response = await http.get(Uri.parse("${dotenv.env["API_URL"]}/auth/staff?company_id=${company_id}"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        state = UserProviderModel(
            staffs: UserModel.fromJsonList(jsonDecode(response.body)),
            loadingState: false,
            serviceProviders: state.serviceProviders);
        return state;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}

var userProvider = StateNotifierProvider<UserNotifier, UserProviderModel>(
  (ref) {
    return UserNotifier();
  },
);
