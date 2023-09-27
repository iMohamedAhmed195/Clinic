import 'package:buildcondition/buildcondition.dart';
import 'package:clinic/core/constants/styles.dart';
import 'package:clinic/core/services/network/local/cache_helper.dart';
import 'package:clinic/core/services/network/local/enums.dart';

import 'package:clinic/feature/login/presentation/cubit/login_cubit.dart';
import 'package:clinic/feature/register/presentation/views/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../home/presentation/views/home_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Login Successfully'),
                  duration: Duration(seconds: 1),showCloseIcon: true,),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
            CacheHelper.putString(
                    key: MySharedKeys.token,
                    value: LoginCubit.get(context).loginModel?.data?.token)
                .then((value) {
            });
          }
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something Went Wrong')),
            );
          }
        },
        builder: (context, state) {
         var  cubit = LoginCubit.get(context);
          return SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: cubit.formLoginKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.roboto(
                          fontSize: 37.sp, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      '''Login to book appointment and 
    see all available doctors
                           ''',
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF7C808A),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 30),
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'please add your email';
                          }
                          final bool isValid = EmailValidator.validate(value);
                          if (!isValid) {
                            return "please enter right email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: buildOutlineInputBorder(),
                            focusedBorder: buildOutlineInputBorder(),
                            hintText: 'email'),
                        keyboardType: TextInputType.emailAddress,
                        controller: cubit.emailController,
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 30),
                      child: TextFormField(
                        validator: (value){
                          if(value!.length <=6)
                          {
                            return 'please enter right password';
                          }
                          return null ;
                        },

                        decoration: InputDecoration(
                            enabledBorder: buildOutlineInputBorder(),
                            focusedBorder: buildOutlineInputBorder(),
                            hintText: 'password',

                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: cubit.passwordController,
                      ),
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 7.w,
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          value: cubit.isChecked,
                          onChanged: (bool? value) {
                            cubit.changeCheckBox(value);
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Keep me logged in",
                          style: GoogleFonts.roboto(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "    No account yet?",
                          style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),

                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return const RegisterScreen();
                                  }));
                            },
                            child: Text(
                              "Register here",
                              style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(3, 14, 25, 0.70)),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildCondition(
                      condition: state is! LoginLoadingState,
                      builder: (context) => Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Styles.kPrimaryColor),
                        child: MaterialButton(
                          onPressed: () {
                            if ( cubit.formLoginKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              cubit.login();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  buildOutlineInputBorder() {

    return OutlineInputBorder(

        borderSide: const BorderSide(color: Styles.kColor),
        borderRadius: BorderRadius.circular(6));
  }
}
