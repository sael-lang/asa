
import 'package:ASA/src/screens/ConsumerAccountScreen/ConsumerAccount.dart';
import 'package:ASA/src/screens/accountscreen/accountscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/constants/colors.dart';
import '../../assets/constants/image_strings.dart';
import '../../authentication/controller/registercontroller.dart';
import '../register/register.dart';

class loginscreen extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
    final RegisterController registerController = Get.put(RegisterController());
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(loginlogo),
              width: mediaQuery.size.width,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.08,
                ),
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(height: mediaQuery.size.height * 0.05),
                      TextFormField(
                        controller: registerController.email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        controller:registerController.password,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Align(alignment: Alignment.centerRight,child:TextButton(onPressed: (){},child: const Text("forgot password ?"),)),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(color2),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 50),
                          ),
                        ),
                       onPressed: () async {
  String email = registerController.email.text.trim();
  String password = registerController.password.text.trim();


    // Sign in the user with email and password
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get the currently logged-in user
    User? user = userCredential.user;

    if (user != null) {
      // Retrieve the user document from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid) // Assuming the user ID is stored in the 'uid' property
          .get();
          

      if (userSnapshot.exists) {
        // Access the user data
        var userType;
var data = userSnapshot.data() as Map<String, dynamic>?; // Cast data to Map<String, dynamic>?
if (data != null) {
   userType = data['usertype'];
}

        if (userType == 'Service Provider') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
          );
        }  if (userType == 'Consumer') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConsumerAccount()),
          );
        }else {
          // Handle other user types
          // You can show an error message or redirect to a different screen if needed
        }
      } else {
        // The user document doesn't exist
        // Handle the case where the user document is missing
      }
    
  } 
    // An error occurred while signing in
    // You can show an error message here
  
},


                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),SizedBox( height: mediaQuery.size.height*.02,), Align(alignment: Alignment.center,child:TextButton( onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => register()),
    );},child: const Text("Create an Account"),)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



}
