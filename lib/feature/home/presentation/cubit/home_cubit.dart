
import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/core/remote/endpoints.dart';
import 'package:clinic/feature/home/data/models/get_all_doctor_model.dart';
import 'package:http/http.dart' as http;
import 'package:clinic/feature/profile_feature/profile_screen.dart';
import 'package:clinic/feature/search_feature/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/remote/http/const.dart';
import '../../../../core/services/screen_size.dart';
import '../../../../core/widget/components/components.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/filters_models.dart';
import '../../data/models/get_all_appointments_model.dart';
import '../../data/models/get_home_data_model.dart';
import '../../data/models/logout_model.dart';
import '../../data/models/patient_profile_model.dart';
import '../views/doctors_tab.dart';
import '../views/history_tab.dart';
import '../views/home_tab.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<BottomNavyBarItem> tabs = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home, color: Color(0xFF174068)),
      title: const Text(
        "Home",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF174068)),
      ),
      activeColor: Colors.blue,
      inactiveColor: Colors.blueGrey,
    ),
    BottomNavyBarItem(
      icon: const Icon(
        Icons.local_hospital,
        color: Color(0xFF174068),
      ),
      title: const Text(
        "Doctors",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF174068)),
      ),
      activeColor: const Color(0xFF174068),
      inactiveColor: const Color(0xFF174068),
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.search, color: Color(0xFF174068)),
      title: const Text("Search",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF174068))),
      activeColor: const Color(0xFF174068),
      inactiveColor: const Color(0xFF174068),
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.schedule_outlined, color: Color(0xFF174068)),
      title: const Text(
        "History",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF174068)),
      ),
      activeColor: const Color(0xFF174068),
      inactiveColor: const Color(0xFF174068),
    ),
    BottomNavyBarItem(
      icon:
      const Icon(Icons.perm_contact_cal_rounded, color: Color(0xFF174068)),
      title: const Text(
        "Account",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF174068)),
      ),
      activeColor: const Color(0xFF174068),
      inactiveColor: const Color(0xFF174068),
    ),
  ];

  // 1. Logout
  LogoutModel? logoutModel;
  logout() {
    emit(LogoutLoadingState());
    DioHelper.PostData(url: logoutUrl)
        .then((value) {
      logoutModel = LogoutModel.fromJson(value.data);
      print(value.data);
      emit(LogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LogoutErrorState());
    });
  }


   // 2. bottom navy bar
  int currentIndex = 0;

  IconData icon = Icons.visibility_off;
  bool isVisible = false;

  void visible() {
    isVisible = !isVisible;
    icon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(ChangeBottomNavState());
  }

  List<Widget> screens = [
    const HomeTab(),
    const DoctorsTab(),
    const SearchView(),
    const HistoryTab(),
    const ProfileScreen()
  ];

  void changeBot(index, context) {
    emit(ChangeBotNavState());
    currentIndex = index;
    if (currentIndex == 1) {
      getAllDoctors();
    }
    if (currentIndex == 0) {
       getHomeData();
    }
    if (currentIndex == 3) {
      getAllAppointments();
    }
    if (currentIndex == 4) {
      getPatientProfileData();
      getAllAppointments();
    }
  }

  // 3. get all doctors



  // 3. get home data

  GetHomeDataModel? getHomeDataModel;
  void getHomeData()async{
    emit(GetHomeDataLoadingState());
    await DioHelper.getData(url: getHomeDataUrl).then((value){

      getHomeDataModel = GetHomeDataModel.fromJson(value.data);
      emit(GetHomeDataSuccessState());
    }).catchError((error) {

      emit(GetHomeDataErrorState());
    });

  }


  // 5. get all appointments

  GetAllAppointmentsModel? getAllAppointmentsModel;
  List<AppointmentsData> appointmentsData=[];

  void getAllAppointments() {
    emit(GetAllAppointmentsLoadingState());
    DioHelper.getData(url:getAllAppointmentsUrl).then((value) {

      getAllAppointmentsModel = GetAllAppointmentsModel.fromJson(value.data);
      for(var element in value.data['data']){
        appointmentsData.add(AppointmentsData.fromJson(element));
      }
      //print(loginModel?.data?.token);
      //print(loginModel?.data?.id);
      //print(appointmentsData);
      emit(GetAllAppointmentsSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(GetAllAppointmentsErrorState());
    });
  }


  // book appointment

  List<bool> isChoose = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];


  void changeColor(int index) {
    emit(ChangeTimeWidgetColorState());
    for (var i = 0; i < isChoose.length; i++) {
      i == index ? isChoose[i] = true : isChoose[i] = false;
    }
    emit(ChangeTimeWidgetColorState());
  }

  BookingModel? bookingModel;
  void bookAppointment({
    required String doctorId,
    required String startTime,
  }) {
    emit(BookingLoadingState());
    DioHelper.PostData(url: bookAppointmentUrl, data: {
      'doctor_id' : doctorId,
      'start_time': startTime,
    }).then((value) {
      bookingModel = BookingModel.fromJson(value.data);
      //print(loginModel?.token);
      //print(loginModel?.data?.id);
      //print(value.data);
      emit(BookingSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(BookingErrorState());
    });
  }


// 4. get patient profile data

PatientProfileModel? patientProfileModel;
void getPatientProfileData()async{
  emit(GetPatientProfileDataLoadingState());
  await DioHelper.getData(url: getPatientProfileDataUrl).then((value){
    //print(value.data);
    patientProfileModel = PatientProfileModel.fromJson(value.data);
    emit(GetPatientProfileDataSuccessState());
  }).catchError((error) {
    //print(error.toString());
    emit(GetPatientProfileDataErrorState());
  });

}

  GetAllDoctorModel? getAllDoctorModel;
void getAllDoctors()async{
  emit(GetAllDoctorsLoadingState());
  await DioHelper.getData(url: getAllDoctorsUrl).then((value){
    // print(value.data);
    getAllDoctorModel = GetAllDoctorModel.fromJson(value.data);
    emit(GetAllDoctorsSuccessState());
  }).catchError((error) {
    //print(error.toString());
    emit(GetAllDoctorsErrorState());
  });

}
  int counter = 0;
  var filterFormKey = GlobalKey<FormState>();

  // Home
  Future<List<CityModel>> getAllCities() async {
    try {
      final url = Uri.parse('$baseUrl/city/index');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data'];
        final cities = data
            .map<CityModel>((json) => CityModel.fromJson(json))
            .toList();
        return cities;
      } else {
        throw 'Failed to load cities. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load cities: $e';
    }
  }
  Future<List<GovernorateModel>> getAllGovernorates() async {
    try {
      final url = Uri.parse('$baseUrl/governrate/index');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data'];
        final governrates = data
            .map<GovernorateModel>((json) => GovernorateModel.fromJson(json))
            .toList();
        return governrates;
      } else {
        throw 'Failed to load governrates. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load governrates: $e';
    }
  }
  Future<List<SpecializationModel>> getAllSpecialization() async {
    try {
      final url = Uri.parse('$baseUrl/specialization/index');
      final response = await http.get(url,
          headers:
          {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken'
          });
      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> data = decodedBody['data'];
        final specializations = data
            .map<SpecializationModel>((json) => SpecializationModel.fromJson(json))
            .toList();
        return specializations;
      } else {
        throw 'Failed to load specializations. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to load specializations: $e';
    }
  }
  // This function is called when the radio is checked or unchecked.
  int groupValue = 0;
  void handleRadioListChanged(value) {
    groupValue = value;
    print(groupValue);
    emit(ChangeRadioState());
  }
  bool openCities = false;
  bool openGovernorate = false;
  bool openSpecialication = false;
  Icon cityStateIcon = Icon(Icons.add_sharp);
  Icon governorateStateIcon = Icon(Icons.add_sharp);
  Icon specialicationStateIcon = Icon(Icons.add_sharp);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CityModel? selectedFilterdCity ;
  GovernorateModel? selectedFilterdGovernorate ;
  SpecializationModel? selectedFilterdSpecialization ;
  bool cityFilterStatus = false ;
  bool governorateFilterStatus = false ;
  bool speciatizationFilterStatus = false ;
  void changeFilterCity(){
    openCities= !openCities;
    print(openCities);
    cityStateIcon = openCities ? Icon(Icons.remove_sharp) : Icon(Icons.add_sharp);
    emit(changeFilterCityState());
  }
  void changeFilterGovernorate(){
    openGovernorate= !openGovernorate;
    governorateStateIcon = openGovernorate ? Icon(Icons.remove_sharp) : Icon(Icons.add_sharp);
    emit(changeFilterGovernorateState());
  }
  void changeFilterSpecialication(){
    openSpecialication= !openSpecialication;
    specialicationStateIcon = openSpecialication ? Icon(Icons.remove_sharp) : Icon(Icons.add_sharp);
    emit(changeFilterSpecialicationState());
  }
  void showBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: ((context) =>
          Wrap(children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.filter_alt_outlined,color: Color(0xff174068),),
                        Text('FILTER', style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff174068),
                        ),),
                        Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.close)),
                      ],
                    ),
                    SizedBox(height: ScreenSize.screenHeight*0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('CITY',style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,

                        ),),
                        Spacer(),
                        TextButton(onPressed: (){}, child: Text(
                          'clear',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey.shade600
                        ),
                        )),
                        IconButton(onPressed: (){
                          changeFilterCity();
                        }, icon: cityStateIcon),

                      ],
                    ),
                    openCities == true ? FutureBuilder<List<CityModel>>(
                      future: getAllCities(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
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
                                Container(
                                  height:
                                  ScreenSize.screenHeight * 0.2,
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context,
                                          index) => buildCityItem(cities[index],context),
                                      separatorBuilder:
                                          (context, index) =>
                                          SizedBox(
                                            height: ScreenSize
                                                .screenHeight *
                                                0.001,
                                          ),
                                      itemCount: cities.length),
                                ),


                              ],
                            );
                          } else {
                            return SizedBox
                                .shrink(); // Placeholder widget if venues is null
                          }
                        }
                      },
                    ) : SizedBox.shrink(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('GOVERNORATE',style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,

                        ),),
                        Spacer(),
                        TextButton(onPressed: (){}, child: Text(
                          'clear',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey.shade600
                        ),
                        )),
                        IconButton(onPressed: (){
                          changeFilterGovernorate();
                        }, icon: governorateStateIcon),

                      ],
                    ),
                    openGovernorate == true ? FutureBuilder<List<GovernorateModel>>(
                      future: getAllGovernorates(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
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
                          final governorate = snapshot.data;
                          if (governorate != null) {
                            return Column(
                              children: [
                                Container(
                                  height:
                                  ScreenSize.screenHeight * 0.2,
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context,
                                          index) => buildGovernorateItem(governorate[index],context),
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
                          } else {
                            return SizedBox
                                .shrink(); // Placeholder widget if venues is null
                          }
                        }
                      },
                    ) : SizedBox.shrink(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('SPECIALIZATION',style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,

                        ),),
                        Spacer(),
                        TextButton(onPressed: (){}, child: Text(
                          'clear',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey.shade600
                        ),
                        )),
                        IconButton(onPressed: (){
                          changeFilterSpecialication();
                        }, icon: specialicationStateIcon),

                      ],
                    ),
                    openSpecialication == true ? FutureBuilder<List<SpecializationModel>>(
                      future: getAllSpecialization(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
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
                                Container(
                                  height:
                                  ScreenSize.screenHeight * 0.2,
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context,
                                          index) => buildSpecializationItem(specialization[index],context),
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
                            return SizedBox
                                .shrink(); // Placeholder widget if venues is null
                          }
                        }
                      },
                    ) : SizedBox.shrink(),
                  ],
                ),
              ),
            )
          ])),
    );
    emit(SuccessfulShowingBottomSheetState());
  }
  Widget buildCityItem(CityModel model ,context) => Container(
    height: ScreenSize.screenHeight*0.04,
    child: RadioListTile(
      title: Text(model.name,style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),),
      value: 1 ,
      contentPadding: EdgeInsets.zero,
      groupValue: groupValue,
      onChanged: (value) {
        handleRadioListChanged(value);
      },
      activeColor: defaultColor,
    ),
  );

  Widget buildGovernorateItem(GovernorateModel model ,context) => Container(
    height: ScreenSize.screenHeight*0.04,
    child: RadioListTile(
      title: Text(model.name,style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),),
      value: 1 ,
      contentPadding: EdgeInsets.zero,
      groupValue: groupValue,
      onChanged: (value) {
        handleRadioListChanged(value);
      },
      activeColor: defaultColor,
    ),
  );

  Widget buildSpecializationItem(SpecializationModel model ,context) => Container(
    height: ScreenSize.screenHeight*0.04,
    child: RadioListTile(
      title: Text(model.name,style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),),
      value: 1 ,
      contentPadding: EdgeInsets.zero,
      groupValue: groupValue,
      onChanged: (value) {
        handleRadioListChanged(value);
      },
      activeColor: defaultColor,
    ),
  );

  Widget bottomSheet(context,) {
    return Wrap(children: [
      Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.filter_alt_outlined,color: Color(0xff174068),),
                  Text('FILTER', style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff174068),
                  ),),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.close)),
                ],
              ),
              SizedBox(height: ScreenSize.screenHeight*0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('CITY',style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,

                  ),),
                  Spacer(),
                  TextButton(onPressed: (){}, child: Text(
                    'clear',style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey.shade600
                  ),
                  )),
                  IconButton(onPressed: (){
                    changeFilterCity();
                  }, icon: cityStateIcon),

                ],
              ),
              openCities == true ? FutureBuilder<List<CityModel>>(
                future: getAllCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Column(
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
                          Container(
                            height:
                            ScreenSize.screenHeight * 0.2,
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context,
                                    index) => buildCityItem(cities[index],context),
                                separatorBuilder:
                                    (context, index) =>
                                    SizedBox(
                                      height: ScreenSize
                                          .screenHeight *
                                          0.001,
                                    ),
                                itemCount: cities.length),
                          ),


                        ],
                      );
                    } else {
                      return SizedBox
                          .shrink(); // Placeholder widget if venues is null
                    }
                  }
                },
              ) : SizedBox.shrink(),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('GOVERNORATE',style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,

                  ),),
                  Spacer(),
                  TextButton(onPressed: (){}, child: Text(
                    'clear',style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey.shade600
                  ),
                  )),
                  IconButton(onPressed: (){
                    changeFilterGovernorate();
                  }, icon: governorateStateIcon),

                ],
              ),
              openGovernorate == true ? FutureBuilder<List<GovernorateModel>>(
                future: getAllGovernorates(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Column(
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
                    final governorate = snapshot.data;
                    if (governorate != null) {
                      return Column(
                        children: [
                          Container(
                            height:
                            ScreenSize.screenHeight * 0.2,
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context,
                                    index) => buildGovernorateItem(governorate[index],context),
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
                    } else {
                      return SizedBox
                          .shrink(); // Placeholder widget if venues is null
                    }
                  }
                },
              ) : SizedBox.shrink(),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('SPECIALIZATION',style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,

                  ),),
                  Spacer(),
                  TextButton(onPressed: (){}, child: Text(
                    'clear',style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey.shade600
                  ),
                  )),
                  IconButton(onPressed: (){
                    changeFilterSpecialication();
                  }, icon: specialicationStateIcon),

                ],
              ),
              openSpecialication == true ? FutureBuilder<List<SpecializationModel>>(
                future: getAllSpecialization(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Column(
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
                          Container(
                            height:
                            ScreenSize.screenHeight * 0.2,
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context,
                                    index) => buildSpecializationItem(specialization[index],context),
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
                      return SizedBox
                          .shrink(); // Placeholder widget if venues is null
                    }
                  }
                },
              ) : SizedBox.shrink(),
            ],
          ),
        ),
      )
    ]);
  }
  void changeState(){
    emit(ChangeState());
  }



}
