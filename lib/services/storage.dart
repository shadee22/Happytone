import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  uploadFile(File file, username) async {
    try {
      var ref = FirebaseStorage.instance.ref().child('user/${username}.jpg');

      var uploadFile = ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future gettingImage(username) async {
    try {
      var ref =
          await FirebaseStorage.instance.ref().child('user/${username}.jpg');
      var url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      // print(e.toString());
      return null;
    }
  }
}
