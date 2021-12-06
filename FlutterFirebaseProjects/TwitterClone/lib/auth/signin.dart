// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:twitter/auth/Authentication.dart';
// import 'package:twitter/Screens/HomeScreen.dart';

// class Signup extends StatefulWidget {
//   @override
//   _SignupState createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   Authentication auth = Authentication();
//   String email="";
//   String password="";
//   String imageUrl ="";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:Colors.lightBlueAccent[200],
//       appBar: AppBar(
//         backgroundColor:Colors.lightBlueAccent,
//         elevation: 8,
//         title: Text("Twitter",style: TextStyle(
//           color:Colors.white
//         ),),
//         centerTitle: true,
//       ),
//       body: Container(
        
//         padding:EdgeInsets.symmetric(vertical: 20,horizontal: 50),
//         child: Form(
//           child: Column(
//             children: [

//               Padding(
//                 padding: const EdgeInsets.only(bottom:20.0,top: 10.0),
//                 child: Icon(EvaIcons.twitter,color:Colors.white,size: 60.0,),
//               ),

//               TextFormField(
//                 onChanged:(val){
//                   setState((){
//                     email=val;
//                   });
//                 },
//                 decoration:  InputDecoration(
//                               hintText: "ENTER EMAIL",
//                               hintStyle: TextStyle(
//                                   fontSize: 18.0,
//                                   fontFamily: 'Comic',
//                                   color: Colors.white
//                                   ),
//                             ),
                          
//               ),TextFormField(
//                 obscureText: true,
//                 onChanged:(val){
//                   setState((){
//                     password=val;
//                   });
//                 },
//                 decoration:  InputDecoration(
//                               hintText: "ENTER PASSWORD",
//                               hintStyle: TextStyle(
//                                   fontSize: 18.0,
//                                   color: Colors.white),
//                             ),
//               ),
//               // MaterialButton(onPressed: ()async{
//               //   // auth.signUp(email, password,"","").then((e) => {
//               //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())),
//               //     print(e)
//               //   });
//               // },
//               // child: Text("Sign Up"),
//               // ),
//                MaterialButton(onPressed: ()async{
//                  auth.signIn(email, password).then((e) => {
//                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen())),
//                    print(e)
//                  });
//               },
//               child: Text("Sign In"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }