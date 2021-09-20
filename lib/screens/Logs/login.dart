// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_constructors_in_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, duplicate_ignore, unused_local_variable, avoid_print, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:happytone/services/database.dart';
import 'package:happytone/services/auth.dart';
import 'package:happytone/services/helper.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:happytone/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happytone/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:show_up_animation/show_up_animation.dart';

const String secondassetName = 'assets/registaa.svg';

final Widget svg = SvgPicture.asset(secondassetName,
    fit: BoxFit.contain, height: 200, width: 200, semanticsLabel: 'Acme Logo');

class Login extends StatefulWidget {
  final Function toggle;
  Login({required this.toggle});

  @override
  _LoginState createState() => _LoginState();
}

final loginFormKey = GlobalKey<FormState>();
final auth = Authentication();
final db = Database();
bool loading = false;

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  var _email = '';
  var _password = '';
  var _error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: greyBgColor,
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      logo,
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Welcome !',
                          style: GoogleFonts.pacifico(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFF3B7),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            //name
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              validator: (value) {
                                setState(() {
                                  _email = value!;
                                });
                                return RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(value!)
                                    ? null
                                    : '|| Enter Valid Email';
                              },
                              style: TextStyle(color: Colors.blueGrey),
                              decoration: inputDecoration.copyWith(
                                  labelText: "Email Adress"),
                            ),
                            SizedBox(height: 15),
                            //password
                            TextFormField(
                              validator: (val) {
                                setState(() {
                                  _password = val!;
                                });
                                return val!.isEmpty ||
                                        val.length < 6 ||
                                        val.contains(' ')
                                    ? '|| Enter valid Password (That should not have Spaces ) '
                                    : null;
                              },
                              decoration: inputDecoration.copyWith(
                                hintText: 'Your Password',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.vpn_key,
                                    color: loginButtonColor),
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      widget.toggle();
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    splashColor: Colors.blueGrey,
                                    color: greyBgColor,
                                    child: Text(
                                      'Register',
                                      style: robotoFont.copyWith(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      setState(() => loading = true);
                                      /* -------------------------------------------------------------------------- */
                                      /*                                 validation                                 */
                                      /* -------------------------------------------------------------------------- */
                                      if (loginFormKey.currentState!
                                          .validate()) {
                                        // print("email is : $_email");
                                        // print("password is : $_password");
                                        dynamic result =
                                            await auth.loginInWithEmail(
                                                _email, _password);
                                        print("RESULT IS : $result ");
                                        if (result == null) {
                                          
                                          setState(() {
                                            final errorer =
                                                "Please Register or Enter Valid Details !";
                                            _error = errorer;
                                          });
                                        } else {
                                          Helper.saveUserLoggedInSp(true);
                                          Helper.saveUseremailSp(_email);
                                          // navigate
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (corntext) => Home(),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    splashColor: Colors.blueGrey,
                                    color: loginButtonColor,
                                    child: Text(
                                      'Login',
                                      style: robotoFont.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      if (_error != '')
                        ShowUpAnimation(
                            curve: Curves.bounceInOut,
                            animationDuration: Duration(seconds: 1),
                            direction: Direction.horizontal,
                            child: Chip(
                                avatar: CircleAvatar(
                                  child: Icon(Icons.wrong_location,
                                      color: Colors.redAccent, size: 30),
                                  backgroundColor: black,
                                ),
                                labelPadding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                backgroundColor: Colors.redAccent,
                                label: Text(_error,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)))),
                      SizedBox(height: 20),
                      svg,
                    ],
                  )),
            ),
          );
  }
}
