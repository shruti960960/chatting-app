import 'package:chatting_app/views/signup.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/material/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primaryColor: Colors.lightGreen.shade900,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(),
    );
  }
}


