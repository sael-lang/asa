import 'package:ASA/src/authentication/controller/registercontroller.dart';
import 'package:ASA/src/screens/ConsumerAccountScreen/SubScreen/ConsumerServices.dart';
import 'package:ASA/src/screens/loginscreen/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/constants/colors.dart';
import '../../../assets/constants/image_strings.dart';
import '../../../authentication/controller/accountcontroller.dart';
import '../../../authentication/controller/formcontroller.dart';


class ConsumerForm extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
   final int data;

  ConsumerForm({required this.data});
  
}

class _RegisterState extends State<ConsumerForm> {
  final FormController registerController = Get.put(FormController());
   final AccountController reg = Get.put(AccountController());
  bool showAdditionalField = false;
  String? selectedUserType;
 String serviceName = '';
  String userType = '';
  String _getLabelText(int value) {
  switch (value) {
    case 1:
      return 'Plumbing';
    case 2:
      return 'Paint';
    case 3:
      return 'Metal Work';
    case 4:
      return 'Electrical Work';
    case 5:
      return 'Wood Work';
    case 6:
      return 'Dish Cleaning';
    case 7:
      return 'AC Fix';
    case 8:
      return 'Grass Cutting';
    case 9:
      return 'Carpet Clean';
    default:
      return 'Unknown';
  }
}


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
registerController.servicename.text=_getLabelText(widget.data);
registerController.status.text="Created";
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: Stack(
            children: [
              Positioned(
                child: Image(
                  image: AssetImage(accountbackground),
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
  controller: registerController.servicename,
  decoration: InputDecoration(
    labelText: "Service Name",
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: color2),
    ),
  ),
),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.servicedescription,
                        decoration: InputDecoration(
                          labelText: 'Service Description',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.location,
                        decoration: InputDecoration(
                          labelText: 'Location',
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
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.time,
                        decoration: InputDecoration(
                          labelText: 'Time',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
          TextFormField(
             controller: registerController.date,
            decoration: InputDecoration(
              labelText: 'Date',
                border: OutlineInputBorder(),
            ),
          ),   SizedBox(height: 10),
                      TextFormField(
                        controller: registerController.price,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: color2),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
                          String servicename = FormController.instance.servicename.text.trim();
                          String servicedescription = FormController.instance.servicedescription.text.trim();
                          String location = FormController.instance.location.text.trim();
                          String phone = FormController.instance.phone.text.trim();
                          String date = FormController.instance.date.text.trim();
                          String time = FormController.instance.time.text.trim();
                          String status = FormController.instance.status.text.trim();
                          try {
                            

                            // Save the data to Firestore
                            FirebaseFirestore.instance.collection('services').add({
                              'servicename': servicename,
                              'servicedescription': servicedescription,
                              'location': location,
                              'phone': phone,
                              'date': date,
                              'time': time,
                               'status': status,
                                 'createdby':  reg.username.text,
                                 'price':  registerController.price.text,
                            }).then((value) {
                              Navigator.pop(context);
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
                          'Create Service',
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
