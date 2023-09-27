import 'package:clinic/core/services/screen_size.dart';
import 'package:clinic/core/widget/components/components.dart';
import 'package:clinic/feature/profile_feature/cubit/profile_cubit.dart';
import 'package:clinic/feature/profile_feature/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context,state) {},
      builder: (context,state) {
        ProfileCubit cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff174068),
            title: Text('VCare'),
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.profileFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: ScreenSize.screenHeight*0.01,),
                      Text('Update details!', style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff030E19),
                      ),),
                      SizedBox(height: ScreenSize.screenHeight*0.01,),
                      Text('Update your info and become a new you!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400
                        ),),
                      SizedBox(height: ScreenSize.screenHeight*0.05,),
                      TextFieldComponent(controller: cubit.profileNameController, label: 'Name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your updated name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: ScreenSize.screenHeight*0.03,),
                      TextFieldComponent(
                        label: 'Email',
                        controller: cubit.profileEmailController,
                        validator: (value) {
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return 'please enter your updated email';
                          } else if (!emailValid) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: ScreenSize.screenHeight*0.03,),
                      TextFieldComponent(
                        label: 'Phone',
                        controller: cubit.profilePhoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your updated phone';
                          }
                          if (value.length != 11) {
                            return 'Phone number must be 11 digits.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: ScreenSize.screenHeight*0.03,),
                      Row(
                        children: [
                          Container(
                            width: ScreenSize.screenWidth*0.4,
                            child: RadioListTile(
                              title: Text('Male',style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),),
                              value: 1,
                              contentPadding: EdgeInsets.zero,
                              groupValue: cubit.groupValue,
                              onChanged: (value) {
                                cubit.handleRadioListChanged(value);
                              },
                              activeColor: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.01,
                          ),
                          Container(
                            width: ScreenSize.screenWidth*0.4,
                            child: RadioListTile(
                              title: Text('Female',style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),),
                              contentPadding: EdgeInsets.zero,
                              value: 2,
                              groupValue: cubit.groupValue,
                              onChanged: (value) {
                                cubit.handleRadioListChanged(value);
                              },
                              activeColor: defaultColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: (){},
                            child: Text('change password?',
                              style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.screenHeight*0.01,),
                      defaultButton(
                          text: 'UPDATE',
                          onpressed: () {
                            if (cubit.profileFormKey.currentState!.validate()) {
                              print('Updated');
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
