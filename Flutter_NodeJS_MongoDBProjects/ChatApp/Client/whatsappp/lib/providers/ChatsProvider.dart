import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:whatsappp/Model/ChatModel.dart';

class ChatsNotifierProvider extends ChangeNotifier {
  String url = "http://192.168.1.208:4000";
  List<Data>? d = [];
  List<Data> get chats => d!;

  Future getUserChats() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.get(Uri.parse(url + "/getChats"),
          headers: {
            "Authorization": prefs.getString("jwt"),
            "Content-Type": "Application/json"
          });
      if (response.statusCode == 201) {
        print(response.body);
        print("de");
        var chat = Chat.fromJson(jsonDecode(response.body));
        print(chat.data);
        d = chat.data;
        print(d![0]);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());  
    }
  }

  Future createChat(String uid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http.post(
          Uri.parse(url + "/startChat/" + uid),
          headers: {"Authorization": prefs.getString("jwt")});
      if (response.statusCode == 201) {
        getUserChats();
        print(response.body);
        return response.body;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
