import 'package:clinic/feature/signup_features/data/reggister_model/register_model.dart';
import 'package:clinic/feature/signup_features/data/register_repo/register_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'singup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.registerRepo) : super(SignupInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  final RegisterRepo registerRepo;

  Future<void> registerApp(
      {required String name,
      required String email,
      required String phone,
      required String gender,
      required String password,
      required String confirmPassword}) async {
    emit(SignupLoading());
    print(name);
    print(email);
    print(phone);
    print(gender);
    print(password);
    print(confirmPassword);
    var result = await registerRepo.registerInApp(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        password: password,
        confirmPassword: confirmPassword);
     print(result);
     result.fold((failure) {

          emit(SignupError(failure.errorMessage));
    }, (registerModel) {
      emit(SignupSuccess(registerModel)
      );
    });
  }
}
