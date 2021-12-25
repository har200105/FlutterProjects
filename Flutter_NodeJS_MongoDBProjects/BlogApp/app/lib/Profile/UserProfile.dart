import 'package:blogapp/Blog/Blogs.dart';
import 'package:blogapp/Model/UserModel.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'MainProfile.dart';

class UserProfile extends StatefulWidget {
  final String id;
  UserProfile({Key key, this.id}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  UserData profileModel = UserData();
  bool circular = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    var response = await networkHandler.get("/user/getuser/" + widget.id);
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
        centerTitle: true,
        title: Text(profileModel.username ?? ""),
        elevation: 0,
        backgroundColor: Colors.cyanAccent,
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: head(),
                ),
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
                  url: "/blogPost/getUserBlog/" + widget.id,
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
            profileModel.username ?? "",
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
