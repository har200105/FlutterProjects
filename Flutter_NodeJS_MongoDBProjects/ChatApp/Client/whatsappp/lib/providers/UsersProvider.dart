import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Model/ChatUsers.dart';

class UserProviderNotifier extends ChangeNotifier {
    String url = "https://chatharshit.herokuapp.com";
  Future getAllUsers()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(Uri.parse(url + "/getUsers"),headers: {
      "Authorization":prefs.getString("jwt")
    });

    if(response.statusCode==201){
      var user = ChatUsers.fromJson(jsonDecode(response.body));
      print(user.user![0].email);
      return user.user;
    }
  }

}