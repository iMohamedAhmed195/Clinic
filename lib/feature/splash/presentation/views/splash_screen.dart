import 'package:clinic/feature/splash/presentation/views/widgets/splash_screen_body.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xff174068),
        body: SplashViewBody()
    );
  }
}