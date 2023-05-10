// ignore_for_file: use_build_context_synchronously

import 'package:doctor_appointment_app/main.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:doctor_appointment_app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/Color.dart';
import '../styles/widgets/CustomButton.dart';
import '../styles/widgets/CustomField.dart';
import '../utils/UiUtils.dart';
import '../utils/labelKeys.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomField(
            validator: (val) {
              if (val!.isEmpty) {
                return UiUtils.getTranslatedLabel(context, usernameRequireKey);
              }
              return null;
            },
            myController: _nameController,
            isText: true,
            hintText: UiUtils.getTranslatedLabel(context, usernameKey),
            icon: Icons.person_outlined,
            isEmailOrPhone: false,
          ),
          CustomField(
            validator: (val) {
              if (val!.isEmpty) {
                return UiUtils.getTranslatedLabel(context, emailRequireKey);
              }
              if (!val.contains(RegExp(EmailPattern))) {
                return UiUtils.getTranslatedLabel(
                    context,emailErrorKey);
              }
              return null;
            },
            myController: _emailController,
            isText: true,
            hintText: UiUtils.getTranslatedLabel(context, emailKey),
            icon: Icons.email_outlined,
            isEmailOrPhone: false,
          ),
          CustomField(
            validator: (val) {
              if (val!.isEmpty) {
                return UiUtils.getTranslatedLabel(
                    context,passwordRequireKey);
              }
              if (val.length < 6) {
                return UiUtils.getTranslatedLabel(
                    context, passwordConditionKey);
              }

              return null;
            },
            myController: _passController,
            isText: false,
            hintText: UiUtils.getTranslatedLabel(context, passwordKey),
            icon: Icons.lock_outlined,
            isEmailOrPhone: false,
          ),
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomButton(
                  height: 50,
                  title: UiUtils.getTranslatedLabel(context, signUpKey),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  width: double.infinity,
                  foreColor: Colors.white,
                  backColor: blueColor,
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      final userRegistration = await DioProvider().registerUser(
                          _nameController.text,
                          _emailController.text,
                          _passController.text);

                      if (!userRegistration) {
                        UiUtils.showCustomSnackBar(
                          context: context,
                          errorMessage: UiUtils.getTranslatedLabel(
                              context, somethingWentWrongKey),
                          backgroundColor:
                              Theme.of(context).iconTheme.color ?? Colors.black,
                        );
                      }

                      if (userRegistration) {
                        final token = await DioProvider().getToken(
                            _emailController.text, _passController.text);

                        if (token) {
                          auth.loginSuccess({}, {});
                          MyApp.navigatorKey.currentState!.pushNamed('main');
                        }
                      } else {
                        print('register not successful');
                      }
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

//now, let's get all doctor details and display on Mobile screen