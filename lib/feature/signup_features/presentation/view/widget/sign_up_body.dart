import 'package:clinic/core/widget/custom_button.dart';
import 'package:clinic/core/widget/custom_text_feild.dart';
import 'package:clinic/core/widget/custom_text_sec_login.dart';
import 'package:clinic/feature/signup_features/view_model/singup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit , SignUpState>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state) {
          var cubit = SignUpCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   const TextSection(header: 'Let’s get started!', para: 'create an account and start booking now.',),
                    CustomTextField(
                      hintText: 'Name',
                      controller: cubit.nameController,
                      obSecure: false,
                      inputType:TextInputType.text,
                      textValidate: 'enter your name ',
                    ),
                    CustomTextField(
                      hintText: 'Email',
                      controller: cubit.emailController,
                      obSecure: false,
                      inputType:TextInputType.emailAddress,
                      textValidate: 'enter your email',
                    ),
                    CustomTextField(
                      hintText: 'Phone',
                      controller: cubit.phoneController,
                      obSecure: false,
                      inputType:TextInputType.phone,
                      textValidate: 'enter your phone ',
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      controller: cubit.passwordController,
                      obSecure: true,
                      inputType:TextInputType.visiblePassword,
                      textValidate: 'enter your password ',
                    ),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      controller: cubit.confirmPasswordController,
                      obSecure: true,
                      inputType:TextInputType.visiblePassword,
                      textValidate: 'enter your confirm password ',
                    ),
                    CustomButton(function: (){
                      if(cubit.formKey.currentState!.validate()){

                      }
                    }, textButton: 'Register Now',)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
