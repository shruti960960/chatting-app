import 'package:chatting_app/views/signin.dart';
import 'package:flutter/material.dart';

class  Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
