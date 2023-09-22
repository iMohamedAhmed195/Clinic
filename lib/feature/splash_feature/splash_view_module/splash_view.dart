
import 'package:clinic/feature/splash_feature/splash_view_module/Widget/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff5A55CA),
      body: SplashViewBody()
    );
  }
}
