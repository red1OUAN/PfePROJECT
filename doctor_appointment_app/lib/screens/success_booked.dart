import 'package:doctor_appointment_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/Color.dart';
import '../styles/widgets/CustomButton.dart';
import '../utils/UiUtils.dart';
import '../utils/labelKeys.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: 
              CustomButton(
                height: 50,
                title: UiUtils.getTranslatedLabel(context, backHomeKey),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                width: double.infinity,
                foreColor: Colors.white,
                backColor: blueColor,
                press: ()=>Navigator.of(context).pushNamed('main'),),
              // Button(
              //   width: double.infinity,
              //   title: 'Back to Home Page',
              //   onPressed: () => Navigator.of(context).pushNamed('main'),
              //   disable: false,
              // ),
            )
          ],
        ),
      ),
    );
  }
}
