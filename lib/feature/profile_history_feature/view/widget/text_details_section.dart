import 'package:flutter/material.dart';

class TextDetailsSection extends StatelessWidget {
  const TextDetailsSection({super.key, required this.textSection, required this.textName,  this.textLocation, required this.textEmail, required this.textPhone});

  final String textSection;
  final String textName;
  final String? textLocation;
  final String textEmail;
  final String textPhone;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
          child: Text(
            textSection,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
          child: Row(
            children: [
              const Text(
                'name',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                textName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
          child: Row(
            children: [
              textLocation != null ?   Text(
          'location',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
          ): SizedBox(width: 2,),

              const Spacer(),
              textLocation != null ?  Text(
                textLocation!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ) : SizedBox(width: 2,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
          child: Row(
            children: [
              const Text(
                'email',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                textEmail,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
          child: Row(
            children: [
              const Text(
                'phone',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                textPhone,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
