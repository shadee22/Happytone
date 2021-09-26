// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happytone/shared/reuse.dart';




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
  const SearchLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color : greyBgColor,
      child : SpinKitDoubleBounce(
          color: Colors.orangeAccent,
          size: 100.0,
        )
    );
    
  }
}


class MessageLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
  color: Colors.blueGrey.withOpacity(0.0),
      child : SpinKitThreeBounce(
          color: Colors.blueGrey,
          size: 20.0,
        )
    );
    
  }
}