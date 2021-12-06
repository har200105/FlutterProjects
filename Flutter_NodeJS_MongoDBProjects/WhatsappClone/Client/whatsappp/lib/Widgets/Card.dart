import 'package:flutter/material.dart';
import 'package:whatsappp/Model/ChatModel.dart';
import 'package:whatsappp/Screens/SingleChatPage.dart';

class Cards extends StatelessWidget {
  const Cards({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingleChatPage()));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/g.png"),
              backgroundColor: Colors.white54,
              radius: 20,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all, color: Colors.blue),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            trailing: Text("11:04 "),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
