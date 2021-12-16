import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Servcies/User.dart';

class Edit extends StatefulWidget {
  Edit({Key key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
 
  UserDetails _userService = UserDetails();
  File _profileImage;
  File _bannerImage;
  final picker = ImagePicker();
  String name = '';

  Future getImage(int type) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null && type == 0) {
        _profileImage = File(pickedFile.path);
      }
      if (pickedFile != null && type == 1) {
        _bannerImage = File(pickedFile.path);
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Padding(
          padding: const EdgeInsets.only(top:70.0),
          child: new Form(
              child: Column(
            children: [
              MaterialButton(
                onPressed: () => getImage(0),
                child: _profileImage == null
                    ? Text("Add Profile Pic")
                    : Image.file(
                        _profileImage,
                        height: 100,
                      ),
                      color: Colors.purple,
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: MaterialButton(
                  onPressed: () => getImage(1),
                  child: _bannerImage == null
                      ? Text("Add Cover Photo")
                      : Image.file(
                          _bannerImage,
                          height: 100,
                        ),
                        color: Colors.cyan,
                ),
              ),
              TextFormField(
                onChanged: (val) => setState(() {
                  name = val;
                }),
                decoration: InputDecoration(
                  hintText: "Change Name"
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: MaterialButton(
                  onPressed: () async {
                    await _userService.updateProfile(
                        _bannerImage, _profileImage, name);
                  },
                  child: Text('Save'),
                  color: Colors.deepOrange,
                  colorBrightness: Brightness.dark,
                  ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}