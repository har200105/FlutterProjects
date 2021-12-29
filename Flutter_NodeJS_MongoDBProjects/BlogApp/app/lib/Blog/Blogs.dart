import 'package:blogapp/Blog/Blog.dart';
import 'package:blogapp/Providers/BlogProvider.dart';
import 'package:blogapp/Widgets/BlogCard.dart';
import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blogs extends StatefulWidget {
  final bool profile;
  Blogs({Key key, this.profile}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();

  List<Data> data = [];
  BlogModel blogModel = BlogModel();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    widget.profile ?  
    Provider.of<BlogProvider>(context,listen: false).getProfileBlogs() :
    Provider.of<BlogProvider>(context, listen: false).getAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogProvider>(builder: (context, blog, snapshot) {
      if (widget.profile ? blog.profileBlogs.length==0 : blog.blogs.length == 0) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text("We don't have any Blog Yet",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
          ),
        );
      } else {
        return Column(
          children: widget.profile ?  blog.profileBlogs
              .map((item) => Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => Blog(
                                        addBlogModel: item,
                                        networkHandler: networkHandler,
                                      )));
                        },
                        child: BlogCard(
                          addBlogModel: item,
                          networkHandler: networkHandler,
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                    ],
                  ))
              .toList() : blog.blogs
              .map((item) => Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => Blog(
                                        addBlogModel: item,
                                        networkHandler: networkHandler,
                                      )));
                        },
                        child: BlogCard(
                          addBlogModel: item,
                          networkHandler: networkHandler,
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                    ],
                  ))
              .toList() 
        );
      }
    });
  }
}
