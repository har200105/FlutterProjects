import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Model/ChatModel.dart';
import 'package:whatsappp/Screens/SingleChatPage.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key, this.chatModel, required this.index}) : super(key: key);
  final List<Data>? chatModel;
  final int index;

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
    String? myId="";
    String? chatname="";
    String? chatPic="";
    String chatUserId="";
   void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myId = prefs.getString("id");
    });
      for(int i=0;i<widget.chatModel![widget.index].users.length;i++){
        if(widget.chatModel![widget.index].users[i].id != myId){
          setState(() {
            chatname = widget.chatModel![widget.index].users[i].name;
            chatPic = widget.chatModel![widget.index].users[i].pic;
            chatUserId = widget.chatModel![widget.index].users[i].id;
          });
        }
      }
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SingleChatPage(
                  chatId: widget.chatModel![widget.index].id,chatName: chatname,
                  otherUserId:chatUserId)));
      },
      child: Column(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left:15.0,top:10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(chatPic!),
                backgroundColor: Colors.white,  
                radius: 20,
              ),
            ),
            title: Text(
               chatname!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Divider(
              thickness: 1,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
