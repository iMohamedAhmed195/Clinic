import 'package:clinic/feature/home/presentation/cubit/home_cubit.dart';
import 'package:clinic/feature/home/presentation/views/widgets/profile_tile.dart';
import 'package:clinic/feature/profile_history_feature/view/profile_history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: BlocProvider(
          create: (context) => HomeCubit()..getAllAppointments(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              return cubit.getAllAppointmentsModel?.data?.isEmpty ?? true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "               No Appointments Yet!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "All Appointments",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileHistoryView(
                                                  getAllAppointmentsModel: cubit
                                                      .getAllAppointmentsModel!,
                                                  index: index,
                                                )));
                                  },
                                  child: ProfileTile(
                                    data: cubit
                                        .getAllAppointmentsModel!.data![index],
                                  )),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 1.h,
                                  ),
                              itemCount:
                                  cubit.getAllAppointmentsModel!.data!.length),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
