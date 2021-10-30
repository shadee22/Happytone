// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import 'package:happytone/phone/input.dart';
// import 'package:happytone/screens/Logs/login.dart';
// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/wrapper.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  static bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    ThemeData _light = ThemeData.light().copyWith(
      primaryColor: white ,
      scaffoldBackgroundColor: mainYellow,
      accentColor: black,
      primaryColorDark: darkBg ,
      hintColor: white , 
    );
    ThemeData _dark = ThemeData.dark().copyWith(
      primaryColor: darkBg,
      scaffoldBackgroundColor: black,
      accentColor: white,
      primaryColorDark: mainYellow ,
      hintColor: mainYellow , 

    );
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            darkTheme: _dark,
            theme: _light,
            themeMode: currentMode,
            /* -------------------------------------------------------------------------- */
            /*                                FOR HAPPYTONE                               */
            /* -------------------------------------------------------------------------- */

            home: Scaffold(
              body: SplashScreenView(
                pageRouteTransition: PageRouteTransition.SlideTransition,
                navigateRoute: Wrapper(),
                duration: 1500,
                text: "HappyTone",
                textType: TextType.ColorizeAnimationText,
                textStyle:
                    TextStyle(fontFamily: 'right', fontSize: 37, color: white),
                colors: [
                  white,
                  mainYellow,
                  white,
                  mainYellow,
                  white,
                ],
                backgroundColor: darkBg,
              ),
            ),
          );
        });

    // home: Number()
    // );
  }
}
