// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
   CustomField({
    Key? key,
    required this.validator,
    required this.myController,
    required this.isText,
    required this.isEmailOrPhone,
    required this.hintText,
    this.icon,
  }) : super(key: key);

  final String? Function(String? p1)? validator;
  final TextEditingController? myController;
  bool? isText = true;
  final bool isEmailOrPhone;
  bool _passwordVisible = false;

  final String? hintText;
  final IconData? icon;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  void initState() {
    super.initState();
    widget._passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.9,
          child: TextFormField(
            validator: widget.validator,
            controller: widget.myController,
            obscuringCharacter: '*',
            obscureText: widget.isText!
                ? widget._passwordVisible
                : !widget._passwordVisible,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              hintText: widget.hintText,
              prefixIcon: widget.isEmailOrPhone
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.04, right: size.width * 0.01),
                      child: Icon(
                        widget.icon,
                      ),
                    ),
              suffixIcon: widget.isText!
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: IconButton(
                          icon: widget._passwordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              widget._passwordVisible =
                                  !widget._passwordVisible;
                            });
                          }),
                    ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.08),
      ],
    );
  }
}
