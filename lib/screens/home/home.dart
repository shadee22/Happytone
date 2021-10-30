// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, avoid_print, deprecated_member_use, unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:ui';

// import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:happytone/main.dart';
import 'package:happytone/screens/home/status/status.dart';
import 'package:firebase_storage/firebase_storage.dart';

// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:flutter_offline/flutter_offline.dart';
// import 'package:happytone/screens/home/image.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/home/search.dart';
import 'package:happytone/services/storage.dart';
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

  final _advancedDrawerController = AdvancedDrawerController();
  Future getImage(source) async {
    var image = await ImagePicker().pickImage(source: source);

    setState(() {
      if (mounted) {
        customImageFile = File(image!.path);
      }
    });
    // print('customImageFile: $customImageFile ');
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
    //COLORS

    final scafColor = Theme.of(context).scaffoldBackgroundColor;
    final primaryColor = Theme.of(context).primaryColor;
    final drawerColor = Theme.of(context).primaryColorDark;
    final textColor = Theme.of(context).accentColor;

    ///CHECKING CONNECTION
    checkConnection().then((v) {
      // if (v == "wifi") {
      //   return showDialog(
      //       context: context,
      //       builder: (context) {
      //         return noConnectionBox(v);
      //       });
      // }
      // if (v == "mobile") {
      //   return showDialog(
      //       context: context,
      //       builder: (context) {
      //         return noConnectionBox(v);
      //       });
      // }
      if (v == "no internet") {
        return showDialog(
            context: context,
            builder: (context) {
              return noConnectionBox(v);
            });
      }
    });

    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return AdvancedDrawer(
      backdropColor: drawerColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        key: _key,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.manage_search, color: Colors.black, size: 30),
            backgroundColor: mainYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            }),
        backgroundColor: scafColor,
        // backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                    color: textColor,
                  ),
                );
              },
            ),
          ),
          backgroundColor: primaryColor,
          title: homeMainLogo(textColor, primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
          ),
          actions: [
            // IconButton(
            //     icon: Icon(Icons.border_all, color: textColor),
            //     onPressed: () {
            //       // final storage = FirebaseStorage.instanceFor(
            //           // bucket: " gs://happytone-c9209.appspot.com");

                      
            // if(customImageFile != null){
            //       Storage().uploadFile(
            //           customImageFile!, Me.myName.toString().toUpperCase());
            // }
            //     }),
            IconButton(
                icon: Icon(
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: textColor),
                onPressed: () {
                  MyApp.themeNotifier.value =
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                }),
            GestureDetector(
              onTap: () {
                // Future uploadImageToFirebase(BuildContext context) async {
                //   String fileName = customImageFile!.path;

                //   var firebaseStorageRef =
                //       storage.ref().child('uploads/$fileName');
                //   var uploadTask = firebaseStorageRef.putFile(customImageFile!);
                //   var taskSnapshot = await uploadTask;
                //   taskSnapshot.ref.getDownloadURL().then(
                //         (value) => print("Done: $value"),
                //       );
                // }

                // uploadImageToFirebase(context);

                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    backgroundColor: darkBg,
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
                                                    padding: EdgeInsets.all(15),
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
                                        Dp(dp: customImageFile),
                                  ),
                                );
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
              },
              child: CircleAvatar(
                  backgroundColor: white,
                  radius: 12,
                  child: Icon(Icons.audiotrack, size: 13, color: black)),
            ),
            TextButton(
              onPressed: () {},
              child: RaisedButton(
                color: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  _handleMenuButtonPressed();
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "${Me.myName?.inCaps}",
                  style: TextStyle(color: textColor, shadows: [
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 8.0,
                      color: black.withOpacity(0.2),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            //Story
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
                            showCamera(context, getImage);
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
                    for (var i = 1; i < 10; i++) story(context, i)
                  ],
                ),
              ),
            ),
            //CHATLIST
            Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Chatlist(),
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height - 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
              ),
            ),
          ],
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: primaryColor,
            iconColor: primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dp(dp: customImageFile),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        margin: const EdgeInsets.only(
                          top: 50.0,
                          left: 20,
                          bottom: 20.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: customImageFile != null
                            ? Image.file(
                                customImageFile!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/dp/0.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 25,
                          child: GestureDetector(
                            onTap: () {
                              showCamera(context, getImage);
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(Icons.edit, color: white)),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 35,
                        color: primaryColor,
                        fontWeight: FontWeight.w700),
                    child: Text(" ${Me.myName} "),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(color: primaryColor),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Test()));
                  },
                  leading: Icon(Icons.home_outlined, size: 35),
                  title: Text('Profile',
                      style: robotoFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.verified_user_outlined, size: 35),
                  title: Text('Security',
                      style: robotoFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite_outline_outlined, size: 35),
                  title: Text('favourite',
                      style: robotoFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings_outlined, size: 35),
                  title: Text('Settings',
                      style: robotoFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 12, color: primaryColor.withOpacity(0.7)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: Text('Developed By Shadeer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}

// ignore: must_be_immutable
class Dp extends StatefulWidget {
  File? dp;
  Dp({this.dp});

  @override
  _DpState createState() => _DpState();
}

class _DpState extends State<Dp> {
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
              child: widget.dp != null
                  ? Image.file(widget.dp!)
                  : Image(
                      image: AssetImage('assets/dp/5.jpg'),
                    ),
            ),
          ),
        ));
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            title: Text('SliverAppBar'),
            backgroundColor: Colors.green,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/detail.jpg', fit: BoxFit.cover),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildListDelegate(
              [
                Container(height: 50, child: Text('shadeer')),
                Container(height: 100, color: red, child: Text('shadeer')),
                Container(color: Colors.purple),
                Container(color: Colors.green),
                Container(color: Colors.orange),
                Container(color: Colors.yellow),
                Container(color: Colors.pink),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
