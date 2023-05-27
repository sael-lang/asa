
import 'package:ASA/src/authentication/controller/accountcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../assets/constants/colors.dart';
import '../../assets/constants/image_strings.dart';

class homescreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homescreen> {
  User? currentUser;

  @override
  void initState() {
     final AccountController registerController = Get.put(AccountController());
    super.initState();
     
      getCurrentUser();
      getwork();
  
  }
int _hasFunctionsRun = 0;
void getwork() async{
  
   final AccountController registerController = Get.put(AccountController());
 registerController.onClose();
 QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection('services')
     .where('acceptedby', isEqualTo:  registerController.username.text)
    .where('status', isEqualTo: 'working')
    .get();

if (!snapshot.docs.isEmpty) {
  for (var doc in snapshot.docs) {
    var data = doc.data();
     var snapshotId = doc.id;
     var dataWithSnapshotId = {
      'snapshotId': snapshotId,
      ...data, // Spread the existing data into the new map
    };
     registerController.addToDataLists(dataWithSnapshotId);
     print(registerController.dataLists);
  }
}
}
  void getCurrentUser() async {
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
    registerController.servicename.text = data['serviceName'];
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
    
       if (_hasFunctionsRun < 2) {
      getCurrentUser();
      getwork();
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
color: Colors.white,child:Obx(
  () {
    if (registerController.dataLists.isEmpty) {
      return Text(
        'Available',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.green,
        ),
      );
    } else {
      return Text(
        'Working',
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
                child: Obx(
  () => ListView.builder(
    itemCount: registerController.dataLists.length,
    itemBuilder: (context, index) {
      var itemData = registerController.dataLists[index];
      return ListTile(
        title: Text(itemData['servicename']),
        subtitle: Text(itemData['time']),
        trailing: GestureDetector(
          onTap: () {
            showDialog(
  context: context,
  builder: (context) => AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    title: Text(
      "Info",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
      "Is the Job complete?",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
        child: Text(
          "No",
          style: TextStyle(fontSize: 16, color: Colors.red,),
        ),
      ),
      TextButton(
        onPressed: () {; // Replace with your document ID
        print(itemData['uid']);
DocumentReference documentReference =
    FirebaseFirestore.instance.collection('services').doc(itemData['snapshotId']);
Map<String, dynamic> newData = {
  'status':'Done',
};
documentReference.update(newData)
    .then((value) => print("Document updated successfully."))
    .catchError((error) => print("Failed to update document: $error"));  Navigator.of(context).pop(); 
        },
        
        child: Text(
          "Yes",
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
          },
          child: Container(
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
        ),
      );
    },
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
