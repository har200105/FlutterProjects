import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/Servcies/User.dart';
import 'package:twitter/auth/Post.dart';
import 'package:quiver/iterables.dart';

class PostDatabase{

  List<Posts> postListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e){
      return Posts(
        uid:e.id,
        tweet: e['tweet'] ?? "",
        creatorId:e['creator'] ?? "",
        time: e['time'] ?? 0,
        imageUrl: e['image'] ??  "",
      );
    }).toList();
  }

  Posts postsFromSnapshot(DocumentSnapshot snapshot){
    return snapshot.exists ?
       Posts(
        uid:snapshot.id,
        tweet: snapshot['tweet'],
        creatorId:snapshot['creator'] ?? "",
        time: snapshot['time'] ?? 0,
        
      ):null;
  }
  Future savePost(String text,String url)async{
    await FirebaseFirestore.instance.collection("tweets").add({
      'tweet':text,
      'creator':FirebaseAuth.instance.currentUser.uid,
      'time':FieldValue.serverTimestamp(),
      'image':url
      

    });
  }

  Future retweet(Posts post ,bool isRetweeted)async{


    if(isRetweeted){
       await FirebaseFirestore.instance.collection("tweets").doc(post.uid).collection("retweet")
      .doc(FirebaseAuth.instance.currentUser.uid).delete();


        await FirebaseFirestore.instance.collection("tweets").where("origin",isEqualTo:post.uid)
        .where("creator",isEqualTo:FirebaseAuth.instance.currentUser.uid)
        .get().then((value){
          if(value.docs.length==0){
            return;
          }else{
            FirebaseFirestore.instance.collection("tweets").doc(value.docs[0].id)
            .delete();
          }
        });
      // .doc(FirebaseAuth.instance.currentUser.uid).delete();

      return;
    }else{
      await FirebaseFirestore.instance.collection("tweets").doc(post.uid).collection("retweet")
      .doc(FirebaseAuth.instance.currentUser.uid).set({});

      await FirebaseFirestore.instance.collection("tweets").add({
        'creator':FirebaseAuth.instance.currentUser.uid,
        'timestamp':FieldValue.serverTimestamp(),
        'retweet':true,
        'origin':post.uid
      });
    }
  }


    Future likePost(Posts post,bool liked)async{
      print(post.uid);
      if(liked){
        await FirebaseFirestore.instance.collection("tweets").doc(post.uid).collection("likes")
        .doc(FirebaseAuth.instance.currentUser.uid).delete();
      }

     if(!liked){
        await FirebaseFirestore.instance.collection("tweets").doc(post.uid).collection("likes")
        .doc(FirebaseAuth.instance.currentUser.uid).set({});
      }
    }
    

  Stream<List<Posts>>  postsByUser(uid){
    return FirebaseFirestore.instance.collection("tweets").
    where("creator",isEqualTo:uid).snapshots().map(postListFromSnapshot);
  }


  Stream<bool> getCurrentUserLike(Posts post){
  return FirebaseFirestore.instance.collection("tweets").doc(post.uid).collection("likes")
        .doc(FirebaseAuth.instance.currentUser.uid).snapshots().map((snapshot){
          return snapshot.exists;
        }); 
  }


   Stream<bool> getCurrentRetweet(Posts post){
  return FirebaseFirestore.instance.collection("tweets").doc(post.uid).collection("retweet")
        .doc(FirebaseAuth.instance.currentUser.uid).snapshots().map((snapshot){
          return snapshot.exists;
        }); 
  }


  
  Future<int> getLikes(uid)async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("tweets")
    .doc(uid).collection("likes").get();

    // final nofuserFollowings = querySnapshot.docs.length;
    final userLikes = querySnapshot.docs.map((datas) => datas.id).toList();
    int likes = userLikes.length;
    return likes;
  }

  Future getPostsById(String id)async{
    DocumentSnapshot postSnap = await FirebaseFirestore.instance.collection("tweets").doc(id).get();
    return postsFromSnapshot(postSnap);
  }

  
  Future<List<Posts>> getFeed() async{
    List<String> usersFollowing = await UserDetails()
    .getUserFollowings(FirebaseAuth.instance.currentUser.uid);
    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10);
    // inspect(splitUsersFollowing);
    List<Posts> feedList=[];
    for(int i=0;i<splitUsersFollowing.length;i++){
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("tweets")
    .where("creator",whereIn:splitUsersFollowing.elementAt(i)).orderBy("time",descending:true).get(); 
    feedList.addAll(postListFromSnapshot(querySnapshot));
    }

    feedList.sort((a,b){
      var adate =  a.time;
      var bdate = b.time;

      return bdate.compareTo(adate);
    });

    return feedList;

  
    }
  
}