import 'package:clinic/core/remote/DioHelper.dart';
import 'package:clinic/core/services/bloc_observer.dart';

import 'package:clinic/core/services/network/local/cache_helper.dart';
import 'package:clinic/feature/home/presentation/cubit/home_cubit.dart';
import 'package:clinic/feature/login/presentation/cubit/login_cubit.dart';
import 'package:clinic/feature/profile_feature/cubit/profile_cubit.dart';
import 'package:clinic/feature/register/presentation/cubit/register_cubit.dart';
import 'package:clinic/feature/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegisterCubit(),
              ),
              BlocProvider(
                create: (context) => LoginCubit(),
              ),
              BlocProvider(
                create: (context) => HomeCubit(),
              ),
              BlocProvider(
                create: (context) => ProfileCubit(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
              ),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            ),
          );
        }
    );
  }
}

