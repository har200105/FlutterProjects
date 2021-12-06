import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Servcies/PostsDatabase.dart';
import 'package:twitter/Servcies/User.dart';
import 'package:twitter/auth/Post.dart';
import 'package:twitter/auth/User.dart';

class ListPost extends StatefulWidget {
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {


  UserDetails userDetails = UserDetails();
  PostDatabase postDatabse = PostDatabase();

  int noofLikes=0;

  Future<int> getLikes(postid)async{
    int likes = await postDatabse.getLikes(postid);
    setState(() {
      noofLikes=likes;
    });

    return likes;
  }


  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Posts>>(context) ?? [];
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final op = posts[index];
        // getLikes(op.uid);
       
        return StreamBuilder(
            stream: userDetails.getUserInfo(op.creatorId),
            builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return StreamBuilder(
                  stream: postDatabse.getCurrentUserLike(op),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                    if (!snapshotLike.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Card(
                        elevation: 5.0,
                        shadowColor: Colors.lightBlue[200],
                        child: ListTile(
                          // elevation: 5.0,
                          title: Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Row(
                              children: [
                                snapshot.data.profilePic != ''
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            snapshot.data.profilePic),
                                      )
                                    : Icon(
                                        EvaIcons.person,
                                        size: 40,
                                      ),
                                SizedBox(width: 10),
                                Text(snapshot.data.name),
                                SizedBox(width: 5),
                                Text("@" +
                                    snapshot.data.email
                                        .replaceAll("@gmail.com", " "),style: TextStyle(
                                          fontWeight:FontWeight.w400,
                                          color: Colors.grey
                                        ),),
                                //  Divider(),
                                //  SizedBox(height: 20,),
                              ],
                            ),
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(op.tweet),
                                      SizedBox(
                                        height: 20,
                                      ),
                                       op.imageUrl != "" || op.imageUrl!=null ?
                                      Image.network(op.imageUrl,height: 150,width: 250,):
                                      Text(""),
                                      Padding(
                                        padding: const EdgeInsets.only(top:15.0),
                                        child: Text("Tweeted At: " +
                                            op.time.toDate().toString()),
                                      ),
                                      
                                      SizedBox(height: 20),
                                     
                                      Row(
                                        children: [
                                      Row(
                                        children:[
                                        IconButton(
                                        icon: Icon(
                                          snapshotLike.data
                                              ? EvaIcons.heart
                                              : EvaIcons.heartOutline,
                                          color: snapshotLike.data
                                              ? Colors.red
                                              : Colors.blue,
                                          size: 30.0,
                                        ),
                                        onPressed: () {
                                          postDatabse.likePost(
                                              op, snapshotLike.data);
                                              getLikes(op.uid);
                                          print("Done");
                                       Padding(
                                        padding: const EdgeInsets.only(left:18.0),
                                        child: Text(noofLikes.toString()),
                                      );
                                        },
                                      ),

                                     Padding(
                                       padding: const EdgeInsets.only(left:45.0),
                                       child: IconButton(
                                          icon: Icon(EvaIcons.repeat,
                                            color:Colors.blue,
                                            size: 30.0,
                                          ),
                                          onPressed: () {
                                            // postDatabse.retweet(op, false);
                                          },
                                        ),
                                     ),



                                     Padding(
                                       padding: const EdgeInsets.only(left:45.0),
                                       child: IconButton(
                                          icon: Icon( EvaIcons.messageCircleOutline,
                                            color:Colors.blue,
                                            size: 30.0,
                                          ),
                                          onPressed: () {
                                          
                                          },
                                        ),
                                     ),


                                      Padding(
                                       padding: const EdgeInsets.only(left:45.0),
                                       child: IconButton(
                                          icon: Icon(EvaIcons.share,
                                            color:
                                                Colors.blue,
                                            size: 30.0,
                                          ),
                                          onPressed: () {
                                          
                                          },
                                        ),
                                     ),

                                        ]
                                      ),
                                     
                                       ],
                                      ), 
                                      // SizedBox(width: 20),
                                     
                                    ],
                                  ),
                                ),
                                Divider(),
                              ]),
                        ),
                      ),
                    );
                  });
            });
      },
    );
  }
}
