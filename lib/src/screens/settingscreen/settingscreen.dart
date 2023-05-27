import 'package:ASA/src/authentication/controller/registercontroller.dart';
import 'package:ASA/src/screens/loginscreen/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../assets/constants/image_strings.dart';
import '../../authentication/Auth/Authentication.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: Stack(
            children: [
              Image(
                image: AssetImage(accountbackground),
                width: mediaQuery.size.width,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.08,
                      ),
                      child: ListView(
                  children: [
                    ListTile(title: Text('More'),),
                    ListTile(
                      leading:Icon(Icons.admin_panel_settings),
                      title: Text('Setting'),
                   
                      onTap: () {
                        // Handle category 1 selection
                      },
                    ),
                    ListTile(
                      leading:Icon(Icons.logout),
                      title: Text('logout'),
                    
                      onTap: ()async {
                        final _auth = FirebaseAuth.instance;
                       await  _auth .signOut(); 
                        if (_auth.currentUser == null) {
               Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => loginscreen()),
            );
            } else {
              // User is logged in
              print('User is logged in');
              // Perform actions for a logged-in user
            }
                      },
                    ),
                  ],
                ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
