import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
     Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  profilePhoto,
                  SizedBox(
                    height: 10,
                  ),
                  Text("Harshit Rathi"),
                ],
              ),
            ),
            ListTile(
              title: Text("All Post"),
              trailing: Icon(Icons.launch),
              onTap: () {},
            ),
            ListTile(
              title: Text("New Story"),
              trailing: Icon(Icons.add),
              onTap: () {},
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text("Feedback"),
              trailing: Icon(Icons.feedback),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.power_settings_new),
              onTap: (){},
            ),
          ],
        ),
      ),
       appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Homepage"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
       bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color:Colors.white54,
                  onPressed: () {
                    setState((){});
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color:  Colors.white54,
                  onPressed: () {
                    setState((){});
                  },
                  iconSize: 40,
                )
              ],
            )
          )
        )
       )
    );
  }
}