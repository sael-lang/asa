import 'dart:async';

import 'package:ASA/src/screens/loginscreen/loginscreen.dart';
import 'package:ASA/src/screens/register/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../assets/constants/image_strings.dart';
import '../../assets/constants/colors.dart';
class Mainscreen extends StatefulWidget {
  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  void initState() {
    super.initState();

    // Timer(Duration(seconds: 2),(){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "demo")),);
    // });
  }
  
 

  @override

Widget build(BuildContext context) {
   final mediaQuery = MediaQuery.of(context); 
  return Scaffold(
    body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image(
            image: AssetImage(mainscreenlogo),
            width: mediaQuery.size.width,
          ),
        ),
        Positioned(
          bottom: -(mediaQuery.size.height*.03),
          left: 0,
          right: 0,
          child: Image(
            image: AssetImage(mainscreenbase),
            width: mediaQuery.size.width*.5,
          ),
        ),
        Positioned(
          top: -mediaQuery.size.height*.01,
          left:  mediaQuery.size.width*.08,
          child: Image(
            image: AssetImage(logo),
            width:  mediaQuery.size.width*.8,
            height: mediaQuery.size.width*.8,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Image(
            image: AssetImage(clogo),
            width:  mediaQuery.size.width,
            height: mediaQuery.size.height,
          ),
        ),
        Positioned(
          bottom:mediaQuery.size.height*.06,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                height: mediaQuery.size.height*.06,
                width: mediaQuery.size.width*.74,
                child: TextButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(color1),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => register()),
    );},
  child: Text(
    'Register',
    style: TextStyle(color: Colors.white),
  ),
),

              ),
              SizedBox(height: mediaQuery.size.height*.04),
              Container(
                height:mediaQuery.size.height*.06,
                width: mediaQuery.size.width*.74,
                child:TextButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(color2),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginscreen()),
    );},
  child: Text(
    'Login',
    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  ),
),

              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
