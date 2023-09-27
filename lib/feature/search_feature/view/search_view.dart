import 'package:clinic/core/constants/assets.dart';
import 'package:clinic/feature/doctor_details_feature/presentation/view/doctor_details_view.dart';
import 'package:clinic/feature/search_feature/search_cubit/search_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SearchCubit(),
  child: BlocConsumer<SearchCubit, SearchState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = SearchCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),

                      blurRadius: 10,
                      offset: Offset(0, 10)
                    )
                  ]
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                  prefixIcon: Icon(Icons.arrow_back),
                  border : InputBorder.none,

                ),
                controller: cubit.searchController,

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xff174068)),
                    child: MaterialButton(
                      onPressed: () {
                        cubit.getSearchData();
                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ConditionalBuilder(
                condition: state is SearchSuccess || cubit.searchModel?.data == null,
                builder: (context){
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context , index){
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorDetailsView(doctorId: cubit.searchModel!.data![index].id.toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        width:  MediaQuery.sizeOf(context).width * 0.2,
                                        height: MediaQuery.sizeOf(context).width * 0.15,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration:  BoxDecoration(
                                            borderRadius:BorderRadius.circular(10)
                                        ),
                                        child:Image(image: NetworkImage(cubit.searchModel!.data![index].photo! ?? '' ,))

                                    )
                                  ],),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.searchModel!.data![index].name! ?? '',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),

                                      Text(
                                        cubit.searchModel!.data![index].degree! ?? '',
                                        style: TextStyle(
                                            color: Color(0xff030E19).withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.searchModel?.data?.length ?? 0,
                    ),
                  );
                },
                fallback: (context) => Center(child: CircularProgressIndicator(),)
            )
            
          ],
        ),
      ),
    );
  },
),
);
  }
}
