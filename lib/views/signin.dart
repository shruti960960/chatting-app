import 'package:chatting_app/helper/helperfunctions.dart';
import 'package:chatting_app/services/auth.dart';
import 'package:chatting_app/services/database.dart';
import 'package:chatting_app/views/chatRoomScreen.dart';
import 'package:chatting_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController passwordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  SignIn(){
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      //HelperFunctions.saveUserEmailSharedPreference(userNameTextEditingController.text);
      setState(() {
        isLoading = true;
      });

      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserEmailSharedPreference(snapshotUserInfo.documents[0].data["name"]);
      });

      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val) {
        if(val != null){

          HelperFunctions.saveuserLoggedInSharedPrefernce(true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body : SingleChildScrollView(
        child: Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height-200,
        child : Container(

          padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Please Provide valid email" ;
                      },
                      controller: emailTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Email")

                  ),
                  TextFormField(
                    obscureText: true,
                      validator: (val){
                        return val.length > 6 ? null : "Please Provide 6 digit password";
                      },
                      controller:  passwordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Password")
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Container(
              alignment: Alignment.centerRight,
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Text("Forgot Password", style: simpleTextStyle(),),
                ),
            ),
            SizedBox(height: 8,),
            GestureDetector(
              onTap: (){

                SignIn();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC),

                    ]
                  ),
                      borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Sign In",style: mediumTextStyle()),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(

                    color: Colors.white,

                borderRadius: BorderRadius.circular(30),
              ),
              child: Text("Sign In with Google",style: mediumTextStyle()),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account? ",style: simpleTextStyle()

                ),
                Text("Register now",style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ))
              ],
            ),
            SizedBox(height: 50,),

          ],
        ),
      )
        ) ));
  }
}
