import 'package:clinic/core/widget/custom_text_sec_login.dart';
import 'package:flutter/material.dart';

class RequestSentView extends StatelessWidget {
  const RequestSentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              const TextSection(
                header: 'Request sent!',
                para: 'A request to reset your password has been issued, we’ll reply to you soon!',),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff174068)),
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
