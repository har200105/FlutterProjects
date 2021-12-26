import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:blogapp/Pages/HomePage.dart';
import 'package:blogapp/Profile/UserProfile.dart';
import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Blog extends StatefulWidget {
  const Blog({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);
  final Data addBlogModel;
  final NetworkHandler networkHandler;

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  NetworkHandler networkHandler = NetworkHandler();
  Data blogModel = Data();
  bool isLiked = false;
  int likes;
  final storage = FlutterSecureStorage();
  String id = "";
  TextEditingController commentController = TextEditingController();


  void setUserId() async {
    String d;
    await storage.read(key: "id").then((value) => {d = value});
    setState(() {
      id = d;
    });
    print("Id : " + id);

    for (int i = 0; i < widget.addBlogModel.like.length; i++) {
      if (widget.addBlogModel.like[i].sId == id) {
        setState(() {
          isLiked = true;
        });
      }
    }
  }

  @override
  void initState() {
    setUserId();
    setState(() {
      likes = widget.addBlogModel.like.length.toInt();
    });
    super.initState();
  }

  void likePost() async {
    var response =
        networkHandler.put("/blogPost/likepost/" + widget.addBlogModel.sId);
    setState(() {
      isLiked = true;
      likes++;
    });
    print(response);
  }

  void takeBackLikePost() async {
    var response =
        networkHandler.put("/blogPost/removeLike/" + widget.addBlogModel.sId);
    setState(() {
      isLiked = false;
      likes--;
    });
    print(response);
  }

  void commentinBlog() async {

    var response = networkHandler.putComment(
        "/blogPost/comment/" + widget.addBlogModel.sId,
        {'Comment': commentController.text});
    print(response);
    setState((){});

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Commented Successfully",
    style: TextStyle(
      color: Colors.white
    ),
    ),backgroundColor: Colors.green,duration: Duration(seconds: 3),));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.cyanAccent,
        title: Text(widget.addBlogModel.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 365,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.addBlogModel.postImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      widget.addBlogModel.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            size: 18,
                            color: isLiked ? Colors.blue : Colors.black,
                          ),
                          onPressed: () {
                            isLiked ? takeBackLikePost() : likePost();
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          likes.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.chat,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.addBlogModel.comments.length.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                            Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserProfile(id: widget.addBlogModel.postedBy.sId)));
              },
              child: Text(
                  "Posted By : " + widget.addBlogModel.postedBy.username,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Description",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Text(
                widget.addBlogModel.body,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
              width: 250.0,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: commentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Comment Your Views on this Blog',
                ),
              ),
            ),
          ),
          commentController.text.isNotEmpty
              ? ElevatedButton(
                  onPressed: () {
                    commentinBlog();
                    print(commentController.text);
                  },
                  child: Text(
                    "Comment",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(50, 30), primary: Colors.cyan))
              : Text(""),
               Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Comments",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.addBlogModel.comments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: ListTile(
                    tileColor: Colors.white70,
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile(
                                    id: widget.addBlogModel.comments[index]
                                        .commentedBy.sId)));
                      },
                      child: Text(
                        widget
                            .addBlogModel.comments[index].commentedBy.username,
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Text(
                        widget.addBlogModel.comments[index].comment,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
