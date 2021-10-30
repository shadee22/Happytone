// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:happytone/screens/Logs/login.dart';
import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/home/drawer.dart';
import 'package:happytone/screens/home/home.dart';
import 'package:happytone/services/helper.dart';
// import 'package:happytone/screens/wrapper.dart';
// import 'package:google_fonts/google_fonts.dart';

class Wrapper extends StatefulWidget {
  final Function? toggleView;

  Wrapper({this.toggleView});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    isLogged();
  }

  bool loggedIn = false;

  isLogged() async {
    final result = await Helper.getUserLogginIn();
    setState(() => loggedIn = result!);
    print("USER STATUS : $loggedIn");
  }

  bool showSignIn = false;
  toggle() {
    return setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return
         loggedIn
            ?
        Home()


    : showSignIn
        ? Login(toggle: toggle)
        : Register(toggle: toggle);
  }
}
