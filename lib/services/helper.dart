// ignore: file_names
// ignore_for_file: prefer_typing_uninitialized_variables, unused_import, unused_local_variable, await_only_futures

import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String spUserLoggedInKey = "ISLOGGEDIN";
  static String spUsernamekey = "USERNAMEKEY";
  static String spUserEmailKey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedInSp(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(spUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUsernameSp(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(spUsernamekey, userName);
  }

  static Future<bool> saveUseremailSp(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(spUserEmailKey, userEmail);
  }

  //getting shared preference
  static Future<bool?> getUserLogginIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(spUserLoggedInKey);
  }

  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(spUsernamekey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(spUserEmailKey);
  }
}
 