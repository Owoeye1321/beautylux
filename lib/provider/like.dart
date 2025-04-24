import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/model/like.dart';

class LikeNotifier extends StateNotifier<List<LikeModel>> {
  LikeNotifier() : super([]);

  Future<List<LikeModel>> fetchLikes(String token) async {
    try {
      var response = await http.get(Uri.parse("${dotenv.env['API_URL']!}/customer/like-provider"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        state = LikeModel.fromJsonList(jsonDecode(response.body));
        return state;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (error) {
      throw new Exception(error.toString());
    }
  }

  Future<void> saveLike(String token, String provider_id, String user_id) async {
    try {
      if (state.length > 0 && state.any((like) => like.company_id == provider_id))
        state = state.where((like) => like.company_id != provider_id).toList();
      else
        state = [...state, LikeModel(company_id: provider_id, user_id: user_id)];
      var response = await http.post(Uri.parse("${dotenv.env['API_URL']!}/customer/like-provider"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"provider_id": provider_id}));
      if (response.statusCode == 200) {
        return;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (error) {
      print(error);
      throw new Exception(error.toString());
    }
  }
}

var likeProvider = StateNotifierProvider<LikeNotifier, List<LikeModel>>(
  (ref) => LikeNotifier(),
);
