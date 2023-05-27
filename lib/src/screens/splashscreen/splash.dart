import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();

    // Timer(Duration(seconds: 2),(){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "demo")),);
    // });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       
        child: Center(
          child: Text(
            'ASA',
            style: TextStyle(fontSize: 34, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
