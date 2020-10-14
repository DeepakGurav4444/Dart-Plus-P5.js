import "package:flutter/material.dart";
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/screens/motion_detection_screen.dart';
import 'package:testapp/screens/signup_screen.dart';
import './screens/welcome_screen.dart';

//import "./screens/welcome_screen.dart";
void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kprimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignUpScreen(),
    );
  }
}
