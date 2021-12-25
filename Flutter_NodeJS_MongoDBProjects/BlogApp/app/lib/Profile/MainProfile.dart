import 'package:blogapp/Blog/Blogs.dart';
import 'package:blogapp/Model/UserModel.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:blogapp/Profile/EditProfile.dart';
import 'package:flutter/material.dart';

class MainProfile extends StatefulWidget {
  MainProfile({Key key}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  UserData profileModel = UserData();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/user/checkProfile");
    print(response);
    setState(() {
      profileModel = UserData.fromJson(response);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                head(),
                Divider(
                  thickness: 0.8,
                ),
                Divider(
                  thickness: 0.8,
                ),
                SizedBox(
                  height: 20,
                ),
                Blogs(
                  url: "/blogPost/getMyBlog",
                ),
              ],
            ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileModel.img ??
                  "https://res.cloudinary.com/harshit111/image/upload/v1627476210/cgggp1qrgbdp0usoahrf.png"),
            ),
          ),
          Text(
            profileModel.username,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            profileModel.bio ?? "Shiddat Sey Blog Likho !!",
            style: TextStyle(color: Colors.black),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            bio: profileModel.bio,
                            image: profileModel.img,
                            name: profileModel.username,
                          )));
            },
            child: Text("Edit Profile", style: TextStyle(color: Colors.white)),
            color: Colors.teal,
          )
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
