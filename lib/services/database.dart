// ignore_for_file: non_constant_identifier_names, avoid_print, invalid_return_type_for_catch_error

// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:happytone/services/models.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference name_password =
    FirebaseFirestore.instance.collection('Name_Passwords');

CollectionReference chatroom =
    FirebaseFirestore.instance.collection('chatroom');

class Database {
  getUserByUsername(String username) async {
    return await name_password
        .where('name', isEqualTo: username)
        .get()
        .then((document) {
      return document;
    });
  }

  getUserByEmail(String email) async {
    return await name_password
        .where('email', isEqualTo: email)
        .get()
        .then((document) {
      return document;
    });
  }

  Stream<QuerySnapshot> allusers = name_password.snapshots();
  Stream<QuerySnapshot> allUserMessages = chatroom.doc().collection('chats').snapshots();

  // Stream<QuerySnapshot> gettingAllMessages() {
  //   return chatroom.doc('jhonson_kadharin').collection('chats').orderBy('time').snapshots();
  //   // return chatroom.doc('jhonson_kadharin').collection('chats').orderBy('time').snapshots();
  // }

  setUserDetails(register_details_map) {
    final documentName = register_details_map['name'];
    return name_password.doc(documentName).set(register_details_map);
  }

  setUserOnline(username) {
    return name_password.doc(username).update({"isOnline": true});
  }

  setUserOffline(username) {
    return name_password.doc(username).update({"isOnline": false});
  }

  createChatRoom(String chatroomId, chatroomMap) async {
    return await chatroom
        .doc(chatroomId)
        .set(chatroomMap)
        .catchError((er) => print(er));
  }

  createMessage(chatroomid, messageMap) async {
    return await chatroom.doc(chatroomid).collection('chats').add(messageMap);
  }

  getMessage(chatroomid)  {
    Stream<QuerySnapshot> allMessages = chatroom
        .doc(chatroomid)
        .collection('chats')
        .orderBy('time')
        .snapshots();
    return allMessages;
  }

  
}
