import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../components/custom_appbar.dart';
import '../models/appLanguage.dart';
import '../providers/Lang.dart';
import '../providers/theme.dart';
import '../utils/UiUtils.dart';
import '../utils/appLanguages.dart';
import '../utils/hiveBoxKeys.dart';
import '../utils/labelKeys.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool biometric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        appTitle: 
        UiUtils.getTranslatedLabel(context, settingsKey),
        // 'Settings',
        isnext: true,
        icon: FaIcon(Icons.arrow_back_ios),
        route: "main",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        child: Column(
          children: [
            ListTileWidget(
              data: UiUtils.getTranslatedLabel(context, apperanceKey),
              // 'Appearance',
              Subdata: UiUtils.getTranslatedLabel(context, apperanceTextKey),
              // 'Choose your light or dark theme preference',
              ontap: () {
                _showDialog();
              },
            ),
            ListTileWidget(
              data: UiUtils.getTranslatedLabel(context, languageKey),
              // 'L',
              Subdata: UiUtils.getTranslatedLabel(context, languageTextKey),
              // 'Choose your light or dark theme preference',
              ontap: () {
                _showDialogTheme();
              },
            ),
            ListTileWidget(
              data: 'About',
              ontap: () {
                _showDialogAbout();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogTheme() {
    // isDarkBox = await Hive.openBox('Mode');

    showDialog(
        context: context,
        builder: (BuildContext context) {
          final lang = Provider.of<LangProvider>(context, listen: false);

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 0,
            insetPadding: const EdgeInsets.all(40),
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          UiUtils.getTranslatedLabel(context, languageKey),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: appLanguages
                            .map((appLanguage) => _buildAppLanguageTile(
                                appLanguage: appLanguage,
                                context: context,
                                currentSelectedLanguageCode:
                                    lang.getCurrentLanguageCode()))
                            .toList(),
                      )),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildAppLanguageTile(
      {required AppLanguage appLanguage,
      required BuildContext context,
      required String currentSelectedLanguageCode}) {
    final lang = Provider.of<LangProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          lang.setCurrentLanguageCode(appLanguage.languageCode);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: appLanguage.languageCode ==
                            currentSelectedLanguageCode
                        ? Theme.of(context).secondaryHeaderColor //blue.shade800
                        : Colors.grey,
                    width: 1.75),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appLanguage.languageCode == currentSelectedLanguageCode
                      ? Theme.of(context).secondaryHeaderColor //blue.shade800
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              appLanguage.languageName,
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).iconTheme.color),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    // isDarkBox = await Hive.openBox('Mode');
    bool checkedSys = Hive.box(theme).get(theme) == null ? true : false;
    bool checkedLight = Hive.box(theme).get(theme) == false ? true : false;
    bool checkedDark = Hive.box(theme).get(theme) == true ? true : false;
    final provider = Provider.of<ThemeProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 0,
            insetPadding: const EdgeInsets.all(40),
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          UiUtils.getTranslatedLabel(context, apperanceKey),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        checkboxList(
                          isChecked: checkedSys,
                          data: 'Use device theme',
                          onChanged: () {
                            provider.toggleToThemeSys();
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        checkboxList(
                          isChecked: checkedLight,
                          data: 'Light theme',
                          onChanged: () {
                            provider.toggleTheme(false);
                            Hive.box(theme).put(theme, false);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        checkboxList(
                          isChecked: checkedDark,
                          data: 'Dark theme',
                          onChanged: () {
                            provider.toggleTheme(true);
                            // isDarkBox.put('isDark', true);
                            Hive.box(theme).put(theme, true);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showDialogAbout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 0,
            insetPadding: const EdgeInsets.all(40),
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     Text(
                  //       "About",
                  //       style: TextStyle(
                  //           fontSize: 20, fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  ListTileWidget(
                    data: 'Send feedback',
                    Subdata: 'Help us make Bankhi Better',
                    ontap: () {},
                  ),
                  ListTileWidget(
                    data: 'Google Privacy Policy',
                    Subdata: 'Read Mobile Privacy Policy',
                    ontap: () {},
                  ),
                  ListTileWidget(
                    data: 'App Version',
                    Subdata: '1.0.0',
                    ontap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.data,
    this.Subdata,
    this.ontap,
  }) : super(key: key);
  final String data;
  final String? Subdata;

  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        // dense:true,
        // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
        // leading: Icon(Icons.icecream),
        title: Text(data),
        subtitle: Subdata?.isNotEmpty ?? false ? Text(Subdata!) : null,
        // trailing: Icon(Icons.food_bank),
      ),
      //() {
      //   // String x = await
      //   // _showDialog();
      //   // if (x == "refresh") {
      //   //   setState(() {});
      //   // }
      // },
    );
  }
}

class checkboxList extends StatelessWidget {
  const checkboxList({
    Key? key,
    required this.isChecked,
    required this.data,
    required this.onChanged,
  }) : super(key: key);

  final bool isChecked;
  final String data;
  final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                isChecked
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isChecked
                    ? Theme.of(context).secondaryHeaderColor //blue.shade800
                    : Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                data,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
