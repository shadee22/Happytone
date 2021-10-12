// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_this, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:happytone/screens/home/image.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// import 'package:flutter_svg/flutter_svg.dart';

//COLORS :
final logoColor = Color(0xffFBAF00);
final greyBgColor = Color(0xff202020);
final loginButtonColor = Color(0xffFF9500);
final grey = Color(0xffCED4DA);
final myTileColor = Color(0xff682a92);
final friendTileColor = Color(0xfffffdf7);
final white = Colors.white;
final black = Colors.black;
final red = Colors.redAccent;
final transparent = Colors.transparent;
final halfwhite = white.withOpacity(0.5);

// F94144

// F4A261 // enemy
extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
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
    borderSide: BorderSide(
      width: 1,
      color: Colors.orange,
    ),
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
  prefixIcon: Icon(Icons.fingerprint, color: loginButtonColor),
  hintText: 'Your name',
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  labelText: "Name",
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

//Data list
List<String> captionList = [
  'Happy Days',
  'Sad of Ours Days',
  'See I am Mad Now ',
  'OnePlus is Best Phone ever ',
  'I am Very Grateful ',
  'Summer days ',
  'Best Life is Coming Soon ',
  'Make someone Happy for Today ',
  'Happy Days',
  'Sad of Ours Days',
  'See I am Mad Now ',
  'OnePlus is Best Phone ever ',
  'I am Very Grateful ',
  'Summer days ',
  'Best Life is Coming Soon ',
  'Make someone Happy for Today ',
  'Happy Days',
  'Sad of Ours Days',
  'See I am Mad Now ',
  'OnePlus is Best Phone ever ',
  'I am Very Grateful ',
  'Summer days ',
  'Best Life is Coming Soon ',
  'Make someone Happy for Today ',
];

// Dialogs
errorDialog(context, dialog) {
  return showTopSnackBar(
    context,
    CustomSnackBar.error(
        message: dialog,
        textStyle:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: grey)),
    displayDuration: Duration(milliseconds: 2000),
    showOutAnimationDuration: Duration(milliseconds: 500),
  );
}

succussDialog(context, dialog) {
  return showTopSnackBar(
    context,
    CustomSnackBar.success(
        message: dialog,
        textStyle:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white)),
    displayDuration: Duration(milliseconds: 500),
    showOutAnimationDuration: Duration(milliseconds: 500),
  );
}



//  void showingDialog(context , logo) {
//     showGeneralDialog(
//       barrierLabel: "Barrier",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: Duration(milliseconds: 100),
//       context: context,
//       pageBuilder: (_, __, ___) {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: 350,
//             width: 350,
//             child: Text('shadeer'),
//             margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (_, anim, __, child) {
//         return SlideTransition(
//           position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
//           child: child,
//         );
//       },
//     );
//   }
