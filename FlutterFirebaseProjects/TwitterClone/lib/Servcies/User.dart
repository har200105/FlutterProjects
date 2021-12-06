import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/Servcies/utils.dart';
import 'package:twitter/auth/User.dart';

class UserDetails {

  List<Users> userListsFromSearchBox(QuerySnapshot snapshot){
    return snapshot.docs.map((datas){
      return Users(
         id:datas.id,
      name: datas['name'] ?? "",
      email: datas['email'] ?? "",
      profilePic: datas['profilepic'] ?? "",
      bannerPic: datas['bannerimage'] ?? "",
      );
    }).toList();
  }

  Users userFromFirebase(DocumentSnapshot snapshot){
    return snapshot!=null ?
    Users(
      id:snapshot.id,
      name: snapshot['name'],
      email: snapshot['email'],
      profilePic: snapshot['profilepic'],
      bannerPic: snapshot['bannerimage']
    ):null;
  }

  Stream<Users> getUserInfo(uid){
    return FirebaseFirestore.instance.collection("users").doc(uid).snapshots().map(userFromFirebase);
  }

  Stream<List<Users>> querybyName(searchText){
    return FirebaseFirestore.instance.collection("users").orderBy("name")
    .startAt([searchText]).endAt([searchText+'\uf8ff'])
    .limit(10).snapshots().map(userListsFromSearchBox);
  }

  
  Stream<bool> isFollowing(uid,otherId){
    return FirebaseFirestore.instance.collection("users")
    .doc(uid).collection("following").doc(otherId).snapshots().map((snapshot){
      return snapshot.exists ;
    });
  }

  // Future<int> noFollowing(uid)async{
  //  int d =  await FirebaseFirestore.instance.collection("users")
  //   .doc(uid).collection("following").snapshots().length;
  
  //   followers =  d;

  //   return followers;
    
  // }

  Future<void> follow(uid) async{
    await FirebaseFirestore.instance.collection("users")
    .doc(FirebaseAuth.instance.currentUser.uid)
    .collection("following").doc(uid).set({});

     await FirebaseFirestore.instance.collection("users")
    .doc(uid)
    .collection("followers").doc(FirebaseAuth.instance.currentUser.uid).set({});
  }


  Future<void> unFollow(uid) async{
    await FirebaseFirestore.instance.collection("users")
    .doc(FirebaseAuth.instance.currentUser.uid)
    .collection("following").doc(uid).delete();
  
     await FirebaseFirestore.instance.collection("users")
    .doc(uid)
    .collection("followers").doc(FirebaseAuth.instance.currentUser.uid).delete();
  }

  Future<List<String>> getUserFollowings(uid)async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users")
    .doc(uid).collection("following").get();

    final nofuserFollowings = querySnapshot.docs.length;
    final userFollowings = querySnapshot.docs.map((datas) => datas.id).toList();
    // followers = nofuserFollowings;
    return userFollowings;
  }


  Future<int> getUserNoFollowings(uid)async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users")
    .doc(uid).collection("following").get();

    final nofuserFollowings = querySnapshot.docs.length;
    final userFollowings = querySnapshot.docs.map((datas) => datas.id).toList();
    int followers = userFollowings.length;
    return followers;
  }


    Future<int> getUserNoFollowers(uid)async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users")
    .doc(uid).collection("followers").get();

    final nofuserFollowings = querySnapshot.docs.length;
    final userFollowings = querySnapshot.docs.map((datas) => datas.id).toList();
    int followers = userFollowings.length;
    return followers;
  }


  // Future<int> getNoUserFollowings(uid)async{
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users")
  //   .doc(uid).collection("following").get();

  //   final nofuserFollowings = querySnapshot.docs.length;
  //   final userFollowings = querySnapshot.docs.map((datas) => datas.id).toList();
  //   // followers = userFollowings.length;
  //   // return followers;
  // }

  Utils utils = Utils();
  
  Future<void> updateProfile(
    
      File _bannerImage, File _profileImage, String name) async {
    String bannerImageUrl = "";
    String profileImageUrl = "";
    if (_bannerImage != null) {
      bannerImageUrl = await utils.uploadFile(_bannerImage,
          'user/data/${FirebaseAuth.instance.currentUser.uid}/banner');
    }

    if (_profileImage != null) {
      profileImageUrl = await utils.uploadFile(_profileImage,
          'user/data/${FirebaseAuth.instance.currentUser.uid}/profile');
    }

    Map<String, Object> data = new HashMap();    
    if (name != "") {
      data['name'] = name;     
    }    

    if (bannerImageUrl != "") {
      data['bannerimage'] = bannerImageUrl;
    }

    if (profileImageUrl != "") {
      data['profilepic'] = profileImageUrl;
    }


    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(data).then((value) => {
          print("value")
        });
  }
}


// SBTcACjcIDeVbYPvtjVHFfUvOr03