import 'package:bloc/bloc.dart';
import 'package:clinic/core/services/dio_helper.dart';
import 'package:clinic/feature/doctor_details_feature/data/details_doctor_model/details_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  static DoctorDetailsCubit get(context) => BlocProvider.of(context);

  DoctorDetailsModel? doctorDetailsModel ;

  List<int> lastTime = [];
   int? startDate;
   int? endDate ;

  getDetails()async{
    emit(GetDetailsDoctorLoadingState());
    DioHelper.getData(
      url: '/doctor/show/3',
      token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3ZjYXJlLmludGVncmF0aW9uMjUuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjk1NDY4MTY4LCJleHAiOjE2OTU0NzE3NjgsIm5iZiI6MTY5NTQ2ODE2OCwianRpIjoiSms2Ujl4Wnh1bFJ2RXVPVSIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.SegJeEtgbA-g7H3Yy9VjX8K1GtdlrbhLCv3CItJ3QWM'
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

  //bool isTime = false ;

  List<bool> isTime=[];

  initFalse(){
    for(int i=0; i <lastTime.length ; i++){
      isTime.add(false) ;
    }
    print(isTime);
  }
  changeColor( int index){

      isTime[index]=!isTime[index];
      emit(ChangeTimeColor());
  }
}
