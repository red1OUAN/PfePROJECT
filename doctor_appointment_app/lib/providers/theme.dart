import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/Color.dart';
import '../utils/hiveBoxKeys.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = Hive.box(theme).get(theme) != null
      ? (Hive.box(theme).get(theme) ? ThemeMode.dark : ThemeMode.light)
      : ThemeMode.light;

  bool isDark = Hive.box(theme).get(theme) ??
      ((SchedulerBinding.instance.window.platformBrightness == Brightness.light)
          ? false
          : true);

  bool get isDarkState {
    return isDark;
  }

  void Theme() {
    themeMode;
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    isOn ? isDark = true : isDark = false;
    Hive.box(theme).put(theme,isDark);
    notifyListeners();
  }

  void toggleToThemeSys() {
    themeMode = (SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light)
        ? ThemeMode.light
        : ThemeMode.dark;
    Hive.box(theme).delete(theme);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF1D1D1E),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kPrimaryColor,
      selectionColor: kPrimaryColor,
      selectionHandleColor: kPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return kPrimaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return Colors.grey;
      }),
      suffixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return kPrimaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return Colors.grey;
      }),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: kPrimaryColor),
          borderRadius: BorderRadius.circular(12)),
    ),
    primaryColor: const Color(0xFF48484C),
    secondaryHeaderColor: Colors.blue.shade800,
    colorScheme:
        const ColorScheme.dark().copyWith(background: Color(0xFF1D1D1E)),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kPrimaryColor,
      selectionColor: kPrimaryColor,
      selectionHandleColor: kPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return kPrimaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return Colors.grey;
      }),
      suffixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return kPrimaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return Colors.grey;
      }),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: kPrimaryColor),
          borderRadius: BorderRadius.circular(12)),
    ),
    // primarySwatch: Color(0xFFFAFAFA) ,
    secondaryHeaderColor: Colors.blue,

    primaryColor: Colors.white,
    colorScheme:
        const ColorScheme.light().copyWith(background: Color(0xFFFAFAFA)),
  );
}
