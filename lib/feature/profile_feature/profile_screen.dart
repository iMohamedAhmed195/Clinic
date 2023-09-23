import 'package:clinic/core/services/screen_size.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Image(image: AssetImage('assets/images/person.png')),
                  SizedBox(height: ScreenSize.screenHeight*0.01,),
                  const Text('User name', style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff030E19),
                  ),),
                  SizedBox(height: ScreenSize.screenHeight*0.005,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Edit account details', style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400
                      ),),
                      SizedBox(width: ScreenSize.screenWidth*0.005,),
                      const Image(image: AssetImage('assets/images/edit.png'),width: 18,)
                    ],
                  ),
                  SizedBox(height: ScreenSize.screenHeight*0.05,),
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
                      const Text('employee@email.com',style: TextStyle(
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
                      const Text('+20123178903',style: TextStyle(
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
                          buildHistoryItem(
                             /* cubit.taskTests[index],
                              cubit,*/
                              context),
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height:
                            ScreenSize.screenHeight * 0.02,
                          ),
                      itemCount:
                      15),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildHistoryItem(
      /*BookingModel model,  cubit, */context) =>
      Container(
        height: ScreenSize.screenHeight * 0.08,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Booking date',style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              fontSize: 15,
            ),),
            Spacer(),
            Text('Status',style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              fontSize: 15,
            ),),
          ],
        ),
      );
}
