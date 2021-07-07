import 'package:chatting_app/helper/authenticate.dart';
import 'package:chatting_app/helper/constants.dart';
import 'package:chatting_app/helper/helperfunctions.dart';
import 'package:chatting_app/services/auth.dart';
import 'package:chatting_app/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget{
  @override
  _ChatRoomState createState() => _ChatRoomState();

}

class _ChatRoomState extends State<ChatRoom>{
  
  AuthMethods authMethods = new AuthMethods();
  @override
  void initState() {
getUserInfo();
super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png",height: 50,),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate(),
              ) );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app)),
          )
        ],

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()
          ) );
        },
      ),
    );
  }

}