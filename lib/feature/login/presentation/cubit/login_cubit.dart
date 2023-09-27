import 'package:bloc/bloc.dart';
import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/core/remote/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


import '../../data/models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context)=>BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formLoginKey = GlobalKey<FormState>();

  bool isChecked=false;
  changeCheckBox(checked){
    isChecked= checked;
    emit(ChangeRememberState());
  }
  LoginModel? loginModel;

  void login() {
    emit(LoginLoadingState());
    DioHelper.PostData(url: loginUrl, data: {
      'email': emailController.text,
      "password": passwordController.text,
    }).then((value) {
      emit(LoginLoadingState());
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =!  isPassword;

    suffix=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());

  }
}
