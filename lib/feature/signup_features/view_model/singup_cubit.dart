
import 'package:clinic/feature/signup_features/data/reggister_model/register_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'singup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignupInitial());

    static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController() ;
  TextEditingController emailController = TextEditingController() ;
  TextEditingController phoneController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;
  TextEditingController confirmPasswordController = TextEditingController() ;
  var formKey = GlobalKey<FormState>();

  RegisterModel? registerModel ;
}
