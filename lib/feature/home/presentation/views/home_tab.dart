
import 'package:clinic/feature/doctor_details_feature/presentation/view/doctor_details_view.dart';
import 'package:clinic/feature/home/presentation/cubit/home_cubit.dart';
import 'package:clinic/feature/home/presentation/views/widgets/doctor_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/screen_size.dart';
import '../../../../core/widget/components/components.dart';
import '../../data/models/filters_models.dart';



class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  InkWell buildDoctorItem(BuildContext context, name, specialization, doctorId,
      email, phone, degree, gender) {
    return InkWell(

        child: DoctorItem(
          doctorName: name,
          doctorSpecialization: specialization,
        ));
  }


  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
         return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
            var  cubit = HomeCubit.get(context);
              return Scaffold(
                key: cubit.scaffoldKey,
                body: ConditionalBuilder(
                    condition: state is !GetHomeDataLoadingState,
                    builder: (context){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: smalldefaultButton(text: 'FILTER',
                                    onpressed: (){
                                      // cubit.showBottomSheet(context);
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25),
                                          ),
                                        ),
                                        builder: ((context) {
                                          // bool isContainerVisible = false;
                                          // void updateStatus() {
                                          //   setState(() {
                                          //     isContainerVisible =! isContainerVisible;
                                          //   });
                                          // }
                                          return Form(
                                            key: cubit.filterFormKey,
                                            child: Wrap(children: [
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(30.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          const Icon(Icons.filter_alt_outlined,color: Color(0xff174068),),
                                                          const Text('FILTER', style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14,
                                                            color: Color(0xff174068),
                                                          ),),
                                                          const Spacer(),

                                                          IconButton(onPressed: (){
                                                            Navigator.of(cubit.scaffoldKey.currentContext!).pop();
                                                          }, icon: const Icon(Icons.close)),
                                                        ],
                                                      ),
                                                      SizedBox(height: ScreenSize.screenHeight*0.01),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          const Text('CITY',style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,

                                                          ),),
                                                          const Spacer(),
                                                          TextButton(onPressed: (){
                                                            setState(() {
                                                              cubit.cityFilterStatus = false;
                                                            });
                                                            Navigator.of(cubit.scaffoldKey.currentContext!).pop();

                                                          }, child: Text(
                                                            'clear',style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12,
                                                              color: Colors.grey.shade600
                                                          ),
                                                          )),
                                                          IconButton(onPressed: ()  {
                                                            setState(()  {
                                                              cubit.changeFilterCity();
                                                            });
                                                          }, icon: cubit.cityStateIcon),

                                                        ],
                                                      ),
                                                      cubit.openCities == true ? FutureBuilder<List<CityModel>>(
                                                        future: cubit.getAllCities(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState ==
                                                              ConnectionState.waiting) {
                                                            return const Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Center(
                                                                  child: CircularProgressIndicator(),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          else if (snapshot.hasError) {
                                                            return Center(
                                                              child: Text('Error: ${snapshot.error}'),
                                                            );
                                                          }
                                                          else {
                                                            final cities = snapshot.data;
                                                            if (cities != null) {
                                                              return Column(
                                                                children: [
                                                                  StatefulBuilder(
                                                                    builder: ( context, setState) {
                                                                      return SizedBox(
                                                                        height:
                                                                        ScreenSize.screenHeight * 0.2,
                                                                        child: ListView.separated(
                                                                            scrollDirection: Axis.vertical,
                                                                            shrinkWrap: true,
                                                                            itemBuilder: (context,
                                                                                index) => buildCityItem(cities[index],cubit,context),
                                                                            separatorBuilder:
                                                                                (context, index) =>
                                                                                SizedBox(
                                                                                  height: ScreenSize
                                                                                      .screenHeight *
                                                                                      0.001,
                                                                                ),
                                                                            itemCount: cities.length),
                                                                      );
                                                                    },
                                                                  ),


                                                                ],
                                                              );
                                                            } else {
                                                              return const SizedBox
                                                                  .shrink(); // Placeholder widget if venues is null
                                                            }
                                                          }
                                                        },
                                                      ) : const SizedBox.shrink(),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          const Text('GOVERNORATE',style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,

                                                          ),),
                                                          const Spacer(),
                                                          TextButton(onPressed: (){
                                                            setState(() {
                                                              cubit.governorateFilterStatus = false;
                                                            });
                                                            Navigator.of(cubit.scaffoldKey.currentContext!).pop();

                                                          }, child: Text(
                                                            'clear',style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12,
                                                              color: Colors.grey.shade600
                                                          ),
                                                          )),
                                                          IconButton(onPressed: (){
                                                            setState(() {
                                                              cubit.changeFilterGovernorate();
                                                            });
                                                          }, icon: cubit.governorateStateIcon),

                                                        ],
                                                      ),
                                                      cubit.openGovernorate == true ? FutureBuilder<List<GovernorateModel>>(
                                                        future: cubit.getAllGovernorates(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState ==
                                                              ConnectionState.waiting) {
                                                            return StatefulBuilder(
                                                              builder: (context,setState){
                                                                return const Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Center(
                                                                      child: CircularProgressIndicator(),
                                                                    ),
                                                                  ],
                                                                );
                                                              },

                                                            );
                                                          }
                                                          else if (snapshot.hasError) {
                                                            return Center(
                                                              child: Text('Error: ${snapshot.error}'),
                                                            );
                                                          }
                                                          else {
                                                            final governorate = snapshot.data;
                                                            if (governorate != null) {
                                                              return StatefulBuilder(
                                                                builder: (context,setState){
                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                        ScreenSize.screenHeight * 0.2,
                                                                        child: ListView.separated(
                                                                            scrollDirection: Axis.vertical,
                                                                            shrinkWrap: true,
                                                                            itemBuilder: (context,
                                                                                index) => buildGovernorateItem(governorate[index],cubit,context),
                                                                            separatorBuilder:
                                                                                (context, index) =>
                                                                                SizedBox(
                                                                                  height: ScreenSize
                                                                                      .screenHeight *
                                                                                      0.001,
                                                                                ),
                                                                            itemCount: governorate.length),
                                                                      ),


                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              return const SizedBox
                                                                  .shrink(); // Placeholder widget if venues is null
                                                            }
                                                          }
                                                        },
                                                      ) : const SizedBox.shrink(),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          const Text('SPECIALIZATION',style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,

                                                          ),),
                                                          const Spacer(),
                                                          TextButton(onPressed: (){
                                                            setState(() {
                                                              cubit.speciatizationFilterStatus = false;
                                                            });
                                                            Navigator.of(cubit.scaffoldKey.currentContext!).pop();

                                                          }, child: Text(
                                                            'clear',style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12,
                                                              color: Colors.grey.shade600
                                                          ),
                                                          )),
                                                          IconButton(onPressed: (){
                                                            cubit.changeFilterSpecialication();
                                                          }, icon: cubit.specialicationStateIcon),

                                                        ],
                                                      ),
                                                      cubit.openSpecialication == true ? FutureBuilder<List<SpecializationModel>>(
                                                        future: cubit.getAllSpecialization(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState ==
                                                              ConnectionState.waiting) {
                                                            return const Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Center(
                                                                  child: CircularProgressIndicator(),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          else if (snapshot.hasError) {
                                                            return Center(
                                                              child: Text('Error: ${snapshot.error}'),
                                                            );
                                                          }
                                                          else {
                                                            final specialization = snapshot.data;
                                                            if (specialization != null) {
                                                              return Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                    ScreenSize.screenHeight * 0.2,
                                                                    child: ListView.separated(
                                                                        scrollDirection: Axis.vertical,
                                                                        shrinkWrap: true,
                                                                        itemBuilder: (context,
                                                                            index) => buildSpecializationItem(specialization[index],cubit,context),
                                                                        separatorBuilder:
                                                                            (context, index) =>
                                                                            SizedBox(
                                                                              height: ScreenSize
                                                                                  .screenHeight *
                                                                                  0.001,
                                                                            ),
                                                                        itemCount: specialization.length),
                                                                  ),


                                                                ],
                                                              );
                                                            } else {
                                                              return const SizedBox
                                                                  .shrink(); // Placeholder widget if venues is null
                                                            }
                                                          }
                                                        },
                                                      ) : const SizedBox.shrink(),
                                                      defaultButton(
                                                          text: 'APPLY',
                                                          onpressed: () {
                                                            if (cubit.filterFormKey.currentState!.validate()) {
                                                              print('Filtered');
                                                              print(cubit.selectedFilterdCity?.name);

                                                              Navigator.of(cubit.scaffoldKey.currentContext!).pop();

                                                            }
                                                          }),

                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]),
                                          );
                                        }
                                        ),
                                      );


                                    }, color: defaultColor, context: context)
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context , index){
                                return   Column(
                                  children: [
                                    Text(
                                      " ${cubit.getHomeDataModel?.data?[index].name ?? ""}",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.sizeOf(context).height * 0.3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              itemBuilder:(context , indexDoctor){
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorDetailsView(doctorId: cubit.getHomeDataModel!.data![index].doctors![indexDoctor].id.toString())));
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
                                                            child:Image(image: NetworkImage(cubit.getHomeDataModel!.data![index].doctors![indexDoctor].photo!),
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
                                                                        cubit.getHomeDataModel!.data![index].doctors![indexDoctor].name!,
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
                                                                        cubit.getHomeDataModel!.data![index].doctors![indexDoctor].degree!,
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
                                              },

                                              scrollDirection: Axis.horizontal,
                                              itemCount: cubit.getHomeDataModel!.data![index].doctors!.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )

                                  ],
                                );
                              },
                              itemCount: cubit.getHomeDataModel?.data?.length,
                            ),
                          )

                        ],
                      );
                    },
                    fallback: (context){
                      return Center(child:CircularProgressIndicator());
                    }
                )
              );
            }
        );
  }
  Widget buildCityItem(CityModel model,HomeCubit cubit ,context) => SizedBox(
    height: ScreenSize.screenHeight*0.04,
    child: RadioListTile(
      title: Text(model.name,style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),),
      value: model.id,
      contentPadding: EdgeInsets.zero,
      groupValue: cubit.groupValue,
      onChanged: (value) {
        cubit.handleRadioListChanged(value);
        cubit.selectedFilterdCity = model;
        setState(() {
          cubit.cityFilterStatus = true;
        });
      },
      activeColor: defaultColor,
    ),
  );

  Widget buildGovernorateItem(GovernorateModel model,HomeCubit cubit ,context) => SizedBox(
    height: ScreenSize.screenHeight*0.04,
    child: RadioListTile(
      title: Text(model.name,style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),),
      value:model.id ,
      contentPadding: EdgeInsets.zero,
      groupValue: cubit.groupValue,
      onChanged: (value) {
        cubit.handleRadioListChanged(value);
        cubit.selectedFilterdGovernorate = model;
        setState(() {
          cubit.governorateFilterStatus = true;
        });
      },
      activeColor: defaultColor,
    ),
  );

  Widget buildSpecializationItem(SpecializationModel model,HomeCubit cubit ,context) => SizedBox(
    height: ScreenSize.screenHeight*0.04,
    child: RadioListTile(
      title: Text(model.name,style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),),
      value: model.id,
      contentPadding: EdgeInsets.zero,
      groupValue: cubit.groupValue,
      onChanged: (value) {
        cubit.handleRadioListChanged(value);
        cubit.selectedFilterdSpecialization = model;
        setState(() {
          cubit.speciatizationFilterStatus = true;
        });
      },
      activeColor: defaultColor,
    ),
  );

}
