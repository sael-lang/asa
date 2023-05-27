import 'package:ASA/src/Repository/UserRepository/userrepository.dart';
import 'package:ASA/src/authentication/controller/registercontroller.dart';
import 'package:ASA/src/screens/loginscreen/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../assets/constants/colors.dart';
import '../../assets/constants/image_strings.dart';

class register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<register> {
  final RegisterController registerController = Get.put(RegisterController());
  bool showAdditionalField = false;
  String? selectedUserType;
 String serviceName = '';
  String userType = '';
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
              Positioned(
                child: Image(
                  image: AssetImage(loginlogo),
                  width: mediaQuery.size.width,
                ),
              ),
              Positioned(
                bottom: (mediaQuery.size.width * 0.20),
                left: mediaQuery.size.width * 0.08,
                right: mediaQuery.size.width * 0.08,
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(height: mediaQuery.size.height * 0.05),
                      TextFormField(
                        controller: registerController.username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.address,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                        DropdownButtonFormField<String>(
      value: selectedUserType,
      items: [
        DropdownMenuItem(
          value: 'Consumer',
          child: Text('Consumer'),
          
        ),
        DropdownMenuItem(
          value: 'Service Provider',
          child: Text('Service Provider'),
          
        ),
      ],
      onChanged: (String? value) {
        setState(() {
          selectedUserType = value;
          registerController.userTypeController.text = value ?? '';
        });
      },
      decoration: InputDecoration(
        labelText: 'Select User Type',
        contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          border: OutlineInputBorder(),
      ),
    ), SizedBox(height: 10),if (selectedUserType == 'Service Provider')
          TextFormField(
             controller: registerController.serviceName,
            decoration: InputDecoration(
              labelText: 'Service Name',
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                border: OutlineInputBorder(),
            ),
          ),   SizedBox(height: 10),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(color2),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 50),
                          ),
                        ),
                        onPressed: () async {
                          String usernames = RegisterController.instance.username.text.trim();
                          String emails = RegisterController.instance.email.text.trim();
                          String passwords = RegisterController.instance.password.text.trim();
                          String phones = RegisterController.instance.phone.text.trim();
                          String addresss = RegisterController.instance.address.text.trim();
                          String usertype = RegisterController.instance.userTypeController.text.trim();
                          String serviceName = RegisterController.instance.serviceName.text.trim();

                          try {
                            // Create the user with email and password
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emails,
                              password: passwords,
                            );

                            // Get the newly created user's UID
                            String userId = userCredential.user!.uid;

                            // Save the data to Firestore
                            FirebaseFirestore.instance.collection('users').doc(userId).set({
                              'username': usernames,
                              'email': emails,
                              'password': passwords,
                              'phone': phones,
                              'address': addresss,
                              'usertype': usertype,
                              'serviceName': serviceName, // Include service name if it's a service provider
                            }).then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => loginscreen()),
                              );
                            }).catchError((error) {
                              // An error occurred while saving data
                              // You can show an error message here
                            });
                          } catch (e) {
                            // An error occurred while creating the user
                            // You can show an error message here
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
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
