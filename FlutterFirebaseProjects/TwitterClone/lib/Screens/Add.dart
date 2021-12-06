import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/Screens/HomeScreen.dart';
import 'package:twitter/Servcies/PostsDatabase.dart';


class AddTweet extends StatefulWidget {
  @override
  _AddTweetState createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {

  String textToTweet = " ";
  PostDatabase database = PostDatabase();
   File _imageFile;
  String _uploadedFileURL;
  String imageUrl;
  final picker = ImagePicker();
  String url ="";
  Future pickImage() async {
    final pickedFile = await picker.getImage(source:ImageSource.gallery );

    setState(() {
      _imageFile = File(pickedFile.path);
    });
   var i = await uploadPic(_imageFile);
    
   setState((){
      imageUrl=i;
   });
  
   print("a"+i);
  }

  Future uploadPic(File _image1) async {
   FirebaseStorage storage = FirebaseStorage.instance;
   Reference ref = storage.ref().child("image1" + DateTime.now().toString());
   UploadTask uploadTask = ref.putFile(_image1);
   uploadTask.whenComplete(() async {
      url = await  ref.getDownloadURL();
   }).then((value) => showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
          title: new Text("Image Uploaded"),
          content: new Text("Your Product has been uploaded successfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new MaterialButton(
              child: new Text("OK"),
              onPressed: () {
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
   }));
   return url;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Add Tweet"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
         }),
        actions:[
         
        ]
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20,horizontal:10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: TextFormField(
              onChanged: (val){
                setState(() {
                  textToTweet=val;
                });
              },
            ),
          ),
           IconButton(icon: Icon(EvaIcons.fileAdd), onPressed: (){
             pickImage();
           }),       
           Padding(
             padding: const EdgeInsets.only(top:15.0),
             child: MaterialButton(
              onPressed:()async{
                await database.savePost(textToTweet,url).then((e) => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()))
                });
                
              },
              color: Colors.purpleAccent,
              child: Text("Tweet",style: TextStyle(
                color:Colors.white
              ),),
          ),
           ),
          ],
        ),


      ),
    );
  }
}