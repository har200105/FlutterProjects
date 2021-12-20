import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Model/Message.dart';

class MessageNotifierProvider extends ChangeNotifier {
  String url = "http://192.168.1.208:4000";

  List <Messages>? m = [];
  List<Messages> get messages => m!;


  Future getMessages(String? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Id" + id!);
      http.Response response = await http
          .get(Uri.parse(url + "/getMessages/" + id), headers: {
        "Authorization": prefs.getString("jwt"),
        "Content-Type": "Application/json"
      });  
      print("Response ::");
      print(response.body);
      if (response.statusCode == 201) {
        print(response.body);
        var message = MessageModel.fromJson(jsonDecode(response.body));
        m =  message.messages;
        notifyListeners();
        return message.messages;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendMessage(String id, String content) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response = await http
          .post(Uri.parse(url + "/sendMessage/" + id), headers: {
        "Authorization": prefs.getString("jwt"),
      }, body: {
        'content': content
      });
      print(response.body);
      if (response.statusCode == 201) {
        getMessages(id);
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }


}
