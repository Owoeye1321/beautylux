import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/api/auth.dart';
import 'package:http/http.dart' as http;

class RegistierNotifier extends StateNotifier<RegisterResponse> {
  RegistierNotifier() : super(RegisterResponse(code: 404, message: '', loading: false));

  Future<RegisterResponse> register(RegisterRequest data) async {
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env['API_URL']!}/auth/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()),
      );
      if (response.statusCode == 200) {
        print(response);
        return RegisterResponse.fromJson(jsonDecode(response.body));
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
    state = RegisterResponse(code: state.code, message: state.message, loading: true);
  }

  disableLoading() {
    state = RegisterResponse(code: state.code, message: state.message, loading: false);
  }
}

var registerProvider =
    StateNotifierProvider<RegistierNotifier, RegisterResponse>((ref) => RegistierNotifier());
