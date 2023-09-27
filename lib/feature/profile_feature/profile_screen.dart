import 'package:clinic/core/services/screen_size.dart';
import 'package:clinic/feature/profile_feature/cubit/profile_cubit.dart';
import 'package:clinic/feature/profile_feature/cubit/profile_states.dart';
import 'package:clinic/feature/profile_feature/update_profile_screen.dart';
import 'package:clinic/feature/profile_history_feature/view/profile_history_view.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocProvider(
  create: (context) => ProfileCubit()..getUser()..getAllAppointments(),
  child: BlocBuilder<ProfileCubit,ProfileStates>(
      builder: (context,state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is GetAllAppointmentsSuccessState ,

            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child:Column(
                      children: [
                        const Image(image: AssetImage('assets/images/person.png')),
                        SizedBox(height: ScreenSize.screenHeight*0.01,),
                        Text(cubit.profileModel!.data![0].name!, style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xff030E19),
                        ),),
                        SizedBox(height: ScreenSize.screenHeight*0.005,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
                              },
                              child: const Text('Edit account details', style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400
                              ),),
                            ),
                            SizedBox(width: ScreenSize.screenWidth*0.005,),
                            const Image(image: AssetImage('assets/images/edit.png'),width: 18,)
                          ],
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.03,),
                        Divider(
                          height: 2,
                          color: Colors.grey.shade900,
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(image: const AssetImage('assets/images/mail.png',),width: ScreenSize.screenWidth*0.1),
                            SizedBox(width: ScreenSize.screenWidth*0.05,),
                            Text(cubit.profileModel!.data![0].email!,style: const TextStyle(
                              color: Color(0xff030E19),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),),
                          ],
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(image: const AssetImage('assets/images/call.png',),width: ScreenSize.screenWidth*0.1),
                            SizedBox(width: ScreenSize.screenWidth*0.05,),
                            Text(cubit.profileModel!.data![0].phone!,style: const TextStyle(
                              color: Color(0xff030E19),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),),
                          ],
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(image: const AssetImage('assets/images/lock.png',),width: ScreenSize.screenWidth*0.1),
                            SizedBox(width: ScreenSize.screenWidth*0.05,),
                            const Text('•••••••••••',style: TextStyle(
                              color: Color(0xff030E19),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),),

                          ],
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.02,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('History', style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff030E19),
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Colors.black,
                              decorationThickness: 2.0,
                            ),),

                          ],
                        ),
                        SizedBox(height: ScreenSize.screenHeight*0.02,),
                       ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileHistoryView(getAllAppointmentsModel: cubit.getAllAppointmentsModel! , index: index,)));
                            },
                              child: buildHistoryItem(context , cubit.getAllAppointmentsModel!.data![index].appointmentTime!, cubit.getAllAppointmentsModel!.data![index].status!  )),
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height:
                            ScreenSize.screenHeight * 0.02,
                          ),
                      itemCount:cubit.getAllAppointmentsModel!.data!.length),

                      ],
                    ),
                  ),
                ),
              );
            },
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    ),
);
  }
  Widget buildHistoryItem(context , String bookingDate,String status ) =>
      Container(
        height: ScreenSize.screenHeight * 0.04,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex:3,
              child: Text(bookingDate,style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize:13,
              ),),
            ),
            const Spacer(),
            Expanded(
              flex: 0,
              child: Text(status,style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 13,
              ),),
            ),
          ],
        ),
      );
}
