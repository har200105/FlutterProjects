import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Screens/UserLists.dart';
import 'package:twitter/Servcies/User.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  UserDetails userDetails = UserDetails();
  String search="";
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(value: userDetails.querybyName(search),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            
            onChanged:(text){
              setState((){
                search=text;
              });
            },
            
            decoration: InputDecoration(
              hintText:"Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  30.0
                )
              ),
              
            ),
          ),
        ),
        ListUsers()
      ],
    ),
    );

  }
}