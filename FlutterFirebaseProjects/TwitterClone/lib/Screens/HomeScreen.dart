import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/Screens/Add.dart';
import 'package:twitter/Screens/Edit.dart';
import 'package:twitter/Screens/Home/Feed.dart';
import 'package:twitter/Screens/Home/Messages.dart';
import 'package:twitter/Screens/Home/Notifications.dart';
import 'package:twitter/Screens/Home/Search.dart';
import 'package:twitter/Screens/SignupPage.dart';
import 'package:twitter/Screens/WelcomePage.dart';
import 'package:twitter/auth/Authentication.dart';
import 'package:twitter/auth/User.dart';
import 'package:twitter/auth/signin.dart';
import 'Profile.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Servcies/User.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    Authentication auth = Authentication();
    int currentIndex = 0;
    final List<Widget> pages = [
      Feed(),
      Search(),
      Notifications(),
      Messages(),

    ];

    void onTabChanged(int index){
      setState(() {
        currentIndex = index;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      appBar: AppBar(
        backgroundColor:Colors.lightBlue[450],
        centerTitle: true,
        title: Icon(EvaIcons.twitter,color: Colors.white,size: 30.0,),
      ),  
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[300],
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddTweet()));
        },
        child: Icon(EvaIcons.twitterOutline),
      ),
      drawer: Drawer(
        
        child: ListView(
          
          children:[
            Padding(
              padding: const EdgeInsets.only(top:25.0,bottom: 10.0),
              child: ListTile(title:Text("Profile"),onTap:(){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile(getUid: FirebaseAuth.instance.currentUser.uid)));
              }),
            ),
            ListTile(title:Text("Logout"),onTap:()async{
              await auth.signOut().then((value) => {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()))
              });
            }),
            Divider(),

            
          ]
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChanged,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label:"Search"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label:"Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.mail),label:"Message"),

        ],
      ),
      body: pages[currentIndex],
    );
  }
}

