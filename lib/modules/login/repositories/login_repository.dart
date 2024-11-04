import 'package:dartz/dartz.dart';
import 'package:minimal/modules/login/models/login.dart';

abstract class LoginRepository {
  Future<Either<Fail, LoginResponse>> login(String email, String password);
}
