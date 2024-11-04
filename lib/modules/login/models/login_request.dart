import 'dart:convert';

import 'package:minimal/general_models/network_request.dart';

class LoginRequest extends NetworkRequest {
  LoginRequest(
      {required super.url, required String email, required String password})
      : email = email,
        password = password;

  final String email;
  final String password;

  @override
  String? get body => json.encode({'email': email, 'password': password});
}
