
import 'package:ASA/src/authentication/controller/accountcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/constants/colors.dart';
import '../../../assets/constants/image_strings.dart';


class Chomescreen extends StatefulWidget {
  @override
  _ChomescreenState createState() => _ChomescreenState();
}

class _ChomescreenState extends State<Chomescreen> {
  User? currentUser;
 final AccountController registerController = Get.put(AccountController());
  @override
  
  void initState()  {

    super.initState();
   getConsumerUser();
      getConsumerwork();
  }int _hasFunctionsRun = 0;
void getConsumerwork() async{
   final AccountController registerController = Get.put(AccountController());
     
 QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection('services')
    .where('createdby', isEqualTo: registerController.username.text)
    .where('status', isEqualTo: 'working')
    .get();
 registerController.onClose(); 
if (!snapshot.docs.isEmpty) {
  for (var doc in snapshot.docs) {
    var data = doc.data();
     registerController.addTowrokinglist(data);
     print(registerController.wrokinglist);
  }
}setState(() {
    
  });
}
 void getConsumerUser() async {
    User? user = await FirebaseAuth.instance.currentUser;
     final AccountController registerController = Get.put(AccountController());
    if (user != null) {
      // User is signed in
      String uid = user.uid;
     DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid) // Assuming the user ID is stored in the 'uid' property
          .get();
          

      if (userSnapshot.exists) {
        // Access the user data
    
var data = userSnapshot.data() as Map<String, dynamic>?; // Cast data to Map<String, dynamic>?
if (data != null) {
   registerController.username.text = data['username'];
    registerController.servicename.text = data['usertype'];
     registerController.uid.text = uid;
}
    } else {
      // User is not signed in
      print('No user signed in');
    }
  }setState(() {
    
  });}

  @override
  Widget build(BuildContext context) {
      final AccountController registerController = Get.put(AccountController());
              if (_hasFunctionsRun < 3) {
     getConsumerUser();
      getConsumerwork();
      _hasFunctionsRun++;
    }
      
  
    final mediaQuery = MediaQuery.of(context);
    
return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage(accountbackground),
                  width: mediaQuery.size.width,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            registerController.username.text ,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                           registerController.servicename.text,
                            style: TextStyle(
                              fontSize: 20,
                              color:color2,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(width: mediaQuery.size.width*.4,
                          height: mediaQuery.size.height*.04,
color: Colors.white,child: Obx(
  () {
    if (registerController.wrokinglist.isEmpty) {
      return Text(
        'No Work ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.green,
        ),
      );
    } else {
      return Text(
        'Working ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.red,
        ),
      );
    }
  },
),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.08,
                ),
                child:   Obx(
                    () => ListView.builder(
                      itemCount: registerController.wrokinglist.length,
                      itemBuilder: (context, index) {
                        var itemData = registerController.wrokinglist[index];
                        return ListTile(
                          title: Text(itemData['servicename']),
                          subtitle: Text(itemData['time']),
                         trailing: Container(
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(5),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(
     itemData['status'],
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
                        );
                      },
                    ),
              ),
            ),),
          ],
        ),
      ),
    ),
  );
}
}
