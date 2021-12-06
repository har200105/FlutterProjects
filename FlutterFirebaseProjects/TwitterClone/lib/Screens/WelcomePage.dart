import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:twitter/Screens/SignInpage.dart';
import 'package:twitter/Screens/SignupPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: Container(
        width: 800.0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(EvaIcons.twitter,color: Colors.white,size: 100.0,),
            Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 40.0),
              child: Text("WELCOME TO TWITTER "  ,
              textAlign: TextAlign.center ,style: TextStyle(color: Colors.white)),
            ),
            Container(
              // decoration:
                  // BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                   decoration:BoxDecoration(
                color: Colors.lightBlueAccent,
                  borderRadius:BorderRadius.circular(20.0)
                ),
              width: 250.0,
              height: 50.0,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Log in",style: TextStyle(
                  color:Colors.white
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:28.0),
              child: Container(
                decoration:BoxDecoration(
                color: Colors.white,
                  borderRadius:BorderRadius.circular(20.0)
                ),
                width: 250.0,
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Signups()));
                  },
                  child: Text("Sign up",style: TextStyle(
                    color:Colors.blue
                  ),),
                ),
              ),
            ),
          ])),
    );
  }
}
