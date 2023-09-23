import 'package:clinic/core/constants/assets.dart';
import 'package:clinic/core/constants/styles.dart';
import 'package:clinic/core/widget/custom_time.dart';
import 'package:clinic/feature/doctor_details_feature/presentation/doctor_details_cubit/doctor_details_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsCubit()..getDetails(),
      child: BlocConsumer<DoctorDetailsCubit, DoctorDetailsState>(
        listener: (context, state) {
          if(state is ChangeTimeColor){
            print('hi');
          }
        },
        builder: (context, state) {
          var cubit = DoctorDetailsCubit.get(context);
          return
            Scaffold(
              backgroundColor: Styles.kColor,
              body: ConditionalBuilder(
                condition: state is !GetDetailsDoctorLoadingState,
                builder: (context){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: MediaQuery.sizeOf(context).height * 0.333333,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )
                        ),
                        child: Image.asset(AssetsData.profile,fit: BoxFit.fitWidth,),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(cubit.doctorDetailsModel!.data!.name!,
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff030E19)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          cubit.doctorDetailsModel!.data!.description!,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff030E19)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.selectStartDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2, color: Colors.grey[600]!))),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: Text('Picked End Date'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 6),
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      'YY/MM/DD',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22,
                                          color: Color(0xff030E19)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Opacity(
                        opacity: 0.7,
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                          child: Text(
                            'Select Time',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff030E19)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              cubit.changeColor( index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: CustomTime(
                                time: '${cubit.lastTime[index]}:00',
                                isTime: cubit.isTime[index],
                              ),
                            ),
                          ),
                          itemCount: cubit.lastTime.length,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xff174068)),
                              child: MaterialButton(
                                onPressed: () {},
                                child: const Text(
                                  'Book an appointment',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                fallback: (BuildContext context) { return Center(child: CircularProgressIndicator(),); },

              ),
            );
        },
      ),
    );
  }
}
