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
  RegisterResponse({required this.code, required this.message});
}

class TokenResponse {
  final String token;
  TokenResponse({required this.token});
}

class VerifyEmailRequest {
  final String otp;
  final String email;
  VerifyEmailRequest({required this.email, required this.otp});
}

class VerifyEmailResponse {
  final int code;
  final String message;
  final TokenResponse data;
  VerifyEmailResponse({required this.code, required this.message, required this.data});
}
