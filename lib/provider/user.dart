import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/user.dart';
import 'package:logaluxe_users/model/user.dart';

class UserNotifier extends StateNotifier<List<UserModel>> {
  UserNotifier() : super([]);
  Future<List<UserModel>> getServiceProviders() async {
    try {
      var response = await http.get(Uri.parse("${dotenv.env["API_URL"]}/service/provider"));
      if (response.statusCode == 200) {
        state = UserModel.fromJsonList(jsonDecode(response.body));
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
}

var userProvider = StateNotifierProvider<UserNotifier, List<UserModel>>(
  (ref) {
    return UserNotifier();
  },
);
