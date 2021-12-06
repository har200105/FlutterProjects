import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Screens/Profile.dart';
import 'package:twitter/auth/User.dart';


class ListUsers extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
  final usersFound = Provider.of<List<Users>>(context) ?? [];
    return ListView.builder(
      itemCount: usersFound.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        final newUser = usersFound[index];
        return InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>Profile(getUid:newUser.id),
            ));
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children:[newUser.profilePic !="" ?
                  CircleAvatar(
                    radius:30,
                    backgroundImage: NetworkImage(
                      newUser.profilePic
                    ),

                  ):
                  Icon(Icons.person),
                  SizedBox(width:10),
                  Text(newUser.name)
                  ]
                ),
                ),
              Divider(
                thickness:1
              ),
            ],
          ),
        );
      },
    );
  }
}