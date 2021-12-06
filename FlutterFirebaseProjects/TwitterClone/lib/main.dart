import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter/Screens/SplashScreen.dart';
import 'package:twitter/auth/signin.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Homepage());
}


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  
      debugShowCheckedModeBanner: false,
      title: "Twitter",
      theme: ThemeData(
        primarySwatch:Colors.lightBlue,
        visualDensity:VisualDensity.adaptivePlatformDensity
      ),
      home: SplashScreen(),
    );
  }
}