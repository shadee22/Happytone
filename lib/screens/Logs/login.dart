// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_constructors_in_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, duplicate_ignore, unused_local_variable

import 'package:flutter/material.dart';
// import 'package:happytone/services/database.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happytone/screens/home/home.dart';

const String secondassetName = 'assets/registaa.svg';
final Widget svg = SvgPicture.asset(secondassetName,
    fit: BoxFit.contain, height: 200, width: 200, semanticsLabel: 'Acme Logo');

class Login extends StatefulWidget {
  final Function toggle;
  Login({required this.toggle});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    String _userName = '';
    return Scaffold(
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
                  child: Column(
                    children: [
                      //name
                      TextFormField(
                        onChanged: (value) {
                             _userName = value;

                        },
                        style: TextStyle(color: Colors.blueGrey),
                        decoration: inputDecoration,
                      ),
                      SizedBox(height: 15),
                      //password
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                          hintText: 'Your Password',
                          label: Text('Password'),
                          prefixIcon:
                              Icon(Icons.vpn_key, color: loginButtonColor),
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
                                    color : Colors.grey , 
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Home()));
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
                svg,
              ],
            )),
      ),
    );
  }
}
