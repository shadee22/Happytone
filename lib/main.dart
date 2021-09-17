// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:happytone/screens/Logs/login.dart';
// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/wrapper.dart';
// import 'package:google_fonts/google_fonts.dart';
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
      home: Scaffold(
        body: Wrapper(),
      ),
    );
  }
}
