import 'package:doctor_appointment_app/components/login_form.dart';
import 'package:doctor_appointment_app/components/sign_up_form.dart';
import 'package:doctor_appointment_app/utils/hiveBoxKeys.dart';
import 'package:doctor_appointment_app/utils/labelKeys.dart';
import 'package:flutter/material.dart';

import '../styles/widgets/social_sign_up.dart';
import '../utils/UiUtils.dart';
import '../utils/config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    //build login text field
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(child: Image.asset("assets/logo.png"),),
            Config.spaceSmall,

            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/logo.png"),
              ),
            ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //     child: Column(
            //       children: [
            //         const Text(
            //           "ASM",
            //           style: TextStyle(
            //             fontSize: 24,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Text(
            //           // AppText.enText['welcome_text']!,
            //           // welcomeKey,
            //           UiUtils.getTranslatedLabel(context, introKey),
            //           style: const TextStyle(
            //             fontSize: 12,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Text(
            //   UiUtils.getTranslatedLabel(context, welcomeKey),
            //   style: const TextStyle(
            //     fontSize: 36,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Config.spaceSmall,
            Text(
              isSignIn
                  ? UiUtils.getTranslatedLabel(context, signInTextKey)
                  : UiUtils.getTranslatedLabel(context, registerKey),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            isSignIn ? const LoginForm() : const SignUpForm(),
            Config.spaceSmall,
            isSignIn
                ? Center(
                    child: GestureDetector(
                      child: Text(
                        UiUtils.getTranslatedLabel(context, forgetpasswordKey),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        UiUtils.showCustomSnackBar(
                          context: context,
                          errorMessage:
                              UiUtils.getTranslatedLabel(context, incomingKey),
                          backgroundColor: Theme.of(context).iconTheme.color!,
                        );
                      },
                    ),
                  )
                : Container(),
            const Spacer(),
            Center(
              child: Text(
                UiUtils.getTranslatedLabel(context, socialsKey),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Config.spaceSmall,
            const SocialSignUp(),

            Config.spaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isSignIn
                      ? UiUtils.getTranslatedLabel(context, youDontHaveAccountKey)
                      : UiUtils.getTranslatedLabel(context, alreadyregisteredKey),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignIn = !isSignIn;
                    });
                  },
                  child: Text(
                    isSignIn
                        ? UiUtils.getTranslatedLabel(context, signUpKey)
                        : UiUtils.getTranslatedLabel(context, loginKey),
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
