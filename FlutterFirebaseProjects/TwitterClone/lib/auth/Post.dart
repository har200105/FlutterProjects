import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String uid;
  final String creatorId;
  final String tweet;
  final Timestamp time;
  final String imageUrl;

  Posts({this.creatorId, this.tweet, this.time, this.uid,this.imageUrl});
}