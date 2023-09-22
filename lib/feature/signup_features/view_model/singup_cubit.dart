
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'singup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SingupInitial());

    static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController() ;
  TextEditingController emailController = TextEditingController() ;
  TextEditingController phoneController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;
  TextEditingController confirmPasswordController = TextEditingController() ;
  var formKey = GlobalKey<FormState>();


}
