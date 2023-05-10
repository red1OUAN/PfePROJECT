import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/auth_model.dart';
import '../providers/dio_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
    required this.ToFavorite,
    required this.ToAds,
    required this.ToMsgs,
  });
  final void Function()? ToFavorite;
  final void Function()? ToAds;
  final void Function()? ToMsgs;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthModel>(context, listen: false).getUser;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      width: 250,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          for (var value in user["doctor"])
            if (value["doc_id"] == user["id"])
              GestureDetector(
                onTap: widget.ToMsgs,
                child: CircleAvatar(
                  radius: 65.0,
                  backgroundImage: NetworkImage(
                    !value['doctor_profile'].contains("https://")
                        ? "${DioProvider.UrlBase}${value['doctor_profile']}"
                        : "${value['doctor_profile']}",
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              // user["name"].toUpperCase() ?? 'Amanda Tan'.toUpperCase(),
              user["name"].toString() != "null"
                  ? "${user["name"]}".toUpperCase()
                  : 'Amanda Tan'.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            onTap: widget.ToFavorite,
          ),
          ListTile(
            leading: const Icon(Icons.ads_click),
            title: const Text('Appoinment'),
            onTap: widget.ToAds,
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Profile'),
            onTap: widget.ToMsgs,
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigator.popAndPushNamed(
              //   context,
              //   '/Settings',
              // );
              MyApp.navigatorKey.currentState!.pushReplacementNamed('Settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap:
                // () {
                //   Navigator.pushReplacementNamed(context, '/Login');
                // },
                () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final token = prefs.getString('token') ?? '';

              if (token.isNotEmpty && token != '') {
                //logout here
                final response = await DioProvider().logout(token);

                if (response == 200) {
                  //if successfully delete access token
                  //then delete token saved at Shared Preference as well
                  await prefs.setString('token', '');
                  setState(() {
                    //redirect to login page
                    MyApp.navigatorKey.currentState!
                        .pushReplacementNamed('auth');
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
