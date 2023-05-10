// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../constants/Color.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.foreColor = Colors.white,
    this.backColor = Colors.blue,
    required this.height,
    required this.width,
    required this.title,
    this.press,
    this.isDraft = false,
    this.isBtnWithIcon = false,
    this.icon = Icons.abc,
    this.style,
    this.disable = false,
  });
  Color foreColor;
  Color backColor;
  final double height;
  final double width;
  final String title;
  final Function()? press;
  final bool isDraft;
  final IconData icon;
  final bool isBtnWithIcon;
  final bool disable;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (isDraft) {
      foreColor = blueColor;
      backColor = whiteColor;
    }
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: !disable?foreColor:Colors.grey.shade500,
          backgroundColor: !disable?backColor:Colors.grey.shade300,
          elevation: !isDraft ? 4.0 : 0,
          minimumSize: Size(
            width,
            height,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
          alignment: Alignment.center,
        ),
        onPressed: !disable ? press : () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBtnWithIcon)
              Icon(
                icon,
                size: 20,
              ),
            Text(
              title,
              style: style,
            ),
          ],
        ));
  }
}
