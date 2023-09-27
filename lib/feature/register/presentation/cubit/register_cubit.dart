import 'package:bloc/bloc.dart';
import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/core/remote/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/register_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var formRegisterKey = GlobalKey<FormState>();

  bool isMaleChecked=false;
  bool isFemaleChecked=false;
  String selectedGender = "";

  changeCheckBoxOfMale(checked){
    isMaleChecked= checked;
    isFemaleChecked= false;
    selectedGender = "0";
    emit(ChangeGenderState());
  }

  changeCheckBoxOfFemale(checked){
    isFemaleChecked= checked;
    isMaleChecked = false;
    selectedGender = "1";
    emit(ChangeGenderState());
  }

  RegisterModel? registerModel;
  void register() {
    emit(RegisterLoadingState());
    DioHelper.PostData(url: registerUrl, data: {
      'name' : nameController.text,
      'email': emailController.text,
      'phone' : phoneController.text,
      'password': passwordController.text,
      'password_confirmation' : confirmPasswordController.text,
      'gender' : selectedGender
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
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
