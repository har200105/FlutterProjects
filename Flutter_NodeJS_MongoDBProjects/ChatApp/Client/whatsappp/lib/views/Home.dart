import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Screens/ChatScreen.dart';
import 'package:whatsappp/Screens/LoginScreen.dart';
import 'package:whatsappp/providers/ChatsProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
 @override
  void initState() {
    Provider.of<ChatsNotifierProvider>(context, listen: false).getUserChats();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF100E20),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Chatify"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("jwt");
                    prefs.remove("id");
                    prefs.clear();
                    Future.delayed(
                        Duration(seconds: 2),
                        () => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()))
                            });
                  },
                  icon: Icon(Icons.logout)),
            )
          ],
        ),
        body: ChatScreen());
  }
}
