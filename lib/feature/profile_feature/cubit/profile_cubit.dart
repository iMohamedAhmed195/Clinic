import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/core/remote/endpoints.dart';
import 'package:clinic/feature/home/data/models/get_all_appointments_model.dart';
import 'package:clinic/feature/profile_feature/cubit/profile_states.dart';
import 'package:clinic/feature/profile_feature/profile_model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class ProfileCubit extends Cubit<ProfileStates> {

  ProfileCubit() : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  // Profile
  var profileNameController = TextEditingController();
  var profileEmailController = TextEditingController();
  var profilePhoneController = TextEditingController();
  var profileFormKey = GlobalKey<FormState>();

  int groupValue = 0;
  int gender = 0;
  void handleRadioListChanged(value) {
    groupValue = value;
    gender= groupValue-1;
    print(groupValue);
    emit(ChangeRadioState());
  }

  GetAllAppointmentsModel? getAllAppointmentsModel;

  void getAllAppointments() {
    emit(GetAllAppointmentsLoadingState());
    DioHelper.getData(url:getAllAppointmentsUrl).then((value) {

      getAllAppointmentsModel = GetAllAppointmentsModel.fromJson(value.data);
      emit(GetAllAppointmentsSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(GetAllAppointmentsErrorState());
    });
  }

  ProfileModel? profileModel;

  void getUser() {
    emit(LoadingProfileState());
    DioHelper.getData(url:'/user/profile').then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessfulProfileState());
    }).catchError((error) {
      //print(error.toString());
      emit(FailedProfileState());
    });
  }
}
