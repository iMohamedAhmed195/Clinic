import 'package:flutter/material.dart';

class TextAppointmentSection extends StatelessWidget {
  const TextAppointmentSection({super.key, required this.textSection, required this.textDate, required this.textAppointmentId, required this.textStatus,});

  final String textSection;
  final String textDate;
  final String textAppointmentId;
  final String textStatus;

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
                'date',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                textDate,
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
                'appointment id',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                textAppointmentId,
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
                'status',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                textStatus,
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
