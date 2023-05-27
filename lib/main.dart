


import 'package:ASA/firebase_options.dart';
import 'package:ASA/src/screens/ConsumerAccountScreen/ConsumerAccount.dart';
import 'package:ASA/src/screens/accountscreen/accountscreen.dart';
import 'package:ASA/src/screens/mainscreen/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
            future: getUserData(snapshot.data),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String value = snapshot.data!['usertype'];
                print(value);
                
                if (value == "Service Provider") {
                  return AccountScreen();
                }  if (value == "Consumer") {
                  return ConsumerAccount();
                }else {
                  return Mainscreen();
                }
              } else if (snapshot.hasError) {
                // Handle error case
                return Text("Error: ${snapshot.error}");
              }
              
              // Show a loading indicator while waiting for data
              return CircularProgressIndicator();
            },
          );
        } else {
          // User is not authenticated, handle the appropriate UI
          return Mainscreen();
        }
      },
    ),
  );
}

Future<DocumentSnapshot> getUserData(User? user) async {
  if (user != null) {
    return await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();
  }

  // Throw an exception as a fallback option
  throw Exception("User data not available");
}

  
}


