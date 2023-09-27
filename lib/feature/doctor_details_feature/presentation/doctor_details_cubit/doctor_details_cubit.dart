
import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/feature/doctor_details_feature/data/appoint_model/appoint_model.dart';
import 'package:clinic/feature/doctor_details_feature/data/details_doctor_model/details_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  static DoctorDetailsCubit get(context) => BlocProvider.of(context);

  DoctorDetailsModel? doctorDetailsModel ;
  AppointModel? appointModel ;

  List<int> lastTime = [];
   int? startDate;
   int? endDate ;

  getDetails({required String doctorId})async{
    emit(GetDetailsDoctorLoadingState());
    DioHelper.getData(
      url: '/doctor/show/${doctorId}',
    ).then((value) {
      doctorDetailsModel = DoctorDetailsModel.fromJson(value.data);
       startDate = int.parse(doctorDetailsModel!.data!.startTime!.split(':')[0]);
       endDate = int.parse(doctorDetailsModel!.data!.endTime!.split(':')[0]);

      for (int i = startDate! ; i <= endDate! ; i++ ){
        lastTime.add(i);
      }

      print(lastTime);
      initFalse();
      emit(GetDetailsDoctorSuccessState(doctorDetailsModel!));

    })
        .catchError((error) {
      print(error.toString());
      emit(GetDetailsDoctorErrorState(error.toString()));
    });
  }


  DateTime? firstDate;
  String? splitStartDate;
  Future<void> selectStartDate(BuildContext context) async {
    DateTime? selectedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (selectedStartDate != null) {
      if (firstDate == null) {
        firstDate = selectedStartDate;
        splitStartDate = '${firstDate?.year}/${firstDate?.month}/${firstDate?.day}';
        emit(DateChange());
        print(splitStartDate);
      }
      else{
        firstDate = selectedStartDate;
        splitStartDate = '${firstDate?.year}/${firstDate?.month}/${firstDate?.day}';
        print(splitStartDate);
      }
    }


  }

  List<bool> isTime=[];

  initFalse(){
    for(int i=0; i <lastTime.length ; i++){
      isTime.add(false) ;
    }
    print(isTime);
  }
  int oldIndex =0  ;
  changeColor(int index){

        if(index != oldIndex)
        {
          print(index);
          isTime[index] = !isTime[index];
          oldIndex = index ;
          emit(ChangeTimeColor());
        }else{
          print(index);
          isTime[index] = !isTime[index];
          oldIndex = index ;
          emit(ChangeTimeColor());
        }
  }



  postAppoint({required String doctorId})async{
    emit(AppointLoadingState());
    DioHelper.PostData(
      url: '/appointment/store',
      data: {
        'doctor_id':doctorId,
        'start_time':'${splitStartDate}-${lastTime[oldIndex]}'

      }
    ).then((value) {
      appointModel = AppointModel.fromJson(value.data);
      emit(AppointSuccessState(appointModel!));

    })
        .catchError((error) {
      print(error.toString());
      emit(AppointErrorState(error.toString()));
    });
  }
}

