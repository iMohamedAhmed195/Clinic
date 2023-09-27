import 'package:buildcondition/buildcondition.dart';
import 'package:clinic/feature/doctor_details_feature/presentation/view/doctor_details_view.dart';
import 'package:clinic/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class DoctorsTab extends StatelessWidget {
  const DoctorsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
  create: (context) => HomeCubit()..getAllDoctors(),
  child: Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
         var cubit = HomeCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                BuildCondition(
                    condition: state is! GetAllDoctorsLoadingState,
                    builder: (context) =>
                        BuildCondition(
                          condition:
                          cubit.getAllDoctorModel!.data!.isNotEmpty,
                          builder: (context) => GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 4.h / 6.w,
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.w,
                                mainAxisSpacing: 15.h,
                              ),
                              itemCount: 10,
                              itemBuilder: (BuildContext ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorDetailsView(doctorId: cubit.getAllDoctorModel!.data![index].id.toString())));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.4,

                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white

                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                borderRadius:BorderRadius.only(
                                                    bottomRight: Radius.circular(14),
                                                    bottomLeft: Radius.circular(14)
                                                )

                                            ),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            child:Image(image: NetworkImage(cubit.getAllDoctorModel!.data![index].photo!),
                                            ),
                                            // Image.asset('assets/images/1.jpg',)
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        cubit.getAllDoctorModel!.data![index].name!,
                                                        maxLines:1,
                                                        style: GoogleFonts.inter(
                                                            color: Colors.black,
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        cubit.getAllDoctorModel!.data![index].degree!,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.inter(
                                                            color: Colors.grey,
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15,),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "more details",
                                                      style: GoogleFonts.inter(
                                                          color: Colors.black,
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      width: 3.w,
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_forward,
                                                      size: 20,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              ),
                          fallback: (context) => Padding(
                            padding: const EdgeInsets.only(
                                top: 100, right: 10, left: 10),
                            child: Text(
                                "No Doctors Yet",
                                style: GoogleFonts.roboto(
                                fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),),
                          ),
                        ),
                  fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        },
      ),
    ),
);
  }
}

