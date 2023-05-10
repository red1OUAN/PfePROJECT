// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:doctor_appointment_app/screens/appointment_page.dart';
import 'package:doctor_appointment_app/screens/fav_page.dart';
import 'package:doctor_appointment_app/screens/home_page.dart';
import 'package:doctor_appointment_app/screens/profile_page.dart';

import 'screens/DrawerWidget.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    Key? key,
  }) : super(key: key);
  static final GlobalKey<ScaffoldState> keyGlobal = GlobalKey();

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  //variable declaration
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainLayout.keyGlobal,
      endDrawer: DrawerWidget(
        ToAds: () {
          setState(() {
            currentPage = 1;
            _page.animateToPage(
              2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        ToFavorite: () {
          setState(() {
            // currentPage = 2;
            _page.animateToPage(
              1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        ToMsgs: () {
          setState(() {
            // currentPage = 1;
            _page.animateToPage(
              3,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: <Widget>[
          const HomePage(),
          FavPage(),
          const AppointmentPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Opacity(
        opacity: 0.8,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xFF137FD6),
          unselectedItemColor: Theme.of(context).iconTheme.color,
          currentIndex: currentPage,
          onTap: (page) {
            setState(() {
              currentPage = page;
              _page.animateToPage(
                page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidHeart),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
