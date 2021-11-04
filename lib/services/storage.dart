// // ignore_for_file: unused_local_variable, await_only_futures, avoid_print

// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Storage {
  static String? userImage;
  static String? downloadedUrl;

  static List images = [];

  static getFile(username)async{
    try {
      var ref = FirebaseStorage.instance.ref().child('new/$username.jpg');

      downloadedUrl = await  ref.getDownloadURL();
      Fluttertoast.showToast(msg: downloadedUrl.toString());

    } catch (e) {
      print(e);
    }
  }

  
  static uploadFile(File file, username) async {
    // Fluttertoast.showToast(msg: "Working On it");
    try {
      var ref = FirebaseStorage.instance.ref().child('new/$username.jpg');

      var uploadTask = ref.putFile(file);
    // Fluttertoast.showToast(msg: "File Is Loading");

      await uploadTask.whenComplete(() {
        Fluttertoast.showToast(msg: "Image Uploaded");
      });
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
//
}



//   Future gettingImage(username) async {
//     try {
//       var ref =
//           await FirebaseStorage.instance.ref().child('user/$username.jpg');
//       var url = await ref.getDownloadURL();
//       return url;
//     } on FirebaseException catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }

// //  final storage = FirebaseStorage.instanceFor(
// //                           bucket: " gs://happytone-c9209.appspot.com");
// //                       if (customImageFile != null) {
// //                         Storage().uploadFile(customImageFile!,
// //                             Me.myName.toString().toUpperCase());
// //                       }
