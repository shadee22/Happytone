// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, unused_local_variable, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_is_empty, unnecessary_this, unnecessary_brace_in_string_interps

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happytone/services/helper.dart';
import 'package:happytone/services/database.dart';
import 'package:happytone/shared/reuse.dart';

class Chatters {
  final String name;
  final String? message;
  final int? picture;
  Chatters({required this.name, this.message, this.picture});
}

List<Chatters> chats = [
  Chatters(
      name: '+0750278330',
      message: 'Hi... This App Gonna Viral One Day',
      picture: 0),
  Chatters(name: 'Shadeer', message: 'What Are You Doing', picture: 1),
  Chatters(
      name: 'Zakeer', message: 'Enna thaan panna Thala eluthu', picture: 2),
  Chatters(
      name: 'Account Sir', message: 'Meh ganan hadhanna lamaya', picture: 3),
  Chatters(name: 'Gotabaya', message: 'Api thamai hondhatama Kare', picture: 4),
  Chatters(
      name: 'PHI',
      message: 'Kohedha Vaccine aduwata ganna puluwan',
      picture: 5),
  Chatters(name: 'Sharu', message: 'nalladhee nadakum', picture: 6),
  Chatters(name: 'Poona', message: 'Meow Meow enaku Pasikudhu daa', picture: 7),
  Chatters(
      name: 'Hecker', message: 'I am Hacked Your Account Man!!', picture: 8),
];

class Chatlist extends StatefulWidget {
  @override
  State<Chatlist> createState() => _ChatlistState();
}

class Users {
  String? username;
  String? email;

  Users({this.username, this.email});
}

class _ChatlistState extends State<Chatlist> {
  final db = Database();
  QuerySnapshot? allusers;

  // listers(allusers) {
  //   return SearchTile(
  //     username: allusers.docs[0].get('name'),
  //     useremail: allusers.docs[0].get('email'),
  //   );
  // }

  @override
  void initState() {
    super.initState();
  }

  final mainUseremail = Helper.getUserEmail();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Chip(label: Text("USEREMAIL IS : ${mainUseremail}")),
        StreamBuilder<QuerySnapshot>(
            stream: db.allusers,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                Chip(label: Text('Somthing Wrong No Dat'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              // ${snapshot.data.docs[0].get("name")}
              // ${mainuser[index].get('name')}
              // final mainuser = snapshot.data.docs;
              /* -------------------------------- maintile -------------------------------- */

              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    //VARIABLES
                    final username =
                        snapshot.data.docs[index].get("name").toString().inCaps;
                    final useremail = snapshot.data.docs[index]
                        .get("email")
                        .toString()
                        .inCaps;
                    final userpassword = snapshot.data.docs[index]
                        .get("password")
                        .toString()
                        .inCaps;

                    return ShowUpAnimation(
                        animationDuration: Duration(milliseconds: 1000),
                        curve: Curves.elasticInOut,
                        direction: Direction.horizontal,
                        offset: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          height: 80,
                          width: deviceWidth - 30,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(3),
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.blue,
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border:
                                          Border.all(width: 1, color: grey))),
                              /* --------------------------------- picture -------------------------------- */
                              backgroundImage:
                                  AssetImage('assets/dp/$index.jpg'),
                            ),
                            /* ---------------------------------- name ---------------------------------- */
                            title: Text(
                              username,
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                            /* --------------------------------- message -------------------------------- */

                            subtitle: Text(useremail.toString(),
                                style: TextStyle(
                                  color: white.withOpacity(0.5),
                                )),
                          ),
                        ));
                  });
            }),
      ],
    );
  }

  // return SingleChildScrollView(
  //   physics: BouncingScrollPhysics(),
  //   child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       for (var chatuser in chats)
  //         ShowUpAnimation(
  //           delayStart: Duration(milliseconds: 300),
  //           animationDuration: Duration(milliseconds: 1000),
  //           curve: Curves.elasticInOut,
  //           direction: Direction.horizontal,
  //           offset: 1,
  //           child: Container(
  //             margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //             height: 80,
  //             width: deviceWidth - 30,
  //             decoration: BoxDecoration(
  //               color: Colors.blueGrey.withOpacity(0.2),
  //               borderRadius: BorderRadius.circular(50.0),
  //             ),
  //             child: ListTile(
  //               contentPadding: EdgeInsets.all(3),
  //               leading: CircleAvatar(
  //                 radius: 35,
  //                 backgroundColor: Colors.blue,
  //                 child: Container(
  //                     height: 60,
  //                     width: 60,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50),
  //                         border: Border.all(width: 1, color: grey))),
  //                 /* --------------------------------- picture -------------------------------- */
  //                 backgroundImage:
  //                     AssetImage('assets/dp/${chatuser.picture}.jpg'),
  //               ),
  //               /* ---------------------------------- name ---------------------------------- */
  //               title: Text(
  //                 chatuser.name.toString(),
  //                 style: TextStyle(
  //                   color: white,
  //                 ),
  //               ),
  //               /* --------------------------------- message -------------------------------- */

  //               subtitle: Text(chatuser.message.toString(),
  //                   style: TextStyle(
  //                     color: white.withOpacity(0.5),
  //                   )),
  //             ),
  //           ),
  //         ),
  //     ],
  //   ),
  // );
}

class SearchTile extends StatelessWidget {
  final String? username;
  final String? useremail;

  SearchTile({this.username, this.useremail});

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
