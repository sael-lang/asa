import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../assets/constants/colors.dart';
import '../../assets/constants/image_strings.dart';
import '../../authentication/controller/accountcontroller.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}
 final AccountController registerController = Get.put(AccountController());
  
  void initState() {

  
   
  }

void getwork() async{
   final AccountController registerController = Get.put(AccountController());
 QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection('services')
    .where('status', isEqualTo: 'Created')
    .get();

if (!snapshot.docs.isEmpty) {
  for (var doc in snapshot.docs) {
    var data = doc.data();
    var snapshotId = doc.id; // Retrieve the snapshot ID (document ID)
    print(snapshotId);
      var dataWithSnapshotId = {
      'snapshotId': snapshotId,
      ...data, // Spread the existing data into the new map
    };
     registerController.addToDataList(dataWithSnapshotId);
  }
}
}
void getdone() async{
   final AccountController registerController = Get.put(AccountController());
 QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection('services')
    .where('status', isEqualTo: 'Done')
    .get();

if (!snapshot.docs.isEmpty) {
  for (var doc in snapshot.docs) {
    var data = doc.data();
    var snapshotId = doc.id; // Retrieve the snapshot ID (document ID)
    print(snapshotId);
      var dataWithSnapshotId = {
      'snapshotId': snapshotId,
      ...data, // Spread the existing data into the new map
    };
     registerController.addTodonelist(dataWithSnapshotId);
  }
}
}
class _ServiceScreenState extends State<ServiceScreen> {
  final List<Map<String, dynamic>> _services = [    {      'title': 'Cleaning',      'status': 'Accept',      'color': Colors.green,    },    {      'title': 'Plumbing',      'status': 'Accept',      'color': Colors.green,    },    {      'title': 'Carpet work',      'status': 'Accept',      'color': Colors.red,    },  ];
 final List<Map<String, dynamic>> _service = [    {      'title': 'Cleaning',      'status': 'Done',      'color': Colors.green,    },    {      'title': 'Plumbing',      'status': 'Done',      'color': Colors.green,    },    {      'title': 'Carpet work',      'status': 'Working',      'color': Colors.red,    },  ];
  @override
Widget build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
   final AccountController registerController = Get.put(AccountController());
   getwork();
   getdone();
   registerController.onClose();
 
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
                    child: Obx(
  () => ListView.builder(
    itemCount: registerController.dataList.length,
    itemBuilder: (context, index) {
      var itemData = registerController.dataList[index];
      return GestureDetector(
        onTap: () {
          // Handle tap event here
          // You can open a dialog, a new page, or any other widget to show the data
          // For example, you can open a dialog with the data details
       showDialog(
  context: context,
  builder: (context) => AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    title: Text(
      "Data Details",
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
          "Created By: ${itemData['createdby']}",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          "Service Name: ${itemData['servicename']}",
          style: TextStyle(fontSize: 16),
        ), SizedBox(height: 10),
        Text(
          "Date: ${itemData['date']}",
          style: TextStyle(fontSize: 16),
        ), SizedBox(height: 10),
        Text(
          "Time: ${itemData['time']}",
          style: TextStyle(fontSize: 16),
        ), SizedBox(height: 10),
        Text(
          "Location: ${itemData['location']}",
          style: TextStyle(fontSize: 16),
        ),
         SizedBox(height: 10),
        Text(
          "Phone : ${itemData['phone']}",
          style: TextStyle(fontSize: 16),
        ),  
         SizedBox(height: 10),
        Text(
          "Price : ${itemData['price']}",
          style: TextStyle(fontSize: 16),
        ), 
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
        child: Text(
          "Close",
          style: TextStyle(fontSize: 16, color: Colors.red,),
        ),
      ),
      TextButton(
        onPressed: () {; // Replace with your document ID
        print(itemData['uid']);
DocumentReference documentReference =
    FirebaseFirestore.instance.collection('services').doc(itemData['snapshotId']);
Map<String, dynamic> newData = {
  'acceptedby':  registerController.username.text,
  'status':'working',
};
documentReference.update(newData)
    .then((value) => print("Document updated successfully."))
    .catchError((error) => print("Failed to update document: $error"));  Navigator.of(context).pop(); 
        },
        
        child: Text(
          "Accept",
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
        child: ListTile(
          title: Text(itemData['servicename']),
          subtitle: Text(itemData['price']),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Show",
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
                ), SizedBox(height: mediaQuery.size.height*.06),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mediaQuery.size.width * 0.08,
                    ),
                    child: Obx(
  () => ListView.builder(
    itemCount: registerController.donelist.length,
    itemBuilder: (context, index) {
      var itemData = registerController.donelist[index];
      return GestureDetector(
        onTap: () {
          // Handle tap event here
          // You can open a dialog, a new page, or any other widget to show the data
          // For example, you can open a dialog with the data details
       showDialog(
  context: context,
  builder: (context) => AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
    title: Text(
      "Data Details",
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
          "Created By: ${itemData['createdby']}",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          "Service Name: ${itemData['servicename']}",
          style: TextStyle(fontSize: 16),
        ), SizedBox(height: 10),
        Text(
          "Date: ${itemData['date']}",
          style: TextStyle(fontSize: 16),
        ), SizedBox(height: 10),
        Text(
          "Time: ${itemData['time']}",
          style: TextStyle(fontSize: 16),
        ), SizedBox(height: 10),
        Text(
          "Location: ${itemData['location']}",
          style: TextStyle(fontSize: 16),
        ),
         SizedBox(height: 10),
        Text(
          "Phone : ${itemData['phone']}",
          style: TextStyle(fontSize: 16),
        ),  
         SizedBox(height: 10),
        Text(
          "Price : ${itemData['price']}",
          style: TextStyle(fontSize: 16),
        ), 
      ],
    ),
    
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);


        },
        child: ListTile(
          title: Text(itemData['servicename']),
          subtitle: Text(itemData['price']),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Done",
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
          ],
        ),
      ),
    ),
  );
}



}
