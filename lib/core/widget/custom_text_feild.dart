import 'package:clinic/core/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   const CustomTextField({super.key ,required this.hintText , required this.controller, required this.obSecure, required this.inputType, required this.textValidate});
   final  String hintText ;
   final TextEditingController controller ;
   final  bool obSecure  ;
   final TextInputType inputType ;
   final String textValidate ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, bottom: 30),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return textValidate;
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                enabledBorder: buildOutlineInputBorder(),
                focusedBorder: buildOutlineInputBorder(),
                hintText: hintText),
            obscureText: obSecure,
            keyboardType: inputType,
            controller: controller,
          ),
        )
      ],
    );
  }
  buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Styles.kTextField),
        borderRadius: BorderRadius.circular(6));
  }
}
