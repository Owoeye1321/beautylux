import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';

class LoginInNotifier extends StateNotifier<LoginResponse> {
  LoginInNotifier()
      : super(
          LoginResponse(
              code: 404,
              message: '',
              data: UserModel(
                  first_name: "",
                  id: '',
                  bio: '',
                  business_name: '',
                  business_address: '',
                  token: '',
                  company_id: ''),
              loading: false),
        );

  Future<LoginResponse> login(LoginRequest data) async {
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env['API_URL']!}/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()),
      );
      if (response.statusCode == 200) {
        state = LoginResponse.fromJson(jsonDecode(response.body));
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

  Future<LoginResponse> gmail_sso(String email, String first_name, String? image_url) async {
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env['API_URL']!}/auth/gmail-sso"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email, "first_name": first_name, "image_url": image_url}),
      );
      if (response.statusCode == 200) {
        state = LoginResponse.fromJson(jsonDecode(response.body));
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

  enableLoading() {
    state = LoginResponse(code: state.code, message: state.message, loading: true, data: state.data);
  }

  disableLoading() {
    state = LoginResponse(
      code: state.code,
      message: state.message,
      loading: false,
      data: state.data,
    );
  }
}

var loginProvider = StateNotifierProvider<LoginInNotifier, LoginResponse>((ref) {
  return LoginInNotifier();
});
