part of 'doctor_details_cubit.dart';

@immutable
abstract class DoctorDetailsState {}

class DoctorDetailsInitial extends DoctorDetailsState {}
class DateChange extends DoctorDetailsState {}
class ChangeTimeColor extends DoctorDetailsState {}

class GetDetailsDoctorLoadingState extends DoctorDetailsState {}
class GetDetailsDoctorSuccessState extends DoctorDetailsState {
  final  DoctorDetailsModel doctorDetailsModel ;

  GetDetailsDoctorSuccessState(this.doctorDetailsModel);
}
class GetDetailsDoctorErrorState extends DoctorDetailsState {
  final String error;

  GetDetailsDoctorErrorState(this.error);
}
class AppointLoadingState extends DoctorDetailsState {}
class AppointSuccessState extends DoctorDetailsState {
  final  AppointModel appointModel ;

  AppointSuccessState(this.appointModel);
}
class AppointErrorState extends DoctorDetailsState {
  final String error;

  AppointErrorState(this.error);
}
