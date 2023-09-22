import 'package:clinic/core/errors/failure.dart';
import 'package:clinic/feature/signup_features/data/reggister_model/register_model.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterRepo {
  Future<Either<Failure, RegisterModel>> registerInApp({
    required   String name,
    required  String email,
    required  String phone,
    required String gender,
    required String password,
    required  String confirmPassword,
  });
}
