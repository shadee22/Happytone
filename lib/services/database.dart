// ignore_for_file: non_constant_identifier_names, avoid_print

// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference name_password =
    FirebaseFirestore.instance.collection('Name_Passwords');

class Database {
  getUserData(String username) async {
    return await name_password
        .where('name', isEqualTo: username)
        .get()
        .then((document) {
      return document;
    });

  }

  setUserDetails(register_details_map) {
    final documentName = register_details_map['name'];

    return name_password.doc(documentName).set(register_details_map);
  }

  // one() {
  //   return users.doc(mainUser).set({
  //     'name': mainUser,
  //     'age': 123,
  //   });
  // }

  // two() {
  //   return users.doc(mainUser).snapshots();
  // }
}
