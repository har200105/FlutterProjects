import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/Screens/Edit.dart';
import 'package:twitter/Screens/HomeScreen.dart';
import 'package:twitter/Servcies/Lists.dart';
import 'package:twitter/Servcies/PostsDatabase.dart';
import 'package:twitter/Servcies/User.dart';
import 'package:twitter/auth/User.dart';

class Profile extends StatefulWidget {
  String getUid;
  
  Profile({Key key, this.getUid}): super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int followe=0;
  int followers =0;



  
  void getFoll()async{
    int d = await userDetails.getUserNoFollowings(widget.getUid);
    setState(() {
      followe=d;
    });
  }

   void getFollowers()async{
    int d = await userDetails.getUserNoFollowers(widget.getUid);
    setState(() {
      followers=d;
    });
  }

  @override
  void initState(){
    getFoll();
    getFollowers();
    super.initState();
  }


   var database = FirebaseFirestore.instance;
   UserDetails userDetails = UserDetails();
  
    // Future getData() async {
    //   QuerySnapshot querySnapshot = await database.collection('tweets').where("creator",isEqualTo:FirebaseAuth.instance.currentUser.uid)
    //   .get();
    //   return querySnapshot.docs;
    // }
    
  PostDatabase posts = PostDatabase();
    // Future<dynamic> getFollowersNo() async{
    //   var followers  = FirebaseFirestore.instance.collection("users")
    //   .doc(widget.getUid).collection("following").get(); 
    // }
  @override
  Widget build(BuildContext context) {
// int number;

//     void getNo() async{
//      number =   await userDetails.noFollowing(widget.getUid);
//     }

//     void initState(){
//       getNo();
//       super.initState();
//       print("a");
//     }


  //   int g;
  //   void initState()async{
  // g  =  await userDetails.noFollowing(widget.getUid);
  // super.initState();
  //   }
    // var lengths;
    // var followers =   FirebaseFirestore.instance
    //                           .collection("users").doc(FirebaseAuth.instance.currentUser.uid)
    //                           .collection("followers").get().then((value) => {
    //                             setState((){
    //                               lengths = value.docs.length.toString();
    //                             })
    //                           });  


      
    //  var t = s.length.toString();                                            
  //  final String uid = ModalRoute.of(context).settings.arguments;
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: posts.postsByUser(widget.getUid),
        ),
         StreamProvider.value(
          value: userDetails.getUserInfo(widget.getUid)
        ),
        StreamProvider.value(
          value: userDetails.isFollowing(FirebaseAuth.instance.currentUser.uid, widget.getUid)
          ),
        
      ],
      
      child: Scaffold(
        body: DefaultTabController(length: 2, child: NestedScrollView(
          headerSliverBuilder: (context,_){
            return [
              SliverAppBar(
                leading:  IconButton(icon:Icon(Icons.arrow_back),onPressed: (){
                  Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context)=>HomeScreen()));
                },),
                floating: false,
                pinned: true,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                     Provider.of<Users>(context).bannerPic ?? '',
                     fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate(
                [
                  Container(
                    padding:EdgeInsets.symmetric(vertical:20,horizontal:20),
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                            backgroundImage:NetworkImage(

                               Provider.of<Users>(context).profilePic ?? '',
                               
                              //  height: 100,
                            ),
                             backgroundColor: Colors.transparent,
                            ),

                            Text(
                            "Followers:"+followers.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                           ),

                           Text(
                          "Following:"+followe.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                           ),

                           
                        
                            if(FirebaseAuth.instance.currentUser.uid == widget.getUid)
                               TextButton(
                                 onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Edit()));
                                 },
                                 child: Text("Edit Profile"),)
                            
                            else if(FirebaseAuth.instance.currentUser.uid != widget.getUid
                                 && !Provider.of<bool>(context)) 

                                 TextButton(
                                 onPressed: (){
                                   userDetails.follow(widget.getUid);
                                 },
                                 child: Text("Follow"),)

                             else if(FirebaseAuth.instance.currentUser.uid != widget.getUid
                                 && Provider.of<bool>(context)) 

                                 TextButton(
                                 onPressed: (){
                                 userDetails.unFollow(widget.getUid);
                                 },
                                 child: Text("Following"),)         
                          ],   
                        ),
                        Align(
                          alignment:Alignment.centerLeft,
                          child:Container(
                            padding: EdgeInsets.all(18),
                            child: Text(Provider.of<Users>(context).name,style: TextStyle(
                              color:Colors.blueGrey,
                              fontWeight:FontWeight.bold,  
                            ),
                            ),
                          ),
                        ),
                       
                      ],
                    )
                  )
                ]
              ))
            ];
          },
          body: ListPost(),
        ),
        )
        
        
        
      ),
    );
  }
}





//  return Scaffold(
//       body: Container(
//         child:SizedBox(
//           child:FutureBuilder(
//             future: getData(),
//             builder: (context,snapshot){
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }else{
//                     return ListView.builder(
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (BuildContext context,int index){
//                         return Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(snapshot.data[index].data()['tweet']),
//                               Text(snapshot.data[index].data()['creator']),

//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//             },
//           ),
//         ),
//       ),
//     );