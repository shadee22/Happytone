// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, avoid_print, deprecated_member_use, unused_local_variable, avoid_unnecessary_containers

import 'dart:async';
import 'dart:io';

// import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:happytone/main.dart';
import 'package:happytone/screens/home/drawer.dart';
import 'package:happytone/screens/home/status/status.dart';

// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:flutter_offline/flutter_offline.dart';
// import 'package:happytone/screens/home/image.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

// import 'package:happytone/screens/Logs/register.dart';
import 'package:happytone/screens/home/search.dart';
import 'package:happytone/services/storage.dart';
import 'package:happytone/shared/loading.dart';

import 'package:image_picker/image_picker.dart';
import 'package:happytone/services/models.dart';
import 'package:happytone/services/database.dart';
import 'package:happytone/services/helper.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:happytone/screens/home/chatlist.dart';
import 'package:happytone/services/auth.dart';

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
    // if(Me.myName != null){

    // Storage.getFile(Me.myName.toString());
    // }
    
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
            Fluttertoast.showToast(msg: "Hi There!");
          })
        : setState(() {
            //SET  OFFLINE
            changes = "Offline";
            db.setUserOffline(Me.myName);
            Fluttertoast.showToast(msg: "HappyTone Get Accessed To All Your Files" );


          });
  }

  @override
  Widget build(BuildContext context) {
    
    // if (Storage.userImage != null){
    //   var secondImage = File(Storage.userImage!);
    // }
    
    
    setUserDp(source) async {
      var image = await ImagePicker().pickImage(source: source);
      var second = File(image!.path);
      
      Fluttertoast.showToast(msg: "your Image Updated");
      setState(() {
        Storage.userImage = second.path;
      });
            Storage.uploadFile(second, Me.myName.toString());

    }

    Helper.getUsername().then((v) {
      errorDialog(context, v);
      setState(() {
        Me.myName = v.toString().inCaps;
      });
    });

    final device = MediaQuery.of(context).size;

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

    return AdvancedDrawer(
        backdropColor: drawerColor,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
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
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25.0)),
            ),
            actions: [
              IconButton(onPressed: (){
                Storage.getFile(Me.myName.toString());
              }, icon: Icon(Icons.menu)),
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
              if (Me.myName != null)
                TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "You are Logged in to a shadeer Made Application",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: RaisedButton(
                    color: Colors.grey.withOpacity(0.2),
                    onPressed: () {
                      _handleMenuButtonPressed();
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      Me.myName.toString(),
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
                              // showCamera(context, getImage);
                              // Storage.selectImage(context , setUserDp(ImageSource.gallery));
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () {
                                                    setUserDp(
                                                        ImageSource.camera);
                                                  },
                                                  icon: Icon(Icons
                                                      .camera_alt_outlined),
                                                  label: Text('Camera'),
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    setUserDp(
                                                        ImageSource.gallery);
                                                  },
                                                  icon: Icon(Icons
                                                      .add_photo_alternate_outlined),
                                                  label: Text('Gallery'),
                                                )
                                              ],
                                            )
                                          ],
                                        ));
                                  });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(30)),
                              child: 
                                // Storage.downloadedUrl != null ?
                                // Image.network(Storage.downloadedUrl.toString() , height : 100 ,width : 100 ) 
                                //  : Text('image loading'),

                              Storage.userImage == null
                                  ? Image(
                                      height: 60,
                                      width: 60,
                                      image: AssetImage(
                                        'assets/dp/no_user.jpg',
                                      ),
                                    )
                                  : Image.asset(Storage.userImage!,
                                      fit: BoxFit.cover, height: 60, width: 60),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 17,
                            child: Container(
                              alignment: Alignment.center,
                              child: customImageFile == null
                                  ? Icon(Icons.camera_alt,
                                      size: 17, color: grey)
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
                height: MediaQuery.of(context).size.height - 203,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50.0)),
                ),
              ),
            ],
          ),
        ),
        drawer: SlideDrawer(
          primaryColor: primaryColor,
        ));
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
