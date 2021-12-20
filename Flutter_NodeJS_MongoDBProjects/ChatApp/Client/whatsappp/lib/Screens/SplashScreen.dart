import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsappp/Screens/Decider.dart';
import 'package:whatsappp/Screens/SignupScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
        () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Decider()))
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF100E20),
      body: Container(
        child: Center(
          child: Text("Chatify",style: TextStyle(
            color: Colors.white,
            fontSize: 30.0
          ),),
        ),
      ),
    );
  }
}
