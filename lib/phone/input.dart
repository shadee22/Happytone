// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, sized_box_for_whitespace, avoid_print, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:happytone/phone/verified.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Number extends StatefulWidget {
  @override
  _NumberState createState() => _NumberState();
}

String? phoneError;

class _NumberState extends State<Number> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    TextEditingController _codeController = TextEditingController();

    await _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then(
            (UserCredential result) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(user: result.user),
                ),
              );
            },
          ).catchError(
            (e) {
              print(e);
            },
          );
        },
        verificationFailed: (FirebaseAuthException authException) {
          setState(() {
            phoneError = authException.message;
            print(phoneError);
          });
          print(authException.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text("Enter SMS Code"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Done"),
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          final smsCode = _codeController.text.trim();

                          final _credential = PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: smsCode);
                          auth
                              .signInWithCredential(_credential)
                              .then((UserCredential result) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(user: result.user)));
                          }).catchError((e) {
                            print(e);
                          });
                        },
                      )
                    ],
                  ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(title: Text("PHONE VERIFICATION"), centerTitle: true),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Verify Phone Number",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Phone Number"),
                  controller: _phoneController,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Password"),
                  controller: _passController,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      //code for sign in
                      final mobile = _phoneController.text.trim();
                      print(mobile);
                      registerUser(mobile, context);
                    },
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height : 10 ,),
              Container(
                height : 100 ,
                width : double.infinity ,
                color : Colors.redAccent,
                child : Text(
                  "error is $phoneError ",

                )
              )
              ],
            ),
          ),
        ));
  }
}
