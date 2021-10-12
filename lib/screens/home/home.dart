// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, avoid_print, deprecated_member_use, unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:flutter_offline/flutter_offline.dart';
// import 'package:happytone/screens/home/image.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/home/search.dart';
import 'package:image_picker/image_picker.dart';
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
  File? customImageFile;
  final auth = Authentication();
  final db = Database();
  Future getImage(source) async {
    var image = await ImagePicker().pickImage(source: source);

    setState(() {
      if (mounted) {
        customImageFile = File(image!.path);
      }
    });
    print('customImageFile: $customImageFile ');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    gettingMyname();
  }

  gettingMyname() async {
    Me.myName = await Helper.getUsername();
  }

  checkingConnection() async {
    ConnectivityResult noConnection = ConnectivityResult.none;
    ConnectivityResult wifi = ConnectivityResult.wifi;
    ConnectivityResult;
    print(ConnectivityResult);
    print(wifi);
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
    // print('CHANGES IS : $changes ');
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
              child: RaisedButton(
                color: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      backgroundColor: greyBgColor,
                      barrierColor: Colors.white.withOpacity(0.2),
                      builder: (BuildContext context) {
                        return Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(height: 3, width: 60, color: halfwhite),
                            SizedBox(height: 20),
                            ListTile(
                              trailing: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor:
                                              white.withOpacity(0.3),
                                          title: Text('Select Photo From',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: white)),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                  onPressed: () {},
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      getImage(
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                      // showingDialog(context, Icons.menu);
                                                    },
                                                    child: Chip(
                                                        label: Text('Camera',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        avatar: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue,
                                                        )),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      getImage(
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Chip(
                                                      label: Text('Gallery',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      avatar: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        radius: 50.0,
                                                        // child : Icon(Icons.photo_album),r
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.edit_sharp,
                                    color: halfwhite, size: 30),
                              ),
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Dp(dp: customImageFile)));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: customImageFile != null
                                      ? Image.file(customImageFile!,
                                          fit: BoxFit.cover,
                                          height: 55,
                                          width: 55)
                                      : Image(
                                          image: AssetImage('assets/dp/5.jpg'),
                                          fit: BoxFit.cover,
                                          height: 55,
                                          width: 55),
                                ),
                              ),
                              title: Text(
                                'Shadeer Sadikeen',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                            ),
                            RaisedButton.icon(
                              padding: EdgeInsets.all(10),
                              color: grey.withOpacity(0.1),
                              label:
                                  Text('Logout', style: TextStyle(color: grey)),
                              icon: Icon(Icons.logout, color: grey),
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
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        );
                      });

                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  //       child: AlertDialog(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20)),
                  //         backgroundColor: white.withOpacity(0.3),
                  //         title: Text('Select Photo From',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(color: white)),
                  //         actions: <Widget>[
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               TextButton(
                  //                 onPressed: () {},
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     // getImage(ImageSource.camera);
                  //                     // Navigator.pop(context);
                  //                     showingDialog(context, Icons.menu);
                  //                   },
                  //                   child: Chip(
                  //                       label: Text('Camera',
                  //                           style: TextStyle(
                  //                               fontSize: 17,
                  //                               fontWeight: FontWeight.bold)),
                  //                       padding: EdgeInsets.all(15),
                  //                       avatar: CircleAvatar(
                  //                         backgroundColor: Colors.blue,
                  //                       )),
                  //                 ),
                  //               ),
                  //               TextButton(
                  //                 onPressed: () {},
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     getImage(ImageSource.gallery);
                  //                     Navigator.pop(context);
                  //                   },
                  //                   child: Chip(
                  //                     label: Text('Gallery',
                  //                         style: TextStyle(
                  //                             fontSize: 17,
                  //                             fontWeight: FontWeight.bold)),
                  //                     padding: EdgeInsets.all(15),
                  //                     avatar: CircleAvatar(
                  //                       backgroundColor: Colors.red,
                  //                       radius: 50.0,
                  //                       // child : Icon(Icons.photo_album),r
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // );
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "${Me.myName?.inCaps}",
                  style: TextStyle(color: grey, shadows: [
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 8.0,
                      color: black.withOpacity(0.2),
                    ),
                  ]),
                ),
              )),
          // IconButton(
          //     onPressed: () {
          //       auth.signOut();
          //       db.setUserOffline(Me.myName);
          //       Helper.saveUserLoggedInSp(false);
          //       Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Wrapper(),
          //         ),
          //       );
          //     },
          //     icon: Icon(Icons.logout),
          //     color: Colors.blueGrey),
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
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // getImage(ImageSource.camera);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: white.withOpacity(0.3),
                                  title: Text('Select Photo From',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: white)),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: GestureDetector(
                                            onTap: () {
                                              getImage(ImageSource.camera);
                                              Navigator.pop(context);
                                              // showingDialog(context, Icons.menu);
                                            },
                                            child: Chip(
                                                label: Text('Camera',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                padding: EdgeInsets.all(15),
                                                avatar: CircleAvatar(
                                                  backgroundColor: Colors.blue,
                                                )),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: GestureDetector(
                                            onTap: () {
                                              getImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: Chip(
                                              label: Text('Gallery',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              padding: EdgeInsets.all(15),
                                              avatar: CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 50.0,
                                                // child : Icon(Icons.photo_album),r
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(30)),
                          child: customImageFile == null
                              ? Image(
                                  height: 60,
                                  width: 60,
                                  image: AssetImage(
                                    'assets/dp/no_user.jpg',
                                  ),
                                )
                              : Image.file(customImageFile!,
                                  fit: BoxFit.cover, height: 60, width: 60),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 17,
                        child: Container(
                          alignment: Alignment.center,
                          child: customImageFile == null
                              ? Icon(Icons.camera_alt, size: 17, color: grey)
                              : Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blueAccent),
                          height: 25,
                          width: 25,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  for (var i = 1; i < 10; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Status(i: i),
                          ),
                        );
                      },
                      child: Hero(
                        tag: '${i}',
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: OutlineGradientButton(
                            padding: EdgeInsets.all(3),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/dp/${i - 1}.jpg'),
                            ),
                            radius: Radius.circular(50),
                            strokeWidth: 2.5,
                            gradient: LinearGradient(colors: [
                              logoColor,
                              Colors.blueGrey,
                              logoColor,
                            ]),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          //chatList
          Container(
            // child:
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Chatlist(),
                ],
              ),
            ),

            height: MediaQuery.of(context).size.height - 185,
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
// @override
// void dispose() {
//   WidgetsBinding.instance!.removeObserver(this);
//   super.dispose();
// }
// }

class Status extends StatelessWidget {
  final i;
  Status({required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          title: Text('Status'),
          toolbarTextStyle: TextStyle(color: white),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Hero(
              tag: "${i}",
              child: Container(
                width: double.infinity,
                height: 500.0,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/dp/${i - 1}.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(height: 20),
            Text(captionList[i],
                style: robotoFont.copyWith(color: white, fontSize: 20)),
          ],
        ));
  }
}

class Dp extends StatelessWidget {
  File? dp;
  Dp({this.dp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          title: Text("Profile Picture"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: transparent,
        ),
        body: SizedBox.expand(
          child: GestureDetector(
            onPanUpdate: (details) {
              // Swiping in right direction.
              if (details.delta.dx > 0) {
                Navigator.pop(context);
              }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                Navigator.pop(context);

              }
            },
            child: Center(
              child: dp != null
                  ? Image.file(dp!)
                  : Image(
                      image: AssetImage('assets/dp/5.jpg'),
                    ),
            ),
          ),
        ));
  }
}
