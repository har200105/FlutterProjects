import 'dart:convert';

import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BlogProvider extends ChangeNotifier {
  String baseurl = "https://shiddatblog.herokuapp.com";
  FlutterSecureStorage storage = FlutterSecureStorage();

  List<Data> blogs = [];
  List<Data> profileBlogs = [];

  void getAllBlogs() async {
    String token = await storage.read(key: "token");
    var response = await http.get(baseurl + "/blogPost/getAllBlogs",
        headers: {"Authorization": token});
    if (response.statusCode == 201) {
      BlogModel blogModel = BlogModel.fromJson(jsonDecode(response.body));
      blogs = blogModel.data;
      notifyListeners();
    }
  }

  void getProfileBlogs() async {
    String token = await storage.read(key: "token");
    var response = await http.get(baseurl + "/blogPost/getMyBlog",
        headers: {"Authorization": token});
    if (response.statusCode == 201) {
      BlogModel blogModel = BlogModel.fromJson(jsonDecode(response.body));
      profileBlogs = blogModel.data;
      notifyListeners();
    }
  }

  void addComment(BuildContext context,String commentText, String id) async {
    String token = await storage.read(key: "token");
    var response = await http.put(baseurl + "/blogPost/comment/" + id,
        body: json.encode({'Comment': commentText}), headers: {"Authorization": token,"Content-type": "application/json"});
    if (response.statusCode == 201) {
      print(response.body);
      print("Commented Successfully");
      getAllBlogs();
      getProfileBlogs();
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Commented Successfully",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3)));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));   
      //  BlogModel blogModel =  BlogModel.fromJson(jsonDecode(response.body));
      //  profileBlogs = blogModel.data;
      //   notifyListeners();
    }
  }

  Future deleteBlog(String id)async{
    String token = await storage.read(key: "token");
    var response = await http.delete(baseurl + "/blogPost/deleteBlog/" + id,
     headers: {"Authorization": token});
     print(response.body);
     if(response.statusCode==201){
       getAllBlogs();
       getProfileBlogs();
       return response.body;
     }
  }
}
