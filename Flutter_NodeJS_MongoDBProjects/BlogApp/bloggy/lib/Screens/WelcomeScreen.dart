import 'package:bloggy/Screens/SignupPage.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;
  late AnimationController controller1;
  late Animation<Offset> animation1;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    animation = Tween<Offset>(begin: Offset(0.0, 5.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
    controller.forward();

    controller1 = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    animation1 = Tween<Offset>(begin: Offset(0.0, 5.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller1.forward();
    super.initState();
    
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.cyan, Colors.purple],
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.repeated)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            children: [
              SlideTransition(
                position: animation,
                child: Text("Bloggy",
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 6),
              Text("Shiddat Banalu Meri Chahat Banalu",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 38,
                      letterSpacing: 2)),
              SizedBox(height: 20),
              boxContainer("image", "text",()=>{
                print("object")
              }),
              SizedBox(height: 20),
              boxContainer("image", "text",onEmailClick),
              SizedBox(height: 20),
              boxContainer("image", "text",()=>{

              }),
              Row(
                children: [
                  Text("Already Have an Account?",
                      style: TextStyle(color: Colors.grey, fontSize: 17)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Signin",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onEmailClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
  }



  Widget boxContainer(String image, String text, onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 150,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Image.asset(image, height: 25, width: 25),
                SizedBox(width: 20),
                Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
        ), 
      ),
    );
  }
}
