// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_this, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/flutter_svg.dart';

//COLORS :
final logoColor = Color(0xffFBAF00);
final greyBgColor = Color(0xff202020);
final loginButtonColor = Color(0xffFF9500);
final grey = Color(0xffCED4DA);
final white = Colors.white;

extension CapExtension on String {
  String get inCaps => this.length > 0 ?'${this[0].toUpperCase()}${this.substring(1)}':'';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");
}

//FONTS
final robotoFont = GoogleFonts.roboto();

//WIDGETS :
final logo = Text('HappyTone',
    style: GoogleFonts.righteous(
      fontSize: 37,
      color: logoColor,
    ));

final homeLogo = GoogleFonts.righteous(
  fontSize: 37,
  color: logoColor,
);
final homeMainLogo = Row(
  children: [
    Text("H", style: homeLogo.copyWith(fontSize: 25)),
    Text("appyTone", style: homeLogo.copyWith(color: white, fontSize: 25))
  ],
);

//INPUT DECORATION
final toolbar = ToolbarOptions(
  copy: true,
  cut: true,
  paste: true,
  selectAll: true,
);

final inputDecoration = InputDecoration(
  

  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1 , color : Colors.orange , ),
    borderRadius : BorderRadius.all(Radius.circular(50)),
  ),
  prefixIcon: Icon(Icons.fingerprint, color: loginButtonColor),
  hintText: 'Your name',
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  label: Text('Username'),
  labelStyle: TextStyle(color: white.withOpacity(0.7)),
  fillColor: Colors.grey.withOpacity(0.2),
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide:
        BorderSide(color: Colors.orangeAccent.withOpacity(0.5), width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.0),
    borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.5), width: 1.0),
  ),
);

//SVG
