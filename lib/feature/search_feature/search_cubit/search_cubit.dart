import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/feature/search_feature/search_model/searcg_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel?  searchModel;
  var searchController = TextEditingController() ;
  void getSearchData()async{
    emit(SearchLoading());
    await DioHelper.getData(
        url: '/doctor/doctor-search',
      query: {
          'name': searchController.text
      }
    )
        .then((value){

      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error) {

      emit(SearchError());
    });

  }
}
