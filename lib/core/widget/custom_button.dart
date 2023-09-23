import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key , required this.function ,required this.textButton});
    final String textButton;
    final VoidCallback function ;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xff5A55CA)),
      child: MaterialButton(
        onPressed:function,
        child:  Text(
          textButton,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
