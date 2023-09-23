import 'package:clinic/core/services/app_reouter.dart';
import 'package:clinic/core/services/bloc_observer.dart';
import 'package:clinic/core/services/dio_helper.dart';
import 'package:clinic/core/services/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

