import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/Servcies/User.dart';
import 'package:twitter/auth/Authentication.dart';

import 'HomeScreen.dart';



class Signups extends StatefulWidget {
  @override
  _SignupsState createState() => _SignupsState();
}

class _SignupsState extends State<Signups> {

  String url;
  UserDetails userDetails = UserDetails();
  final picker = ImagePicker();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Authentication auth = Authentication();
  String email="";
  String password="";
  String imageUrl ="";
  String name ="";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Colors.lightBlueAccent[200],
      appBar: AppBar(
        backgroundColor:Colors.lightBlueAccent,
        elevation: 8,
        title: Text("Twitter",style: TextStyle(
          color:Colors.white
        ),),
        centerTitle: true,
      ),
      body: Container(
        
        padding:EdgeInsets.symmetric(vertical: 30,horizontal: 50),
        child: Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: Form(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom:20.0,top: 10.0),
                  child: Icon(EvaIcons.twitter,color:Colors.white,size: 60.0,),
                ),

                TextFormField(
                  onChanged:(val){
                    setState((){
                      email=val;
                      name = email.replaceAll("@", "");
                    });
                  },
                  decoration:  InputDecoration(
                                hintText: "ENTER EMAIL",
                                 border: OutlineInputBorder(),
                                hintStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Comic',
                                    color: Colors.white
                                    ),
                              ),
                            
                ),Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: TextFormField(
                    obscureText: true,
                    onChanged:(val){
                      setState((){
                        password=val;
                      });
                    },
                    decoration:  InputDecoration(
                                  hintText: "ENTER PASSWORD",
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
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
                    onPressed: ()async{
                  auth.signUp(email, password,name).whenComplete(() => {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())),
                  });
                },
                    child: Text("Sign up",style: TextStyle(
                      color:Colors.blue
                    ),),
                  ),
                ),
              ), 

                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// onPressed: ()async{
//                 auth.signUp(email, password,name).then((e) => {
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())),
//                   print(e)
//                 });
//               },




//  onPressed: ()async{
//                   auth.signUp(email, password,name).whenComplete(() => {
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())),
//                   });
//                 },