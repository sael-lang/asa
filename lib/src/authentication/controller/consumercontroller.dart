import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConsumerController extends GetxController {
  static ConsumerController get instance => Get.find();
 TextEditingController servicename= TextEditingController();
 TextEditingController servicedescription= TextEditingController();
 TextEditingController createdby= TextEditingController();
  TextEditingController location= TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController status= TextEditingController();
   TextEditingController time= TextEditingController();
    TextEditingController date= TextEditingController();
    TextEditingController username= TextEditingController();
     TextEditingController uid= TextEditingController();
}
