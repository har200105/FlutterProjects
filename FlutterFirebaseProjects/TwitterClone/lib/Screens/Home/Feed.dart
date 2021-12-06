import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Servcies/Lists.dart';
import 'package:twitter/Servcies/PostsDatabase.dart';


class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  PostDatabase postDatabase = PostDatabase();
  @override
  Widget build(BuildContext context) {
    return FutureProvider.value(
      value: postDatabase.getFeed(),
      child: Scaffold(
        body: ListPost(),
      ),
    );
  }
}