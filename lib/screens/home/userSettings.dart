
// ignore: file_namesx
// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors

library flutter_icons;


import 'package:flutter/material.dart';
// import 'package:happytone/services/models.dart';
import 'package:happytone/shared/reuse.dart';

// ignore: must_be_immutable
class UserDetails extends StatefulWidget {
  String heroname;

  UserDetails({required this.heroname});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class User_Icon_name {
  dynamic icon;
  dynamic color;

  User_Icon_name({this.icon, this.color});
}

List<User_Icon_name> icons = [
  User_Icon_name(icon: Icons.attach_email, color: Colors.yellowAccent),
  User_Icon_name(icon: Icons.auto_awesome, color: Colors.blue),
  User_Icon_name(icon: Icons.auto_stories, color: Colors.purpleAccent),
  User_Icon_name(icon: Icons.backup, color: Colors.redAccent),
  User_Icon_name(icon: Icons.beach_access, color: Colors.greenAccent),
  User_Icon_name(icon: Icons.attach_email, color: Colors.yellowAccent),
  User_Icon_name(icon: Icons.auto_awesome, color: Colors.blue),
  User_Icon_name(icon: Icons.auto_stories, color: Colors.purpleAccent),
  User_Icon_name(icon: Icons.backup, color: Colors.redAccent),
  User_Icon_name(icon: Icons.beach_access, color: Colors.greenAccent),

  User_Icon_name(icon: Icons.attach_email, color: Colors.yellowAccent),
  User_Icon_name(icon: Icons.auto_awesome, color: Colors.blue),
  User_Icon_name(icon: Icons.auto_stories, color: Colors.purpleAccent),
  User_Icon_name(icon: Icons.backup, color: Colors.redAccent),
  User_Icon_name(icon: Icons.beach_access, color: Colors.greenAccent),
];

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    // final dWidth = MediaQuery.of(context).size.width;
    // final dHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(

            shadowColor: Colors.red,
            expandedHeight: 200,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: 
                Text(widget.heroname ,style : TextStyle(
                  shadows : [
                    Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 20.0,
  color: black,
      ),
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 8.0,
  color: black,
      ),
                  ]
                )),
              centerTitle: true,
              background: Hero(
                tag: widget.heroname,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: Image.asset('assets/dp/6.jpg', fit: BoxFit.cover)),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildListDelegate(
              [
                for (var i = 0; i < 9; i++)
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: halfwhite.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Icon(icons[i].icon,
                            size: 50, color: icons[i].color),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );


    //   Scaffold(
    //       extendBodyBehindAppBar: true,
    //       appBar: AppBar(
    //         elevation: 0.0,
    //         backgroundColor: Colors.transparent,
    //       ),
    //       body: Column(children: [
    //         // HERO IMAGe
    //         Hero(
    //           tag: widget.heroname.toString(),
    //           child: Image(
    //             fit: BoxFit.cover,
    //             height: 200,
    //             width: dWidth,
    //             image: AssetImage('assets/dp/5.jpg'),
    //           ),
    //         ),

    //         // CONTAINER

    //         ClipRRect(
    //             child: Container(
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage('assets/detail.jpg'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           height: dHeight - 200,
    //           width: dWidth,
    //           child: BackdropFilter(
    //             filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    //             child: ListView(
    //               physics: BouncingScrollPhysics(),
    //               padding: EdgeInsets.all(10),
    //               children: <Widget>[
    //                 for (var i = 0; i < 5; i++)
    //                   Container(
    //                     child: Center(
    //                       child: Icon(icons[i].icon, size: 50, color: icons[i].color),

    //                     ),
    //                     height: 120,
    //                     margin: EdgeInsets.all(5),
    //                     decoration: BoxDecoration(
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Colors.black.withOpacity(0.2),
    //                           spreadRadius: 5,
    //                           blurRadius: 7,
    //                           offset: Offset(0, 3), // changes position of shadow
    //                         ),
    //                       ],
    //                       color: Colors.grey.withOpacity(0.3),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                   ),
    //               ],
    //             ),
    //           ),
    //         )),
    //       ]));
  }
}


class DrawerSettings{

  static bool upload = false ; 
  
}