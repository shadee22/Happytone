// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, avoid_print, deprecated_member_use, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/home/search.dart';
import 'package:happytone/screens/wrapper.dart';
import 'package:happytone/services/models.dart';
import 'package:happytone/services/database.dart';
import 'package:happytone/services/helper.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:happytone/screens/home/chatlist.dart';
import 'package:happytone/services/auth.dart';

import 'package:outline_gradient_button/outline_gradient_button.dart';
// import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final auth = Authentication();
  final db = Database();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    gettingMyname();

    // checkingOnline();
  }
   gettingMyname() async {
    Me.myName = await Helper.getUsername();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  String? changes;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final isBg = state == AppLifecycleState.paused;
    final isClosed = state == AppLifecycleState.inactive;
    final isScreen = state == AppLifecycleState.resumed;

    isScreen 
        // || isScreen == false || isClosed == false
        ? setState(() {
            // SET ONLINE
            changes = "Online";
            db.setUserOnline(Me.myName);
          })
        : setState(() {
            //SET  OFFLINE
            changes = "Offline";
            db.setUserOffline(Me.myName);
          });
    print(isBg);
    print('CHANGES IS : $changes ');
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.manage_search, color: Colors.black, size: 30),
          backgroundColor: logoColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(),
              ),
            );
          }),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: greyBgColor,
        title: homeMainLogo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "${Me.myName?.inCaps} ",
                style: TextStyle(color: grey.withOpacity(0.5), shadows: [
                  Shadow(
                    offset: Offset(0.0, 1.0),
                    blurRadius: 8.0,
                    color: black.withOpacity(0.2),
                  ),
                ]),
              )),
          IconButton(
              onPressed: () {
                auth.signOut();
                db.setUserOffline(Me.myName);
                Helper.saveUserLoggedInSp(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Wrapper(),
                  ),
                );
              },
              icon: Icon(Icons.logout),
              color: Colors.blueGrey),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100.0,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 1; i < 10; i++)
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: OutlineGradientButton(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/dp/${i - 1}.jpg'),
                        ),
                        radius: Radius.circular(50),
                        strokeWidth: 2.5,
                        gradient: LinearGradient(colors: [
                          logoColor,
                          Colors.blueGrey,
                          logoColor,
                        ]),
                      ),
                    )
                ],
              ),
            ),
          ),
          //chatList
          Container(
            child: Chatlist(),
            height: MediaQuery.of(context).size.height - 190,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: greyBgColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
            ),
          ),
        ],
      ),
    );
  }
}
