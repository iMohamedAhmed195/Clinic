// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:clinic/core/errors/failure.dart';
import 'package:clinic/core/services/dio_helper.dart';
import 'package:clinic/core/services/end_point.dart';
import 'package:clinic/feature/signup_features/data/reggister_model/register_model.dart';
import 'package:clinic/feature/signup_features/data/register_repo/register_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RegisterRepoImpl extends RegisterRepo {

  RegisterModel? registerModel;
 var response ;
  @override
  Future<Either<Failure, RegisterModel>> registerInApp(
      {required String name,
      required String email,
      required String phone,
      required String gender,
      required String password,
      required String confirmPassword}) async{
    print('iam here in repo 1');
    print(EndPoints.registerPoint);
    print(name);
    print(email);
    print(phone);
    print(gender);
    print(password);
    print(confirmPassword);
    await  DioHelper.postData(url: EndPoints.registerPoint, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'password': password,
      'password_confirmation': confirmPassword,
    }).then((value) {
      print('i am value');
      registerModel = RegisterModel.fromJson(value.data);
       response = registerModel;
    }).catchError((error){

      print(error.toString());
    });
    return response ;
  }
  // Future<Either<Failure, RegisterModel>> registerInApp(
  //     {required String name,
  //       required String email,
  //       required String phone,
  //       required String gender,
  //       required String password,
  //       required String confirmPassword}) async{
  //   try {
  //     print('iam here in repo 1');
  //     print(EndPoints.registerPoint);
  //     print(name);
  //     print(email);
  //     print(phone);
  //     print(gender);
  //     print(password);
  //     print(confirmPassword);
  //     var value =  await  DioHelper.postData(url: EndPoints.registerPoint, data: {
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //       'gender': gender,
  //       'password': password,
  //       'password_confirmation': confirmPassword,
  //     });
  //     print('iam here in repo 2');
  //     registerModel = RegisterModel.fromJson(value.data);
  //     print('iam here in repo 3');
  //     return right(registerModel!);
  //   } catch (e) {
  //     print('iam here in failure');
  //     return left(ServerFailure('iam here in failure'));
  //
  //   }
  // }
}
