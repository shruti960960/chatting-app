import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPrefernceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefernceUserNameKey = "USERNAMEKEY";
  static String sharedPrefernceUserEmailKey = "USEREMAILKEY";

  //saving data to SharePreference
static Future<bool> saveuserLoggedInSharedPrefernce(bool isUserLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setBool(sharedPrefernceUserLoggedInKey, isUserLoggedIn);
}

static Future<bool> saveUserNameSharedPreference(String userName) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(sharedPrefernceUserNameKey, userName);
}
  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefernceUserEmailKey, userEmail);
  }

  //getting data from SharedPreferences

  static Future<bool> getUserLoggedInSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPrefernceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefernceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPrefernceUserEmailKey);
  }



}