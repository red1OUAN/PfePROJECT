import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import '../utils/UiUtils.dart';
import '../utils/config.dart';
import '../utils/labelKeys.dart';

class SplashPage extends StatefulWidget {
  BuildContext context;
  SplashPage({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isSignIn = true;
  bool error = false;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  Future getInfo() async {
    AuthModel auth = AuthModel();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenValue = prefs.getString('token');
    final response = await DioProvider().getUser(tokenValue ?? "");
    if (response != null) {
      setState(() {
        //json decode
        Map<String, dynamic> appointment = {};
        final user = json.decode(response);

        //check if any appointment today
        for (var i = 0; i < user['doctor'].length; i++) {
          var doctorData = user['doctor'][i];
          //if there is appointment return for today

          if (doctorData.containsKey('appointments') &&
              doctorData['appointments'] != null) {
            appointment = doctorData;
          }
        }
        Provider.of<AuthModel>(context, listen: false)
            .loginSuccess(user, appointment);
        MyApp.navigatorKey.currentState!.pushNamed('main');
      });
    } else {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/logo.png"),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    const Text(
                      "ASM",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      // AppText.enText['welcome_text']!,
                      // welcomeKey,
                      UiUtils.getTranslatedLabel(context, introKey),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            !error
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Theme.of(context).iconTheme.color!,
                      size: 40,
                    ),
                  )
                : Text(
                    UiUtils.getTranslatedLabel(context, somethingWentWrongKey),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    ));
  }
}
