import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Screens/LoginScreen.dart';
import 'package:whatsappp/Screens/SplashScreen.dart';
import 'package:whatsappp/Services/Cache.dart';
import 'package:whatsappp/views/Home.dart';

class Decider extends StatefulWidget {
  const Decider({Key? key}) : super(key: key);

  @override
  _DeciderState createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  @override
  Widget build(BuildContext context) {
    final cache = Cache();
    return FutureBuilder(
      future: cache.readCache(key: "jwt"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.hasData) {
          return Home();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
