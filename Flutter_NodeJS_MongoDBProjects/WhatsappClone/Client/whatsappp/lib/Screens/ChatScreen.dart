import 'package:flutter/material.dart';
import 'package:whatsappp/Model/ChatModel.dart';
import 'package:whatsappp/Widgets/Card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> chats=[
    ChatModel(name: "Harshit Rathi", currentMessage: "Hii", 
    icon: "p.png", isGroup: false, time: "11.05"),
    ChatModel(name: "Dipika Biyani", currentMessage: "Hii", 
    icon: "p.png", isGroup: false, time: "11.05"),
    ChatModel(name: "Riya Dhanwani", currentMessage: "Hii", 
    icon: "p.png", isGroup: false, time: "11.05")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.chat)),
          body: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context,index){
            return Cards(chatModel: chats[index]);
            },

          ),
    );
  }
}
