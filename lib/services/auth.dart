// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class MainUser {
  String userid;
  MainUser({required this.userid});
}


class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;




  MainUser? mainUser(uid) {
    return uid != null ? MainUser(userid: uid) : null;
  }

  loginInWithEmail(String _email, String _password) async {
    try {
      UserCredential result = await auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((e) {
        print('MAIN ERROR : $e');
        return e;
      });
      User? user = result.user;
      return mainUser(user!.uid);
    } catch (e) {
      print("AUTHENTICATION ERROR : $e");
      return null;
    }
  }

  Future registerWithEmail(String _email, String _password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User? user = result.user;
      print(user);
      print(user!.uid);
      return mainUser(user.uid);
    } catch (r) {
      return r.toString();
    }
  }

  Future resetPassword(String _email) async {
    try {
      return await auth.sendPasswordResetEmail(email: _email);
    } catch (e) {
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      return e.toString();
    }
  }
}
