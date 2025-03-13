import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/user.dart';

class LoginRequest {
  final String email;
  final String password;
  LoginRequest({required this.email, required this.password});
}

class LoginResponse {
  final int code;
  final String message;
  final UserModel data;
  LoginResponse({required this.code, required this.message, required this.data});
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
    return VerifyEmailResponse(
      code: object['code'],
      message: object['message'],
      loading: false,
      data: UserModel(
          token: object['data']['token'],
          first_name: object['data']['first_name'],
          bio: '',
          business_address: '',
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
