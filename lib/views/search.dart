import 'package:chatting_app/helper/constants.dart';
import 'package:chatting_app/services/database.dart';
import 'package:chatting_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods =  new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot ;

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val)
    {

      setState(() {
        searchSnapshot = val;

      });

    });
  }

  createChatRoomAndStartConversation(String userName){
    String chatRoomId = getChatRoomId(userName, Constants.myName);
    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "users" : users,
      "chatroomId" : chatRoomId
    };
    databaseMethods.createChatRoom(chatRoomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ));
  }

  Widget searchList() {
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
         return  SearchTile(
           userName: searchSnapshot.documents[index].data["name"],
           userEmail: searchSnapshot.documents[index].data["email"],
         );
        }) : Container();
  }
  
  @override
  void initState(){
        super.initState();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: searchTextEditingController,
                      style: TextStyle(
                          color: Colors.white38
                      ),
                      decoration: InputDecoration(

                        hintText: 'Search username..',
                            hintStyle: TextStyle(
                              color: Colors.white38
                            ),
                          border: InputBorder.none
                      )
                  ),),

                  GestureDetector(
                    onTap: (){
                        initiateSearch();
                          
                        
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF),
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;
  SearchTile({this.userName,this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: mediumTextStyle(),),
              Text(userEmail, style: mediumTextStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message", style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else{

    return "$a\_$b";
  }
}

