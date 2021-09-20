// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happytone/screens/home/chatlist.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'package:happytone/shared/reuse.dart';
import 'package:happytone/services/database.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchingKeyWord = '';
  final db = Database();
  QuerySnapshot? searchResultSnapshot;

  searchResults(searchKeyword) async {
    return await db.getUserByEmail(searchKeyword).then((value) {
      // print(" this is the value : $value");

      setState(() {
        searchResultSnapshot = value;
      });
    });
  }

  Widget searchList() {
    return ListView.builder(
        itemCount: searchResultSnapshot?.docs.length,
        itemBuilder: (context, index) {
          final deviceWidth = MediaQuery.of(context).size.width;
          final username = searchResultSnapshot?.docs[index].get('name');
          final useremail = searchResultSnapshot?.docs[index].get('email');
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
                          border: Border.all(width: 1, color: grey))),
                  /* --------------------------------- picture -------------------------------- */
                  backgroundImage:
                      AssetImage('assets/dp/$index.jpg'),
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
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: searchList());
  }
}
