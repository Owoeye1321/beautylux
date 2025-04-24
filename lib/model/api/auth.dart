import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/user.dart';

class LoginRequest {
  final String email;
  final String password;
  LoginRequest({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final int code;
  final String message;
  final UserModel data;
  final bool loading;
  LoginResponse({required this.code, required this.message, required this.data, required this.loading});
  factory LoginResponse.fromJson(Map<String, dynamic> object) {
    return LoginResponse(
      code: object['code'],
      message: object['message'],
      loading: false,
      data: UserModel(
        token: object['data']['token'],
        first_name: object['data']['first_name'],
        bio: '',
        email: object['data']['email'],
        image_url:
            object['data']['image_url'].toString() != 'null' ? object['data']['image_url'].toString() : "",
        id: object['data']['id'],
        business_address: '',
        business_name: '',
        company_id: '',
      ),
    );
  }
}

class RegisterResponse {
  final int code;
  final String message;
  final bool loading;
  final String? email;
  RegisterResponse({required this.code, required this.message, required this.loading, this.email});

  factory RegisterResponse.fromJson(Map<String, dynamic> data, String email) {
    return RegisterResponse(code: data['code'], message: data['message'], loading: false, email: email);
  }
}

class TokenResponse {
  final String token;
  TokenResponse({required this.token});
}

class VerifyEmailRequest {
  final String otp;
  final String email;
  VerifyEmailRequest({required this.email, required this.otp});
  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'email': email,
    };
  }
}

class VerifyEmailResponse {
  final int code;
  final String message;
  final bool loading;
  final UserModel? data;
  VerifyEmailResponse({required this.code, required this.message, this.data, required this.loading});
  factory VerifyEmailResponse.fromJson(Map<String, dynamic> object) {
    print(object);
    return VerifyEmailResponse(
      code: object['code'],
      message: object['message'],
      loading: false,
      data: UserModel(
          token: object['data']['token'],
          first_name: object['data']['first_name'],
          id: object['data']['id'],
          bio: '',
          email: '',
          business_address: '',
          company_id: '',
          business_name: ''),
    );
  }
}

class RegisterRequest {
  final String first_name;
  final String email;
  final String password;
  RegisterRequest({required this.first_name, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'email': email,
      'password': password,
    };
  }
}

class ResetPasswordRequest {
  final String email;
  final String? newPassword;
  final String? token;
  final String platform;
  final bool loading;
  ResetPasswordRequest(
      {required this.email, this.newPassword, this.token, required this.platform, required this.loading});
  Map<String, dynamic> toRequestResetJson() {
    return {"email": email, "platform": platform};
  }

  Map<String, dynamic> toChangePasswordJson() {
    return {"email": email, "token": token, "newPassword": newPassword};
  }
}

class ResetPasswordResponse {
  final int code;
  final String message;
  ResetPasswordResponse({required this.code, required this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> response) {
    return ResetPasswordResponse(code: response['code'], message: response['message']);
  }
}
