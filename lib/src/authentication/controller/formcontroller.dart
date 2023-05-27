import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  static FormController get instance => Get.find();
 TextEditingController servicename= TextEditingController();
 TextEditingController servicedescription= TextEditingController();
 TextEditingController createdby= TextEditingController();
  TextEditingController location= TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController status= TextEditingController();
   TextEditingController time= TextEditingController();
    TextEditingController date= TextEditingController();
    TextEditingController uid= TextEditingController();
     TextEditingController price= TextEditingController();
}
