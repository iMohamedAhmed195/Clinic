import 'package:clinic/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap});

 final  VoidCallback onTap;
 final  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Styles.kPrimaryColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        width: double.infinity,
        height: 60.h,
        child: Center(
            child: Text(text, style: GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400),),
      ),
    )
    );
  }
}
