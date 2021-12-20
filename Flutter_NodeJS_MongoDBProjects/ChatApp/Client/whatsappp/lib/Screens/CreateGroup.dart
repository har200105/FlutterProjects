import 'package:flutter/material.dart';
import 'package:whatsappp/Model/ChatModel.dart';
import 'package:whatsappp/Widgets/AvatarCard.dart';
import 'package:whatsappp/Widgets/ContactCard.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  // List<ChatModel> contacts = [
  //   ChatModel(
  //       name: "Dev Stack",
  //       currentMessage: '',
  //       icon: '',
  //       isGroup: false,
  //       time: ''),
  // ];
  // List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF128C7E),
            onPressed: () {},
            child: Icon(Icons.arrow_forward)),
        body: Stack(
          children: [
            // ListView.builder(
            //     itemCount: contacts.length + 1,
            //     itemBuilder: (context, index) {
            //       if (index == 0) {
            //         return Container(
            //           height: groupmember.length > 0 ? 90 : 10,
            //         );
            //       }
            //       return InkWell(
            //         onTap: () {
            //           setState(() {
            //             if (contacts[index - 1].select == true) {
            //               groupmember.remove(contacts[index - 1]);
            //               contacts[index - 1].select = false;
            //             } else {
            //               groupmember.add(contacts[index - 1]);
            //               contacts[index - 1].select = true;
            //             }
            //           });
            //         },
            //         child: ContactCard(),
            //       );
            //     }),
            // groupmember.length > 0
            //     ? Align(
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 75,
            //               color: Colors.white,
            //               child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: contacts.length,
            //                   itemBuilder: (context, index) {
            //                     if (contacts[index].select == true)
            //                       return InkWell(
            //                         onTap: () {
            //                           setState(() {
            //                             groupmember.remove(contacts[index]);
            //                             contacts[index].select = false;
            //                           });
            //                         },
            //                         child: AvatarCard(),
            //                       );
            //                     return Container();
            //                   }),
            //             ),
            //             Divider(
            //               thickness: 1,
            //             ),
            //           ],
            //         ),
                    // alignment: Alignment.topCenter,
                //   )
                // : Container(),
          ],
        ));
  }
}
