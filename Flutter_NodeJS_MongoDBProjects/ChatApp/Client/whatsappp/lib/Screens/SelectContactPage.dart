import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappp/Model/ChatUsers.dart';
import 'package:whatsappp/Screens/ChatScreen.dart';
import 'package:whatsappp/Widgets/ButtonCard.dart';
import 'package:whatsappp/Widgets/ContactCard.dart';
import 'package:whatsappp/providers/UsersProvider.dart';
import 'package:whatsappp/views/Home.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  UserProviderNotifier chatsProvider(bool renderUi) =>
      Provider.of<UserProviderNotifier>(context, listen: renderUi);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chatsProvider(false).getAllUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if(!snapshot.hasData){
              return Scaffold(
                appBar: AppBar(
                backgroundColor: Colors.cyan,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    icon: Icon(Icons.arrow_back)),
                ),
                
                backgroundColor:Color(0xFF100E20) , body: Center(child: Text("No Contacts Available Currently",style: TextStyle(
                color: Colors.white
              ),),),);
            }else {
            List<ChatUser> u = snapshot.data;
            return Scaffold(
              backgroundColor: Color(0xFF100E20),
              appBar: AppBar(
                backgroundColor: Colors.cyan,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    icon: Icon(Icons.arrow_back)),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select User",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      snapshot.data!.length.toString() + " Users",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
              body: Padding(
               
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child:  ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            ContactCard(name: u[index].name, id: u[index].sId,pic: u[index].pic),
                      );
                    },
                  )
                ),
              ),
            );
          }
        });
  }
}
