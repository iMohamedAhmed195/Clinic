import 'package:clinic/core/constants/styles.dart';
import 'package:clinic/feature/signup_features/presentation/view/widget/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.kColor,
      body: SignUpBody(),
    );
  }
}
