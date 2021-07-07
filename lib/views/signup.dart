import 'package:chatting_app/helper/helperfunctions.dart';
import 'package:chatting_app/services/auth.dart';
import 'package:chatting_app/services/database.dart';
import 'package:chatting_app/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'chatRoomScreen.dart';

class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState  extends State<SignUp>{

  bool isLoading = false;
  AuthMethods authMethods =  new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions =  new HelperFunctions();


  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()) {

      Map<String, String> userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text,
      };


      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPreference(userNameTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
       // print("${val.uid}");


        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:
        (context) => ChatRoom()
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
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
                                return val.isEmpty || val.length < 2 ? "Please provide valid Username" : null;
                              },
                                controller: userNameTextEditingController,
                                style: simpleTextStyle(),
                                decoration: textFieldInputDecoration("Username")

                            ),
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
                                controller: passwordTextEditingController,
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
                      signMeUp();
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
                        child: Text("Sign Up",style: mediumTextStyle()),
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
                      child: Text("Sign Up with Google",style: mediumTextStyle()),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have account? ",style: simpleTextStyle()

                        ),
                        Text("SignIn now",style: TextStyle(
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
          ) ),
    );
  }

}