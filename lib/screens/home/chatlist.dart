// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, unused_local_variable, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_is_empty, unnecessary_this, unnecessary_brace_in_string_interps, prefer_const_declarations, unnecessary_string_escapes, sized_box_for_whitespace

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'dart:async';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:happytone/screens/home/userSettings.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:happytone/screens/home/chats.dart';
import 'package:happytone/services/models.dart';
import 'package:happytone/services/storage.dart';
import 'package:happytone/shared/loading.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:happytone/services/helper.dart';
import 'package:happytone/services/database.dart';
import 'package:happytone/shared/reuse.dart';
import 'dart:math';

class Chatlist extends StatefulWidget {
  @override
  State<Chatlist> createState() => _ChatlistState();
}

class _ChatlistState extends State<Chatlist> {
  @override
  void initState() {
    super.initState();
  }

  final db = Database();
  Random random = Random();

  Future? chatroomId;

  @override
  Widget build(BuildContext context) {
    // String? dpUrl;
    // final dpUrl =
    //     Storage().gettingImage(Me.myName.toString().toUpperCase()).then((v) {});

    // print("my url " + " $dpUrl");

    //COLORS

    String myname = Me.myName.toString().toUpperCase();
    String? one;

    Storage().gettingImage(myname).then((v) {
      setState(() {
        one = v;
      });
      return v;
    });

    final scafColor = Theme.of(context).scaffoldBackgroundColor;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).accentColor;

    File? imageFile;

    // Future getImage() async {
    //   var image = await ImagePicker().pickImage(source: ImageSource.camera);

    //   setState(() {
    //     if (this.mounted) {
    //       imageFile = File(image!.path);
    //     }
    //   });
    //   print('customImageFile: $imageFile ');
    // }

    final deviceWidth = MediaQuery.of(context).size.width;
    final data = db.allusers;

    return StreamBuilder<QuerySnapshot>(
        stream: db.allusers,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            Chip(label: Text('Somthing Wrong No Data'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SearchLoading();
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
                child: Chip(
              backgroundColor: Colors.redAccent,
              label: Text(
                "THERE IS NO ENTERNET",
                style: TextStyle(color: white),
              ),
            ));
          }

          /* -------------------------------- maintile -------------------------------- */
          // print(snapshot.data.docs.first.get('name'));
          List<dynamic> alldata = snapshot.data.docs.toList();

          startChat(username) async {
            List<String> users = [username, Me.myName.toString()];
            setState(() {
              Me.friend = username;
            });

            final chatroomId = getChatroomId(username, Me.myName.toString());
            print("MYNAME IS : ${Me.myName}");
            Map<String, dynamic> chatroomMap = {
              'chatroomId': chatroomId,
              'users': users
            };

            print("CHATROOMID : $chatroomId");

            db.createChatRoom(chatroomId, chatroomMap);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chats(
                  chatroomId: chatroomId,
                ),
              ),
            );
          }

          //dp from storage

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                  
                // FutureBuilder(
                //     future: Storage().gettingImage(myname),
                //     builder: (context, snap) {
                //       if (snap.hasError) {
                //         return Text('has error');
                //       }
                //       if (snap.hasData) {
                //         return Image(
                //           fit: BoxFit.cover,
                //           height: 100,
                //           width: 100,
                //           image: NetworkImage(
                //             "${snap.data.toString()}",
                //           ),
                //         );
                //       }
                //       return FlutterLogo();
                //     }),
                // Storage().gettingImage('karmaar').then((v) {
                //   v.toString();
                //   return Image(
                //     height: 100,
                //     width: 100,
                //     image: NetworkImage(v!),
                //   );
                // }),
                for (var main in alldata)
                  if (main.get('name') != Me.myName)
                      ShowUpAnimation(
                        animationDuration: Duration(milliseconds: 1000),
                        curve: Curves.elasticInOut,
                        direction: Direction.horizontal,
                        offset: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 80,
                          width: deviceWidth - 30,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: ListTile(
                            onTap: () {
                              startChat(
                                main.get('name'),
                              );
                            },
                            contentPadding: EdgeInsets.all(3),
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserDetails(heroname: main.get('name')),
                                  ),
                                );
                              },
                            // child: Text("shadeer"),),
                              // child: FutureBuilder(
                              //     future: Storage().gettingImage('KARMER'),
                              //     builder: (context, snap) {
                              //       if (snap.hasError) {
                              //         return FlutterLogo();
                              //       }


                                    // if (snap.hasData) {
                                     child :  Hero(
                                        tag: '${main.get('name')}',
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.blue,
                                          // backgroundImage: AssetImage('assets/dp/15.jpg'),
                                          backgroundImage:
                                          // NetworkImage(snap.data.toString()),
                                              AssetImage('assets/dp/5.jpg'),
                                          child: Column(
                                            children: [
                                              main.get('isOnline')
                                                  ? Container(
                                                      alignment:
                                                          Alignment.topRight,
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              40, 36, 0, 0),
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: grey),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 20,
                                                      width: 20,
                                                    )
                                            ],
                                          ),
                                          /* --------------------------------- picture -------------------------------- */
                                          // foregroundImage: AssetImage('assets/dp/15.jpg'),
                                        ),
                                      ),
                              //       }

                              //       return FlutterLogo();;
                              //     }),
                            ),
                            /* ---------------------------------- name ---------------------------------- */
        
                            title: Text(
                              // username,
                              main.get('name').toString().inCaps
                              // "shadeer"
                              ,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            /* --------------------------------- message -------------------------------- */

                            // subtitle: Text(
                            //   // userpassword.toString(),
                            //   "${main.get('email')} ",
                            //   style: TextStyle(
                            //     color: white.withOpacity(0.5),
                            //   ),
                            // ),

                            subtitle: StreamBuilder<QuerySnapshot>(
                              stream: db.allUserMessages,
                              builder: (BuildContext context,
                                  AsyncSnapshot _snapshot) {
                                if (_snapshot.hasError) {
                                  Chip(label: Text('Somthing Wrong No Data'));
                                }
                                if (_snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // return MessageLoading();
                                  return Text("Message loading ...",
                                      style: TextStyle(
                                          color: textColor.withOpacity(0.5)));
                                }

                                final chatroomId = getChatroomId(
                                  main.get('name'),
                                  Me.myName.toString(),
                                );
                                // print(chatroomId);

                                Stream<QuerySnapshot> mainData =
                                    db.getMessage(chatroomId);

                                return StreamBuilder<QuerySnapshot?>(
                                    stream: mainData,
                                    builder: (context, mainSnapshot) {
                                      if (mainSnapshot.hasError) {
                                        return Text('Something Went Wrong');
                                      }
                                      if (_snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Message loading ...",
                                            style: TextStyle(color: grey));
                                      }

                                      errors() {
                                        try {
                                          final lm = mainSnapshot
                                              .data?.docs.last
                                              .get('message');
                                          return lm;
                                        } catch (e) {
                                          print(e);
                                        }
                                      }

                                      return Text(
                                        "${errors() ?? 'No messages Yet'}",
                                        style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      )
              ],
            ),
          );
        });
  }
}

class SearchTile extends StatelessWidget {
  final String? username;
  final String? useremail;

  const SearchTile({this.username, this.useremail});

  @override
  Widget build(BuildContext context) {
    print("USERNAME : $username");
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (x, i) {
        return ListTile(
          leading: Text(username.toString()),
        );
      },
    );
  }
}

getChatroomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
