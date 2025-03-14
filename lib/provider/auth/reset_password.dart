import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/model/api/auth.dart';

class ResetPasswordNotifier extends StateNotifier<ResetPasswordRequest> {
  ResetPasswordNotifier() : super(ResetPasswordRequest(email: '', platform: 'mobile', loading: false));
  Future<ResetPasswordResponse> resetPassword(String email) async {
    state = ResetPasswordRequest(email: email, platform: state.platform, loading: true);
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env['API_URL']!}/auth/reset-password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(state.toRequestResetJson()),
      );
      if (response.statusCode == 200) {
        var dataReturned = ResetPasswordResponse.fromJson(jsonDecode(response.body));

        return ResetPasswordResponse(code: dataReturned.code, message: dataReturned.message);
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

  ResetPasswordRequest setToken(String token) {
    state = ResetPasswordRequest(
        email: state.email, platform: state.platform, token: token, loading: state.loading);
    return state;
  }

  enableLoading() {
    state =
        ResetPasswordRequest(email: state.email, platform: state.platform, loading: true, token: state.token);
  }

  disableLoading() {
    state = ResetPasswordRequest(
      email: state.email,
      platform: state.platform,
      loading: false,
      token: state.token,
    );
  }

  Future<ResetPasswordResponse> changePassword(String newPassword) async {
    state = ResetPasswordRequest(
        email: state.email,
        platform: state.platform,
        newPassword: newPassword,
        token: state.token,
        loading: true);
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env['API_URL']!}/auth/update-password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(state.toChangePasswordJson()),
      );
      if (response.statusCode == 200) {
        var dataReturned = ResetPasswordResponse.fromJson(jsonDecode(response.body));

        return ResetPasswordResponse(code: dataReturned.code, message: dataReturned.message);
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

var passwordResetProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordRequest>((ref) => ResetPasswordNotifier());
