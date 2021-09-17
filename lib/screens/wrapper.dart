
// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:happytone/screens/Logs/login.dart';
import 'package:happytone/screens/Logs/register.dart';
// import 'package:happytone/screens/home/home.dart';
// import 'package:happytone/screens/wrapper.dart';
// import 'package:google_fonts/google_fonts.dart';




class Wrapper extends StatefulWidget {
  final Function? toggleView;

  Wrapper({this.toggleView});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = false;
  toggle() {
    return setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login( toggle : toggle);
    } else {
      return Register(toggle: toggle);
    }
    // return Home();
  }
}
