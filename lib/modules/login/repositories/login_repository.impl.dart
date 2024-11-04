import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:minimal/core/endpoints.dart';
import 'package:minimal/services/network/network_client.dart';
import 'package:minimal/modules/login/models/login_request.dart';

import '../models/login.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required NetworkClient networkClient,
    required Endpoints endpoints,
  })  : _networkClient = networkClient,
        _endpoints = endpoints;

  final NetworkClient _networkClient;
  final Endpoints _endpoints;

  @override
  Future<Either<Fail, LoginResponse>> login(
      String email, String password) async {
    final request = LoginRequest(
        url: _endpoints.loginEndPoint, email: email, password: password);

    try {
      final response = await _networkClient.post(
        Uri.parse(_endpoints.loginEndPoint),
        body: request.body,
        headers: request.headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(LoginResponse.fromJson(json.decode(response.body)));
      }

      return Left(Fail(response.body));
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
