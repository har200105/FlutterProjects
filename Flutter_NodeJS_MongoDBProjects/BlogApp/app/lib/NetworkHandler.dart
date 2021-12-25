import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = "https://shiddatblog.herokuapp.com";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.get(
      url,
      headers: {"Authorization": token},
    );
    if (response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json", "Authorization": token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      url,
      headers: {"Content-type": "application/json", "Authorization": token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> put(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.put(
      url,
      headers: {"Content-type": "application/json", "Authorization": token},
    );
  }

  Future<http.Response> post1(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json", "Authorization": token},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> putComment(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.put(
      url,
      headers: {"Content-type": "application/json", "Authorization": token},
      body: json.encode(body),
    );
    return jsonDecode(response.body);
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll(
        {"Content-type": "multipart/form-data", "Authorization": token});
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName.jpg");
    return NetworkImage(url);
  }
}
