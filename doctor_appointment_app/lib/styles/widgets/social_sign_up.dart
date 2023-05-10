import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'social_icon.dart';

class SocialSignUp extends StatefulWidget {
  const SocialSignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialSignUp> createState() => _SocialSignUpState();
}

class _SocialSignUpState extends State<SocialSignUp> {
  bool isiOs = false;

  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      isiOs = true;
      print(defaultTargetPlatform == TargetPlatform.android);
      print(defaultTargetPlatform == TargetPlatform.iOS);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.fromLTRB(size.width * 0.01, 0, size.width * 0.01, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                visible: isiOs,
                child: const Expanded(
                  flex: 1,
                  child: SocialIcon(
                    SocialName: " Apple",
                    iconSrc: "assets/svg/apple.svg",
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SocialIcon(
                  SocialName: " Google",
                  iconSrc: "assets/svg/google.svg",
                ),
              ),
              const Expanded(
                flex: 1,
                child: SocialIcon(
                  SocialName: " Facebook",
                  iconSrc: "assets/svg/facebook.svg",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
