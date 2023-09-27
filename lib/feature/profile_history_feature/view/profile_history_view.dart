import 'package:clinic/core/constants/styles.dart';
import 'package:clinic/feature/home/data/models/get_all_appointments_model.dart';
import 'package:clinic/feature/profile_history_feature/profile_history_cubit/profile_history_cubit.dart';
import 'package:clinic/feature/profile_history_feature/view/widget/text_appointment_details.dart';
import 'package:clinic/feature/profile_history_feature/view/widget/text_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHistoryView extends StatelessWidget {
  const ProfileHistoryView({super.key, required this.getAllAppointmentsModel, required this.index});

  final GetAllAppointmentsModel getAllAppointmentsModel;
  final int index ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileHistoryCubit(),
      child: BlocConsumer<ProfileHistoryCubit, ProfileHistoryState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = ProfileHistoryCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.35,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Styles.kPrimaryColor),
                              child: MaterialButton(
                                onPressed: () {},
                                child: const Text(
                                  'PRINT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                       TextDetailsSection(
                        textSection: 'Doctor details',
                        textName:getAllAppointmentsModel.data![index].doctor!.name! ,
                        textLocation: getAllAppointmentsModel.data![index].doctor!.address! ,
                        textEmail: getAllAppointmentsModel.data![index].doctor!.email! ,
                        textPhone: getAllAppointmentsModel.data![index].doctor!.phone! ,
                      ),
                       TextDetailsSection(
                        textSection: 'Patient details',
                        textName: getAllAppointmentsModel.data![index].patient!.name! ,
                        textEmail: getAllAppointmentsModel.data![index].patient!.email! ,
                        textPhone:getAllAppointmentsModel.data![index].patient!.phone! ,
                      ),
                       TextAppointmentSection(
                        textSection: 'Appointment details',
                        textDate: getAllAppointmentsModel.data![index].appointmentTime! ,
                        textAppointmentId:getAllAppointmentsModel.data![index].id.toString() ,
                        textStatus: getAllAppointmentsModel.data![index].status! ,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          color: Styles.kPrimaryColor,
                          width: double.infinity,
                          height: 45,
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '\$ ${getAllAppointmentsModel.data![index].appointmentPrice!}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
