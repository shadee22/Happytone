// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:happytone/shared/reuse.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

Widget story(context, i) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Status(i: i),
        ),
      );
    },
    child: Hero(
      tag: '$i',
      child: Padding(
        padding: EdgeInsets.all(3),
        child: OutlineGradientButton(
          padding: EdgeInsets.all(3),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/dp/${i - 1}.jpg'),
          ),
          radius: Radius.circular(50),
          strokeWidth: 2.5,
          gradient: LinearGradient(colors: [
            Theme.of(context).hintColor,
            Colors.blueGrey,
            Theme.of(context).hintColor,
          ]),
        ),
      ),
    ),
  );
}

class Status extends StatelessWidget {
  final i;
  Status({required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: black,
      appBar: AppBar(
        title: Text('Status'),
        toolbarTextStyle: TextStyle(color: white),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox.expand(
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
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                Hero(
                  tag: "$i",
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
                Text(
                  captionList[i],
                  style: robotoFont.copyWith(color: white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
