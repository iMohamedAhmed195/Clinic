import 'package:clinic/core/errors/failure.dart';
import 'package:clinic/feature/signup_features/data/reggister_model/register_model.dart';
import 'package:clinic/feature/signup_features/data/register_repo/register_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterRepoImpl extends RegisterRepo{
  @override
  Future<Either<Failure, RegisterModel>> registerInApp() {
    // TODO: implement registerInApp
    throw UnimplementedError();
  }

}