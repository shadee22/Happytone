// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orangeAccent,
        child: SpinKitWave(
          color: Colors.black,
          size: 60.0,
        ));
  }
}

class SearchLoading extends StatelessWidget {
  Color? bgColor;
  SearchLoading({this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor,
        child: SpinKitDoubleBounce(
          color: Colors.orangeAccent,
          size: 100.0,
        ));
  }
}

class MessageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.withOpacity(0.0),
        child: SpinKitThreeBounce(
          color: Colors.blueGrey,
          size: 20.0,
        ));
  }
}
