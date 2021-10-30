// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, deprecated_member_use, unused_local_variable, avoid_unnecessary_containers, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import "package:happytone/screens/home/chatlist.dart";
import 'package:happytone/screens/home/chats.dart';
import 'package:happytone/services/helper.dart';
import 'package:happytone/services/models.dart';
import 'package:happytone/shared/loading.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:happytone/services/database.dart';

class Chats extends StatefulWidget {
  final String chatroomId;
  Chats({required this.chatroomId});

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String? message;

  @override
  void initState() {
    super.initState();
    getmessages();
  }

  getmessages() async {
    final result = await db.getMessage(widget.chatroomId);
    setState(() {
      myMessages = result;
      // print("MY MESSAGES : ${myMessages}");
    });
  }

  final db = Database();
  sendMessage() {
    if (message != null && message != '') {
      Map<String, dynamic> messageMap = {
        "message": message.toString(),
        "sendby": Me.myName.toString(),
        "time": Timestamp.now().microsecondsSinceEpoch,
      };

      db
          .createMessage(widget.chatroomId, messageMap)
          .then((value) => print(value));
    }
  }

  Stream? myMessages;

  messagesList() {
    // print(myMessages);
    return StreamBuilder(
        stream: myMessages,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // snapshot.data!.docs[index].get('message')
          ScrollController _controller = ScrollController();

          Timer(
              Duration(milliseconds: 100),
              () => _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.fastOutSlowIn,
                  ));
          return snapshot.hasData
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 80),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final myMessage = snapshot.data!.docs[index].get('message');
                    final sendBy = snapshot.data!.docs[index].get('sendby');
                    final sendTime = snapshot.data!.docs[index].get('time');
                    // print(myMessage);
                    return MessageTile(
                      myMessage: myMessage,
                      sendByMe: sendBy == Me.myName.toString(),
                      time: sendTime,
                    );
                  })
              : SearchLoading();
        });
  }

  @override
  Widget build(BuildContext context) {


    //COLORS

    final scafColor = Theme.of(context).scaffoldBackgroundColor;
    final primaryColor = Theme.of(context).primaryColor;
    final drawerColor = Theme.of(context).primaryColorDark;
    final textColor = Theme.of(context).accentColor;
    TextEditingController inputman = TextEditingController();

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
            centerTitle: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
            title: Text(
              " ${Me.friend?.inCaps} ",
              style: GoogleFonts.aleo(
                fontSize: 25,
                color: primaryColor,
              ),
            ),
            // backgroundColor: Color(0xff4a4e69).withOpacity(0.5),
            backgroundColor: mainYellow,
            ),
        body: Stack(
          children: [
            Container(
              child: messagesList(),
            ),
            Container(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                MESSAGE INPUT                               */
                        /* -------------------------------------------------------------------------- */
                        Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                              child: TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: TextStyle(color: white),
                                controller: inputman,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: Color(0xff4a4e69),
                                  hintText: 'Write your Message ...',
                                  hintStyle: TextStyle(
                                    color: grey,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(50)),
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey.withOpacity(0.5),
                                        width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(50)),
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey.withOpacity(0.5),
                                        width: 1.0),
                                  ),
                                ),
                                // onChanged: (v) {
                                //   setState(() {
                                //     inputman.text = v;
                                //     // message = v.toString();
                                //     print("MESSAGE IS : $message");
                                //     print("INPUT IS : ${inputman.text}");
                                //   });
                                // },
                              ),
                            )),
                        /* -------------------------------------------------------------------------- */
                        /*                                   button                                   */
                        /* -------------------------------------------------------------------------- */
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            padding: EdgeInsets.all(13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50),
                              ),
                            ),
                            color: mainYellow,
                            onPressed: () {
                              setState(() {
                                message = inputman.text;
                                inputman.clear();
                                // print("INPUT IS : ${inputman.text} ");
                                sendMessage();
                              });
                            },
                            child: Icon(Icons.send_rounded, size: 25 , color : darkBg),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class MessageTile extends StatefulWidget {
  String myMessage;
  final time;
  bool? sendByMe;
  MessageTile({required this.myMessage, this.sendByMe, this.time});

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    var timer = Timestamp.fromMicrosecondsSinceEpoch(widget.time);
    var last = timer.toDate();
    var minute = last.minute;
    var hour = last.hour;

    // ('MM/dd/yyyy, hh:mm a').format(myDate);
    // final date = timer.toDate() ;

    return Container(
      alignment:
          widget.sendByMe! ? Alignment.centerRight : Alignment.centerLeft,
      child: ShowUpAnimation(
        curve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        child: Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: 300),
          decoration: BoxDecoration(
            color: widget.sendByMe!
                ? myTileColor
                : Colors.blueGrey,
            border: widget.sendByMe!
                ? Border.all(width: 0)
                : Border.all(
                    width: 0.5,
                    color: Colors.blueGrey,
                  ),
            borderRadius: widget.sendByMe!
                ? BorderRadius.horizontal(left: Radius.circular(20))
                : BorderRadius.horizontal(right: Radius.circular(20)),
          ),
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(12),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: widget.myMessage,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'lato',
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 5.0,
                        color: black.withOpacity(0.5),
                      ),
                    ],
                    // letterSpacing: ,
                  )),
              TextSpan(text: '   '),
              TextSpan(
                  text: '${hour} : ${minute} ',
                  style: TextStyle(
                    color: grey,
                    fontSize: 10,
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
