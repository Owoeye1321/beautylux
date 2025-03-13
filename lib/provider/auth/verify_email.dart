import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:http/http.dart' as http;

class VerifyEmailNotifier extends StateNotifier<VerifyEmailResponse> {
  VerifyEmailNotifier() : super(VerifyEmailResponse(code: 404, message: '', data: null, loading: false));

  Future<VerifyEmailResponse> verifyOtp(VerifyEmailRequest data) async {
    try {
      print(data.email);
      print(data.otp);
      final response = await http.post(
        Uri.parse("${dotenv.env['API_URL']!}/auth/verify-otp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()),
      );
      if (response.statusCode == 200) {
        state = VerifyEmailResponse.fromJson(jsonDecode(response.body));
        return state;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  enableLoading() {
    state = VerifyEmailResponse(code: state.code, message: state.message, loading: true);
  }

  disableLoading() {
    state = VerifyEmailResponse(
      code: state.code,
      message: state.message,
      loading: false,
      data: state.data,
    );
  }
}

var verifyEmailProvider =
    StateNotifierProvider<VerifyEmailNotifier, VerifyEmailResponse>((ref) => VerifyEmailNotifier());
