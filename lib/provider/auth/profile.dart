import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/login.dart';
import 'package:logaluxe_users/provider/auth/verify_email.dart';

class ProfileNotifier extends StateNotifier<UserModel> {
  ProfileNotifier()
      : super(UserModel(
            first_name: '',
            bio: '',
            email: '',
            business_name: '',
            business_address: '',
            token: '',
            image_url: '',
            company_id: '',
            id: ''));
  authenticate(UserModel user) {
    state = user;
  }

  logOut() {
    state = UserModel(
        first_name: '',
        bio: '',
        email: '',
        business_name: '',
        business_address: '',
        token: '',
        company_id: '',
        image_url: '',
        id: '');
  }

  Future<UserModel> updateProfile(String firstName, String email, String token, String image_url) async {
    try {
      final response = await http.patch(
        Uri.parse("${dotenv.env['API_URL']!}/auth/update-profile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: jsonEncode({"first_name": firstName, "email": email, "image_url": image_url}),
      );
      if (response.statusCode == 200) {
        state = UserModel.fromJson(jsonDecode(response.body), token);
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

  Future<Map<String, dynamic>> uploadPicture(XFile file, String token) async {
    try {
      final uri = Uri.parse(
        "${dotenv.env['API_URL']!}/auth/upload-image",
      );

      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer ${token}';
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        throw new Exception("Unable to update picture");
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}

var profileProvider = StateNotifierProvider<ProfileNotifier, UserModel>(
  (ref) {
    return ProfileNotifier();
  },
);
