import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:twitter/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Screens/WelcomePage.dart';
import 'package:twitter/auth/Authentication.dart';
import 'package:twitter/auth/User.dart';
import 'package:twitter/Servcies/Wrapper.dart';
import 'package:twitter/auth/signin.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//   StreamProvider<Users> onNow(){
// return StreamProvider<Users>.value(initialData: Authentication().user,value:Authentication().user,child: MaterialApp(home: Wrapper(),),);
//   }
  @override
  void initState() {
    Timer(Duration(seconds:4),()=>{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()))

      
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        child:Center(
          child:Icon(EvaIcons.twitter,color:Colors.white,size: 80.0,)
        )
      ),
    );
  }
}