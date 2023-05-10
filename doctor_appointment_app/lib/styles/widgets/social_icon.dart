import 'package:doctor_appointment_app/utils/labelKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/Color.dart';
import '../../utils/UiUtils.dart';

class SocialIcon extends StatelessWidget {
  final String? iconSrc;
  final String? SocialName;
  const SocialIcon({
    Key? key,
    this.iconSrc,
    this.SocialName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UiUtils.showCustomSnackBar(
          context: context,
          errorMessage: UiUtils.getTranslatedLabel(context, incomingKey),
          backgroundColor: Theme.of(context).iconTheme.color!,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: SvgPicture.asset(
                        iconSrc!,
                        height: 20,
                        width: 20,
                      ),
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.middle),
                  TextSpan(
                    text: " ${SocialName!}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
