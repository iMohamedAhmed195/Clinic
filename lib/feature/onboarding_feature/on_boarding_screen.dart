import 'package:clinic/core/services/app_reouter.dart';
import 'package:clinic/core/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding/onboarding.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Material materialButton;
  late int index;
  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }
  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: Color(0xff174068),
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          GoRouter.of(context).push(AppRouter.kDoctorDetails);
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'LogIN',
            style:TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Onboarding(pages: [
        PageModel(
          widget: SafeArea(
            child: Column(
              children: [
                Container(
                  child: Image(image: AssetImage('assets/images/1.jpg',)),
                  width: double.infinity,
                  height: ScreenSize.screenHeight*0.4,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Find Doctors & Schedule Appointments',
                      style: TextStyle(
                        color: Color(0xff174068),
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.screenHeight*0.05,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Discover a network of doctors and healthcare professionals near you. '
                          '\n\nEasily book appointments and manage your healthcare needs with convenience. ',
                      style: TextStyle(
                        color: Color(0xff030E19),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        PageModel(
          widget: SafeArea(
            child: Column(
              children: [
                Container(
                    child: Image(image: AssetImage('assets/images/2.jpg',)),
                    width: double.infinity,
                    height: ScreenSize.screenHeight*0.4,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Effortless Appointment Management',
                      style: TextStyle(
                        color: Color(0xff174068),
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.screenHeight*0.05,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                          'Streamline your healthcare experience with vCare. '
                          '\n\nManage your appointments, receive timely reminders, and stay organized. ',
                      style: TextStyle(
                        color: Color(0xff030E19),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        PageModel(
          widget: SafeArea(
            child: Column(
              children: [
                Container(
                  child: Image(image: AssetImage('assets/images/3.jpg',)),
                  width: double.infinity,
                  height: ScreenSize.screenHeight*0.4,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Start Your Journey',
                      style: TextStyle(
                        color: Color(0xff174068),
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.screenHeight*0.05,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome to vCare! Begin your wellness journey with us and unlock a world of health and well-being. '
                          '\n\nTake the hassle out of scheduling and enjoy a stress-free approach to accessing quality healthcare services.',
                      style: TextStyle(
                        color: Color(0xff030E19),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
        onPageChange: (int pageIndex) {
          index = pageIndex;
        },
        startPageIndex: 0,
        footerBuilder: (context, dragDistance, pagesLength, setIndex) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xff174068),
            ),
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIndicator(
                      netDragPercent: dragDistance,
                      pagesLength: pagesLength,
                      indicator: Indicator(
                        indicatorDesign: IndicatorDesign.polygon(
                          polygonDesign: PolygonDesign(polygon: DesignType.polygon_circle),
                        ),
                        activeIndicator: ActiveIndicator(
                          borderWidth: ScreenSize.screenWidth*0.005,
                          color: Color(0xff174068),
                        ),
                        closedIndicator: ClosedIndicator(
                            borderWidth: ScreenSize.screenWidth*0.005,
                            color: Color(0xff174068),
                        )
                      ),
                    ),
                    index == pagesLength - 1
                        ? _signupButton
                        : _skipButton(setIndex: setIndex)
                  ],
                ),
              ),
            ),
          );
        },

      )







    );
  }
}
//SafeArea(
//         child: Column(
//           children: [
//             Image(image: AssetImage('assets/images/1.jpg')),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Connect people around the world',
//                   style: TextStyle(
//                     color: defaultColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22.0,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),