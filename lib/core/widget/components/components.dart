import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget TextFieldComponent({
  required TextEditingController controller,
  TextInputType? keyType,
  required String label,
  Icon? picon,
  onTap,
  //required onChanged,
  TextStyle? labelStyle,
  validator,
  onChanged,
  IconButton? sicon,
  bool isPassword = false,
  bool showError = false,

  //onSubmit,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyType,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //onChanged: onChanged,
      //onFieldSubmitted: onSubmit,
      style: TextStyle(
        color: Colors.black,
      ),

      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        //label: label,
        labelStyle: labelStyle,
        focusColor: defaultColor,
        hoverColor: defaultColor,
        prefixIcon: picon,
        errorText: showError ? null : null,
        suffixIcon: sicon != null ? sicon : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: defaultColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: defaultColor,
            width: 2.0,
          ),
        ),
      ),
    );
Widget defaultButton({
  required String text,
  required onpressed,
  double? width_,
}) =>
    Container(
      width: width_ != null ? width_ : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: defaultColor,
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 17
          ),
        ),
        onPressed: onpressed,
      ),
    );
Widget smalldefaultButton({
  required String text,
  required onpressed,
  required color,
  required context,
  textColor,
}) =>
    Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: MaterialButton(
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        onPressed: onpressed,
      ),
    );
Widget defaultTextButton({
  required color,
  required String text,
  required onpressed,
  double? textFontSize,
}) =>
    TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: textFontSize!=null ? textFontSize : 14,
          fontFamily:
          'assets/fonts/IBMPlexArabic/IBMPlexSansArabic-SemiBold.ttf',
        ),
      ),
    );

Widget normalButton({
  required String text,
  required onPressed,
}) =>
    Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        // gradient: onPressed != null ? gradient : disabledGradient,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.blue),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
        onPressed: onPressed,
      ),
    );

Widget SmallButton({
  required onPressed,
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 55,
      height: 30.0,
      decoration: BoxDecoration(
        color: Color(0xffF6F8F9),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff70798C),
          ),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    ),
  );
}

Widget buildValidatorContainer({
  required String content,
}) {
  return Container(
    padding: EdgeInsets.all(5.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: defaultColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        Container(
          height: 20.0,
          width: 20.0,
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 15.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xffFA5457),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              content,
              maxLines: 2,
              style: TextStyle(
                color: Color(0xffFA5457),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Alert(content, context) => AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  content: Container(
    height: MediaQuery.of(context).size.height * 0.2,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            style: TextStyle(
              color: defaultColor,
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          smalldefaultButton(
            context: context,
            color: defaultColor,
            onpressed: () {
              Navigator.pop(context);
            },
            text: 'Ok',
          ),
        ],
      ),
    ),
  ),
);
double height(context, double num) => MediaQuery.of(context).size.height * num;

double width(context, double num) => MediaQuery.of(context).size.width * num;

ShaderMask iconSh(icon, {double? size}) => ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => const LinearGradient(
        colors: <Color>[
          Color.fromRGBO(27, 200, 234, 1),
          Color.fromRGBO(194, 37, 104, 1),
        ],
      ).createShader(bounds),
      child: Icon(
        icon,
        size: size,
      ),
    );

buildSnackBar(String? message, context, duration) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

Color defaultColor = const Color(0xff174068);

void navigateTo(Widget, context) => Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: Widget,
          );
        },
      ),
    );

void navigateAndFinish(Widget, context) => Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: Widget,
          );
        },
      ),
      (route) => false,
    );

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

LinearGradient gradient = LinearGradient(
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  colors: <Color>[
    Colors.blue.shade200,
    Colors.blue.shade300,
    Colors.blue.shade400,
    Colors.blue.shade500,
    Colors.blue.shade600,
    Colors.blue.shade700,
    Colors.blue.shade800,
  ],
);
LinearGradient gradient2 = const LinearGradient(
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  colors: <Color>[
    Color.fromRGBO(27, 200, 234, 1),
    Color.fromRGBO(194, 37, 104, 1),
  ],
);

ShaderMask shadeMask(text, style) => ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => LinearGradient(
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
        colors: <Color>[
          Colors.blue.shade300,
          Colors.blue.shade400,
          Colors.blue.shade500,
          Colors.blue.shade600,
          Colors.blue.shade700,
          Colors.blue.shade800,
          Colors.blue.shade900,
        ],
      ).createShader(rect),
      child: Text(
        text,
        style: style,
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  TextInputAction? action,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String? label,
  String? hint,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  int maxLines = 1,

  // ignore: use_function_type_syntax_for_parameters
}) =>
    TextFormField(
      // onTap: () {
      //   onTap!();
      // },
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      textInputAction: action,
      maxLines: maxLines,
      enabled: isClickable,
      //style: GoogleFonts.cairo(),
      // onFieldSubmitted: (s) {
      //   onSubmit!(s);
      // },
      onChanged: (s) {
        //onChange!(s);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        //errorStyle: GoogleFonts.cairo(),
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF091E4A),
            fontWeight: FontWeight.w400),
        //hintStyle: GoogleFonts.cairo(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),

          /* borderSide: const BorderSide(
            color: MyColors.basColor,
            width: 2.0,
          ),*/
        ),
        labelText: label,
        //labelStyle: GoogleFonts.cairo(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
