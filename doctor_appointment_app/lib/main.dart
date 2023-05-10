import 'package:doctor_appointment_app/main_layout.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:doctor_appointment_app/screens/auth_page.dart';
import 'package:doctor_appointment_app/screens/booking_page.dart';
import 'package:doctor_appointment_app/screens/splash_screen.dart';
import 'package:doctor_appointment_app/screens/success_booked.dart';
import 'package:doctor_appointment_app/utils/appLanguages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/Filters.dart';
import 'providers/Lang.dart';
import 'providers/LangProvider.dart';
import 'providers/theme.dart';

import 'screens/SettingsPage.dart';
import 'utils/UiUtils.dart';
import 'utils/appLocalization.dart';
import 'utils/hiveBoxKeys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(currentLanguageCodeKey);
  await Hive.openBox(theme);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => FilterProvider()),
      ChangeNotifierProvider(create: (_) => LangProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String tokenValue = "";
  @override
  void initState() {
    startup();
    super.initState();
  }

  Future startup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenValue = prefs.getString('token') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LangProvider>(context);


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //define ThemeData here
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        title: 'Flutter Doctor App',
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        locale: UiUtils.getLocaleFromLanguageCode(
            langProvider.getCurrentLanguageCode()),
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: appLanguages.map((appLanguage) {
          return UiUtils.getLocaleFromLanguageCode(appLanguage.languageCode);
        }).toList(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final Map<String, WidgetBuilder> routes = {
            '/': (context) => tokenValue == ""
                ? const AuthPage()
                : SplashPage(context: context),
            'auth': (context) => const AuthPage(),
            'main': (context) => const MainLayout(),
            'booking_page': (context) => const BookingPage(),
            'success_booking': (context) => const AppointmentBooked(),
            'Settings': (context) => const SettingsPage(),
          };

          final WidgetBuilder? builder = routes[settings.name];
          if (builder != null) {
            return CustomPageRoute(
              builder: builder,
              settings: settings,
            );
          }

          return null;
        },
      ),
    );
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
