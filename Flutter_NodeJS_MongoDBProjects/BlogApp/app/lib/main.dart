import 'package:blogapp/Pages/HomePage.dart';
import 'package:blogapp/Providers/BlogProvider.dart';
import 'package:blogapp/Services/Utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/LoadingPage.dart';
import 'Pages/WelcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  Widget page = LoadingPage();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = HomePage();
      });
    } else {
      setState(() {
        page = WelcomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UtilityNotifier()),
        ChangeNotifierProvider(create: (_) => BlogProvider())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
            fontFamily: "Poppins",
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.black)),
        home: page,
      ),
    );
  }
}
