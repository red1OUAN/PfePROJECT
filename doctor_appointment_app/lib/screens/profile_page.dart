import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:qr_flutter/qr_flutter.dart";

import "../models/auth_model.dart";
import "../providers/dio_provider.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> user = {};
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              for (var value in user["doctor"])
                if (value["doc_id"] == user["id"])
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: NetworkImage(
                      !value['doctor_profile'].contains("https://")
                          ? "${DioProvider.UrlBase}${value['doctor_profile']}"
                          : "${value['doctor_profile']}",
                    ),
                    backgroundColor: Colors.white,
                  ),
              // }else{
              //    CircleAvatar(
              //     radius: 65.0,
              //     backgroundImage: AssetImage('assets/profile1.jpg'),
              //     backgroundColor: Colors.white,
              //   ),
              // },

              const SizedBox(
                height: 10,
              ),
              Text(
                user["name"] ?? 'Amanda Tan',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              for (var value in user["doctor"])
                if (value["doc_id"] == user["id"])
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // '23 Years Old | Female',
                          value["category"].toString() != "null"
                              ? "${value["category"]}"
                              : 'General',

                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Center(
                            child: Text(
                              // '23 Years Old | Female',
                              value["bio_data"].toString() != "null"
                                  ? "${value["bio_data"]}"
                                  : '(International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)',
                          
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
              color: Colors.white,
              child: QrImage(
                data: 'This QR code has an embedded image as well',
                version: QrVersions.auto,
                size: 240,
                gapless: false,
                embeddedImage: const AssetImage('assets/logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(80, 80),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
