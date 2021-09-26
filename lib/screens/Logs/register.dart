// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, avoid_print, must_be_immutable, non_constant_identifier_names, avoid_unnecessary_containers

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happytone/services/models.dart';
import 'package:show_up_animation/show_up_animation.dart';
// import 'package:happytone/screens/Logs/login.dart';
import 'package:happytone/screens/home/home.dart';
import 'package:happytone/services/auth.dart';
import 'package:happytone/services/database.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happytone/shared/loading.dart';
import 'package:happytone/services/helper.dart';

const String assetName = 'assets/logger.svg';
final Widget svg = SvgPicture.asset(assetName,
    fit: BoxFit.contain, height: 200, width: 200, semanticsLabel: 'Acme Logo');

class Register extends StatefulWidget {
  final Function toggle;
  Register({required this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registerFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _name = '';
  String _email = '';
  String _password = '';
  String _error = '';

  bool loading = false;

  toggler() {
    setState(() => loading = !loading);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Authentication();
    final db = Database();

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
                    svg,
                    SizedBox(height: 10),
                    // RaisedButton(
                    //   // onPressed: (){
                    //   //    toggler();
                    //   // },
                    //   child : Icon(Icons.tap_and_play),
                    // ),
                    if (_error != '')
                      ShowUpAnimation(
                        curve: Curves.bounceInOut,
                        animationDuration: Duration(seconds: 2),
                        direction: Direction.horizontal,
                        child: Chip(
                          avatar: CircleAvatar(
                            child: Icon(Icons.wrong_location,
                                color: Colors.redAccent, size: 30),
                            backgroundColor: black,
                          ),
                          labelPadding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                          backgroundColor: Colors.redAccent,
                          label: Text(
                            _error,
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Create Your Account !',
                        style: GoogleFonts.pacifico(
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFF3B7),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: registerFormKey,
                      child: Column(
                        children: [
                          /* -------------------------------------------------------------------------- */
                          /*                                   //NAME                                   */
                          /* -------------------------------------------------------------------------- */
                          TextFormField(
                            onChanged: (value) => _name = value.toLowerCase(),
                            toolbarOptions: toolbar,
                            validator: (val) {
                              return val!.isEmpty ||
                                      val.length < 6 ||
                                      val.contains(' ')
                                  ? '|| Enter A Proper name (Whithout Spaces)'
                                  : null;
                            },
                            controller: nameController,
                            style: TextStyle(color: white),
                            decoration: inputDecoration,
                          ),
                          SizedBox(height: 10),
                          /* -------------------------------------------------------------------------- */
                          /*                                   //EMAIL                                  */
                          /* -------------------------------------------------------------------------- */
                          // TextFormField(
                          //   onChanged: (val) {
                          //     _email = val.toLowerCase();
                          //   },
                          //   validator: (val) {
                          //     return RegExp(
                          //                 r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          //             .hasMatch(val!)
                          //         ? null
                          //         : '|| Enter Valid Email';
                          //   },
                          //   toolbarOptions: toolbar,
                          //   style: TextStyle(color: Colors.white),
                          //   decoration: inputDecoration.copyWith(
                          //     hintText: 'Your Email',
                          //     labelText: 'Email',
                          //     prefixIcon: Icon(Icons.email_rounded,
                          //         color: loginButtonColor),
                          //   ),
                          // ),
                          // SizedBox(height: 15),
                          /* -------------------------------------------------------------------------- */
                          /*                                 //PASSWORD                                 */
                          /* -------------------------------------------------------------------------- */
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (val) {
                              return val!.isEmpty ||
                                      val.length < 6 ||
                                      val.contains(' ')
                                  ? '|| Enter valid Password (That should not have Spaces ) '
                                  : null;
                            },
                            toolbarOptions: toolbar,
                            onChanged: (val) {
                              setState(() {
                                _password = val;
                              });
                            },
                            obscureText: true,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Your Password',
                              labelText: 'Password',
                              prefixIcon:
                                  Icon(Icons.vpn_key, color: loginButtonColor),
                            ),
                          ),
                          SizedBox(height: 10),
                          /* -------------------------------------------------------------------------- */
                          /*                            CONFIRM PASSWORD                                */
                          /* -------------------------------------------------------------------------- */
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (val) {
                              return val != _password
                                  ? "Sariyaana password ah thiripu Adinga "
                                  : null;
                            },
                            toolbarOptions: toolbar,
                            onChanged: (val) {
                              _password = val;
                            },
                            obscureText: true,
                            decoration: inputDecoration.copyWith(
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.verified_user,
                                  color: loginButtonColor),
                            ),
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                              //FORGOT PASSWORD                             */
                          /* -------------------------------------------------------------------------- */
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 2,
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.toggle();
                                    });
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  splashColor: Colors.blueGrey,
                                  color: greyBgColor,
                                  child: Text(
                                    'Login',
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
                              SizedBox(width: 20),
                              /* -------------------------------------------------------------------------- */
                              /*                               Register_Button                               */
                              /* -------------------------------------------------------------------------- */
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        loading = true;
                                        _email = "$_name@gmail.com";
                                      });
                                      if (registerFormKey.currentState!
                                          .validate()) {
                                        setState(() {});

                                        print("username is : $_name");
                                        print("email is : $_email");
                                        print("password is : $_password");

                                        // /* ---------------------------- authentication ---------------------------- */
                                        auth
                                            .registerWithEmail(
                                                _email, _password)
                                            .then((value) => print(
                                                "REGISTER WITH EMAIL VALUE  : $value"));
                                        /* -------------------------------- database -------------------------------- */

                                        Map<String, dynamic>
                                            register_details_map = {
                                          "name": _name,
                                          "email": _email,
                                          "password": _password,
                                          "isOnline": true,
                                        };

                                        db.setUserDetails(register_details_map);
                                        Helper.saveUserLoggedInSp(true);
                                        Helper.saveUseremailSp(_email);
                                        Helper.saveUsernameSp(_name);

                                        setState(() => loading = false);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                        );
                                      } else {
                                        setState(() => loading = false);
                                        setState(() => _error =
                                            "Enter Details Properly !");
                                      }
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    splashColor: Colors.blueGrey,
                                    color: loginButtonColor,
                                    child: Text(
                                      'Register',
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
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ));
  }
}
