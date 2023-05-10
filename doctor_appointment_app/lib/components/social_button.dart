import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';

import '../utils/UiUtils.dart';
import '../utils/labelKeys.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.social}) : super(key: key);

  final String social;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        side: const BorderSide(width: 1, color: Colors.black),
      ),
      onPressed: () {
         UiUtils.showCustomSnackBar(
                        context: context,
                        errorMessage: UiUtils.getTranslatedLabel(
                            context, incomingKey),
                        backgroundColor: Theme.of(context).iconTheme.color!,
                      );
      },
      child: SizedBox(
        width: Config.widthSize * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/$social.png',
              width: 40,
              height: 40,
            ),
            Text(
              social.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
