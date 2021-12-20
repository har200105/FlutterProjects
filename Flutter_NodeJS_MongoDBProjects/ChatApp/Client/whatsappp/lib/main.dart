
import 'package:flutter/material.dart';
import 'package:whatsappp/Model/User.dart';
import 'package:whatsappp/Screens/CameraScreen.dart';
import 'package:whatsappp/Screens/SignupScreen.dart';
import 'package:whatsappp/Screens/SplashScreen.dart';
import 'package:whatsappp/Services/Utility.dart';
import 'package:whatsappp/providers/AuthenticationProvider.dart';
import 'package:whatsappp/providers/ChatsProvider.dart';
import 'package:whatsappp/providers/MessageProvider.dart';
import 'package:whatsappp/providers/UsersProvider.dart';
import 'package:whatsappp/views/Home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = User("Harshit", "Harshitr2001@gmail.com");
    // print(user.toJson());
    // final s = User.fromJson(user.toJson());
    // print(s.name);
    // print(s.email);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => ChatsNotifierProvider()),
        ChangeNotifierProvider(create: (_) => UserProviderNotifier()),
        ChangeNotifierProvider(create: (_) => MessageNotifierProvider()),
        ChangeNotifierProvider(create: (_) => UtilityNotifier()),
        // ChangeNotifierProvider(create: (_) => Mess())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "OpenSans",
            primaryColor: Color(0xFF075E54),
            accentColor: Color(0xFF128C7E)),
        home: SplashScreen(),  
      ),
    );
  }
}
