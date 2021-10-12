// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happytone/screens/home/chatlist.dart';
import 'package:happytone/screens/home/chats.dart';
import 'package:happytone/services/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happytone/services/models.dart';
import 'package:happytone/shared/loading.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'package:happytone/shared/reuse.dart';
import 'package:happytone/services/database.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final db = Database();

  QuerySnapshot? searchResultSnapshot;

  /* ------------------------------- mainUserame ------------------------------ */
  String? mainUsername;
  String? secondUsername;

  @override
  void initState() {
    
    super.initState();
  }


final Widget svg = SvgPicture.asset('assets/search.svg',
    fit: BoxFit.contain, height: 200, width: 200,);

  

  bool checkEmpty = true;

  searchResults(searchKeyword) async {
    if (searchKeyword != mainUsername) {
      return await db.getUserByUsername(searchKeyword).then((value) {
        // print(" this is the value : $value");
        
        setState(() {
          searchResultSnapshot = value;
          final one = searchResultSnapshot?.docs.length;
          if (one != 0) {
            secondUsername = searchResultSnapshot?.docs.first.get('name');
            Me.friend = secondUsername;
          }
        });
      });
    }
  }

  createChat() async {
    String chatroomId = getChatroomId(Me.myName!, secondUsername!);
    List<String> users = [
      Me.myName.toString(),
      secondUsername.toString(),
    ];
    Map<String, dynamic> chatroomMap = {
      "chatroomId ": chatroomId,
      "users": users,
    };
    db.createChatRoom(chatroomId, chatroomMap);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Chats(chatroomId: chatroomId,)));
  }

  @override
  Widget build(BuildContext context) {

    print('MY NAME IS : ${Me.myName}');
    print('SECOND USERNAME IS : $secondUsername');
    
    return Scaffold(
        backgroundColor: greyBgColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: logoColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: TextField(
            onChanged: (value) {
              searchResults(value);
              setState(() {
                value.isEmpty ? checkEmpty = true : checkEmpty = false;
              });
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
                hintText: " Search Here ! ",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.blueGrey,
                  onPressed: () {},
                )),
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 20),
          ),
          backgroundColor: greyBgColor,
        ),
        body: checkEmpty
            ? Center(child: Column(
              children: [
                SizedBox(height: 100,),
                svg,
                SizedBox(height: 30,),

                SearchLoading()
              ],
            ))
            : ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                itemCount: searchResultSnapshot?.docs.length,
                itemBuilder: (context, index) {
                  final deviceWidth = MediaQuery.of(context).size.width;
                  final username =
                      searchResultSnapshot?.docs[index].get('name');
                  final useremail =
                      searchResultSnapshot?.docs[index].get('email');
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
                        contentPadding: EdgeInsets.all(5),
                        trailing: GestureDetector(
                          onTap: () {
                            createChat();
                          },
                          child: Chip(
                            label: Text('Message'),
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.blue,
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 1, color: grey))),
                          /* --------------------------------- picture -------------------------------- */
                          backgroundImage: AssetImage('assets/dp/$index.jpg'),
                        ),
                        /* ---------------------------------- name ---------------------------------- */
                        title: Text(
                          username.toString(),
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
                    ),
                  );
                }));
  }
}

getChatroomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
