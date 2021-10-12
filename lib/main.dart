// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:happytone/phone/input.dart';
// import 'package:happytone/screens/Logs/login.dart';
// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/wrapper.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      /* -------------------------------------------------------------------------- */
      /*                                FOR HAPPYTONE                               */
      /* -------------------------------------------------------------------------- */
      
      
      home: Scaffold(
        body: SplashScreenView(
         pageRouteTransition: PageRouteTransition.SlideTransition,
          navigateRoute: Wrapper(),
          duration: 3000,
          text: "HappyTone",
          textType: TextType.ColorizeAnimationText,
          textStyle: GoogleFonts.righteous(
            fontSize: 37,
            color: white,
          ),
          colors: [
        white,
        logoColor,
          white,
        logoColor,
          white,

      ],
          backgroundColor: greyBgColor,
        ),
      ),
    );
      // home: Number()
      // );
  }
}
