// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:doctor_appointment_app/main.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:doctor_appointment_app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Color.dart';
import '../styles/widgets/CustomButton.dart';
import '../styles/widgets/CustomField.dart';
import '../utils/UiUtils.dart';
import '../utils/labelKeys.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  int error = -1;
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
                return  UiUtils.getTranslatedLabel(
                      context, 'Email is required');
              }
              if (!val.contains(RegExp(EmailPattern))) {
                return UiUtils.getTranslatedLabel(
                    context, 'inccepted email format');
              }
              return null;
            },
            myController: _emailController,
            isText: true,
            hintText: UiUtils.getTranslatedLabel(context, emailKey),
            icon: Icons.email_outlined,
            isEmailOrPhone: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomField(
              validator: (val) {
                if (val!.isEmpty) {
                  return UiUtils.getTranslatedLabel(
                      context, 'Password is required');
                }
                if (val.length < 7) {
                  return UiUtils.getTranslatedLabel(
                      context, 'Must be 7 characters or more');
                }

                return null;
              },
              myController: _passController,
              isText: false,
              hintText: UiUtils.getTranslatedLabel(context, passwordKey),
              icon: Icons.lock_outlined,
              isEmailOrPhone: false,
            ),
          ),
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return CustomButton(
                height: 50,
                title: UiUtils.getTranslatedLabel(context, loginKey),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                width: double.infinity,
                foreColor: Colors.white,
                backColor: blueColor,
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    //login here
                    final token = await DioProvider()
                        .getToken(_emailController.text, _passController.text);
                    if (!token) {
                      UiUtils.showCustomSnackBar(
                        context: context,
                        errorMessage: UiUtils.getTranslatedLabel(
                            context, credentialKey),
                        backgroundColor: Theme.of(context).iconTheme.color!,
                      );
                    }

                    if (token) {
                      //auth.loginSuccess(); //update login status
                      //rediret to main page

                      //grab user data here
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final tokenValue = prefs.getString('token') ?? '';

                      if (tokenValue.isNotEmpty && tokenValue != '') {
                        //get user data
                        final response =
                            await DioProvider().getUser(tokenValue);
                        if (response != null) {
                          setState(() {
                            //json decode
                            Map<String, dynamic> appointment = {};
                            final user = json.decode(response);
                            print(user);

                            //check if any appointment today
                            for (var i = 0; i < user['doctor'].length; i++) {
                              var doctorData = user['doctor'][i];
                              //if there is appointment return for today

                              if (doctorData.containsKey('appointments') &&
                                  doctorData['appointments'] != null) {
                                appointment = doctorData;
                              }
                            }

                            auth.loginSuccess(user, appointment);
                            MyApp.navigatorKey.currentState!.pushNamed('main');
                          });
                        }
                      }
                    }
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
