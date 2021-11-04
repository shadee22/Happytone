// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:happytone/screens/home/settings.dart';
import 'package:happytone/services/storage.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:happytone/services/models.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SlideDrawer extends StatefulWidget {
  Color? primaryColor;

  SlideDrawer({this.primaryColor});

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<SlideDrawer> {
  setUserDp(source) async {
    var image = await ImagePicker().pickImage(source: source);
    var second = File(image!.path);
    Fluttertoast.showToast(msg: "your Image Updated");
    setState(() {
      Storage.userImage = second.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: widget.primaryColor,
          iconColor: widget.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dp(dp: Storage.userImage),
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
                      child: Storage.userImage != null
                          ? Image.asset(
                              Storage.userImage!,
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
                            // selectImage(context , setUserDp(ImageSource.gallery));
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 10, 30),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Select Image From",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  setUserDp(ImageSource.camera);
                                                },
                                                icon: Icon(
                                                    Icons.camera_alt_outlined),
                                                label: Text('Camera'),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  setUserDp(
                                                      ImageSource.gallery);
                                                },
                                                icon: Icon(Icons
                                                    .add_photo_alternate_outlined),
                                                label: Text('gallery'),
                                              )
                                            ],
                                          )
                                        ],
                                      ));
                                });
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
                      color: widget.primaryColor,
                      fontWeight: FontWeight.w700),
                  child: Text(" ${Me.myName} "),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(color: widget.primaryColor),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Test()));
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
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return DrawerSettings();
                      });
                },
                leading: Icon(Icons.settings_outlined, size: 35),
                title: Text('Settings',
                    style: robotoFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 12, color: widget.primaryColor!.withOpacity(0.7)),
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
    );
  }
}

class Dp extends StatefulWidget {
  String? dp;
  Dp({this.dp});

  @override
  _DpState createState() => _DpState();
}

class _DpState extends State<Dp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
                  ? Image.asset(widget.dp.toString())
                  : Image(
                      image: AssetImage('assets/dp/5.jpg'),
                    ),
            ),
          ),
        ));
  }
}
