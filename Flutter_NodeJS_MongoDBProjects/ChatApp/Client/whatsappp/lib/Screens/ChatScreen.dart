import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappp/Model/ChatModel.dart';
import 'package:whatsappp/Screens/SelectContactPage.dart';
import 'package:whatsappp/Widgets/Card.dart';
import 'package:whatsappp/Widgets/ContactCard.dart';
import 'package:whatsappp/providers/ChatsProvider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<ChatsNotifierProvider>(context, listen: false).getUserChats();
    super.initState();
  }

  // List<ChatModel> chats = [
  //   ChatModel(
  //       name: "Harshit Rathi",
  //       currentMessage: "Hii",
  //       icon: "p.png",
  //       isGroup: false,
  //       time: "11.05"),
  //   ChatModel(
  //       name: "Dipika Biyani",
  //       currentMessage: "Hii",
  //       icon: "p.png",
  //       isGroup: false,
  //       time: "11.05"),
  // ];
  @override
  Widget build(BuildContext context) {
    //  CourseProvider courseProvider(bool renderUi) =>
    //   Provider.of<CourseProvider>(context, listen: renderUi);
    // ChatsNotifierProvider chatsProvider(bool renderUi) =>
    return Consumer<ChatsNotifierProvider>(builder: (context, chats, snapshot) {
      return Scaffold(
        backgroundColor: Color(0xFF100E20),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SelectContact()));
            },
            child: Icon(Icons.person)),
        body: ListView.builder(
          itemCount: chats.d!.length,
          itemBuilder: (context, index) {
            return Cards(chatModel: chats.d, index: index);
          },
        ),
      );
    });
  }
}
