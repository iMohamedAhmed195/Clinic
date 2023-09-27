import 'package:buildcondition/buildcondition.dart';
import 'package:clinic/core/constants/styles.dart';
import 'package:clinic/core/services/network/local/cache_helper.dart';
import 'package:clinic/core/services/network/local/enums.dart';
import 'package:clinic/feature/home/presentation/views/home_screen.dart';
import 'package:clinic/feature/register/presentation/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

import '../../../login/presentation/views/login_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registered Successfully'),
              duration: Duration(seconds: 1),
                showCloseIcon: true,
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
            CacheHelper.putString(
                    key: MySharedKeys.token,
                    value:
                        RegisterCubit.get(context).registerModel?.data?.token)
                .then((value) {
            });
          }
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something Went Wrong')),
            );
          }
        },
        builder: (context, state) {
         var  cubit = RegisterCubit.get(context);
          return SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: cubit.formRegisterKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Let's get started!",
                      style: GoogleFonts.roboto(
                          fontSize: 37.sp, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      '''create an account and start booking now
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please add your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: buildOutlineInputBorder(),
                            focusedBorder: buildOutlineInputBorder(),
                            hintText: 'Name'),
                        keyboardType: TextInputType.name,
                        controller: cubit.nameController,
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
                        validator:(value) {
                          if (value == null || value.isEmpty) {
                            return 'please add your Phone';
                          }
                          if (value.toString().length > 11 ||
                              value.toString().length < 11) {
                            return "please enter right phone number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: buildOutlineInputBorder(),
                            focusedBorder: buildOutlineInputBorder(),
                            hintText: 'Phone'),
                        keyboardType: TextInputType.phone,
                        controller: cubit.phoneController,
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
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 30),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value != cubit.confirmPasswordController.text){
                            return 'confirm password must match password';
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          enabledBorder: buildOutlineInputBorder(),
                          focusedBorder: buildOutlineInputBorder(),
                          hintText: 'Confirm Password',

                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: cubit.confirmPasswordController,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 7.w,
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: cubit.isMaleChecked,
                          onChanged: (bool? value) {
                            cubit.changeCheckBoxOfMale(value);
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Male",
                          style: GoogleFonts.roboto(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: cubit.isFemaleChecked,
                          onChanged: (bool? value) {
                            cubit.changeCheckBoxOfFemale(value);
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Female",
                          style: GoogleFonts.roboto(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "    Already have an account?",
                          style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            child: Text(
                              "Login here",
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
                      condition: state is! RegisterLoadingState,
                      builder: (context) =>Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color:  Styles.kPrimaryColor),
                        child: MaterialButton(
                          onPressed: () {
                            if (cubit.formRegisterKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              cubit.register();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          child: const Text(
                            'Register',
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
