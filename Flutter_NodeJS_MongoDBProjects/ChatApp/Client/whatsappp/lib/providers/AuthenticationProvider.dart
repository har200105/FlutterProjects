import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Model/User.dart';
import 'package:whatsappp/views/Home.dart';

class AuthenticationProvider extends ChangeNotifier {
  String url = "http://192.168.1.208:4000";

  Future userSignup(
      BuildContext context, String name, String email, String password,String pic) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      User user = new User(name, email, password,pic);
      var json = jsonEncode(user.toJson());
      print(json);
      final http.Response response = await http.post(
        Uri.parse(url + "/signup"),
        body: json,
        headers: {"Content-Type": "application/json"},
      );
      print(response.body);
      if (response.statusCode == 201) {
        var user = User.fromJson(jsonDecode(response.body));
        print(user.name);
        print(user);
        prefs.setString("jwt", user.token);
        prefs.setString("id", user.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Signup Successfull"),
            backgroundColor: Colors.green));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("User Already Exists"), backgroundColor: Colors.red));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went Wrong"), backgroundColor: Colors.red));
    }
  }

  Future login(BuildContext context, String email, String password) async {
    print(password);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.post(Uri.parse(url + "/login"),
          body: {'email': email, 'password': password},headers: {

          });
          print(response.body);
      if (response.statusCode == 201) {
        var user = User.fromJson(jsonDecode(response.body));
        print(user.name);
        prefs.setString("jwt", user.token);
        prefs.setString("id", user.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Successfull"), backgroundColor: Colors.green));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid Credentials"), backgroundColor: Colors.red));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Credentials"), backgroundColor: Colors.red));
    }
  }
}
