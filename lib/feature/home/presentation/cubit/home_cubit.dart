import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../views/account_tab.dart';
import '../views/doctors_tab.dart';
import '../views/history_tab.dart';
import '../views/home_tab.dart';
import '../views/search_tab.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);


   // 1. bottom navy bar

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
    const SearchTab(),
    const HistoryTab(),
    const AccountTab()
  ];

  void changeBot(index, context) {
    emit(ChangeBotNavState());
    currentIndex = index;
  }




// // 4. get doctor profile data
  //
  // GetDoctorProfileDataModel? getDoctorProfileDataModel;
  // void getDoctorProfileData(id)async{
  //   emit(GetDoctorProfileDataLoadingState());
  //   await DioHelper.getData(url: "$getDoctorProfileDataUrl" + "$id").then((value){
  //     print(value.data);
  //     getDoctorProfileDataModel = GetDoctorProfileDataModel.fromJson(value.data);
  //     emit(GetDoctorProfileDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetDoctorProfileDataErrorState());
  //   });
  //
  // }



}
