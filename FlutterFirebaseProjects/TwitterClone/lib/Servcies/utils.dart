import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Utils{
  Future<String> uploadFile(File _image,String path) async{
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref(path);
     UploadTask uploadTask = ref.putFile(_image);
     await uploadTask.whenComplete(() => {
        
     });
       String imurl = "";
       await ref.getDownloadURL().then((value) => {
         imurl=value
       });

       return imurl;
       
  }
}