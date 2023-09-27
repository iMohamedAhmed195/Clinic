import 'package:bloc/bloc.dart';
import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/feature/profile_history_feature/profile_history_cubit/history_model/history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_history_state.dart';

class ProfileHistoryCubit extends Cubit<ProfileHistoryState> {
  ProfileHistoryCubit() : super(ProfileHistoryInitial());

 static ProfileHistoryCubit get(context) => BlocProvider.of(context);

  HistoryModel? historyModel ;

  void getHistoryData()async{
    emit(ProfileHistoryLoading());
    await DioHelper.getData(
        url: '/appointment/index',
    )
        .then((value){
      historyModel = HistoryModel.fromJson(value.data);
      emit(ProfileHistorySuccess());
    }).catchError((error) {

      emit(ProfileHistoryError());
    });

  }
}
