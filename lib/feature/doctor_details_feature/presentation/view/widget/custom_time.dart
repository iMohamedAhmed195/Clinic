import 'package:flutter/material.dart';

class CustomTime extends StatelessWidget {
  const CustomTime({super.key ,required this.time  ,required this.isTime  });
  final String time ;

  final bool isTime ;
  @override
  Widget build(BuildContext context) {
    return   Container(
      width: MediaQuery.sizeOf(context).width * 0.3,
      height: MediaQuery.sizeOf(context).height * 0.05,
      decoration: BoxDecoration(
          color: isTime ? const Color(0xff174068) : const Color(0xff030E19).withOpacity(0.1),
          borderRadius: BorderRadius.circular(24)
      ),
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
                color: isTime ? Colors.white : const Color(0xff030E19).withOpacity(0.7),
                fontSize: 14,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),

    );
  }
}