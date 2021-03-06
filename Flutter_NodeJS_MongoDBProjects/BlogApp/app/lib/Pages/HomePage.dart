import 'package:blogapp/Blog/addBlog.dart';
import 'package:blogapp/Pages/WelcomePage.dart';
import 'package:blogapp/Providers/BlogProvider.dart';
import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:blogapp/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  List<String> titleString = ["Home Page", "Profile Page"];
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  String img = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    Provider.of<BlogProvider>(context,listen: false).getAllBlogs();
     Provider.of<BlogProvider>(context,listen: false).getProfileBlogs();
    checkProfile();
    super.initState();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/user/checkProfile");
    print(response);
    setState(() {
      username = response['username'];
      img = response['img'];
    });
    setState(() {
      profilePhoto = CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(img),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Color(0xFF100E20),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      profilePhoto,
                      SizedBox(
                        height: 10,
                      ),
                      Text("@$username"),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("New Story"),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AddBlog()));
                  },
                ),
                ListTile(
                  title: Text("Logout"),
                  trailing: Icon(Icons.logout),
                  onTap: logout,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          title: Text(titleString[currentState]),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.logout), onPressed: logout),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyanAccent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBlog()));
          },
          child: Text(
            "+",
            style: TextStyle(fontSize: 40),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.cyanAccent,
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    color: currentState == 0 ? Colors.white : Colors.white54,
                    onPressed: () {
                      setState(() {
                        currentState = 0;
                      });
                    },
                    iconSize: 40,
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    color: currentState == 1 ? Colors.white : Colors.white54,
                    onPressed: () {
                      setState(() {
                        currentState = 1;
                      });
                    },
                    iconSize: 40,
                  )
                ],
              ),
            ),
          ),
        ),
        body: widgets[currentState],
      ),
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
