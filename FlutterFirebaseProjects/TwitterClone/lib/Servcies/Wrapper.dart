
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Screens/SignupPage.dart';
import 'package:twitter/auth/User.dart';
import 'package:twitter/auth/signin.dart';
import 'package:twitter/Screens/HomeScreen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
   @override
  Widget build(BuildContext context) {    
  final user = Provider.of<Users>(context); 
  if(user==null){
    return Signups();
  }else{
    return HomeScreen();
  }
  }
}

//  return StreamProvider<Users>.value(initialData: Authentication().user,value:Authentication().user,child: MaterialApp(home: Wrapper(),),);
