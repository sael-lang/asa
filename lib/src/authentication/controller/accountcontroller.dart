import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();
 TextEditingController servicename= TextEditingController();
 TextEditingController username= TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController address= TextEditingController();
  TextEditingController uid= TextEditingController();

RxList<Map<String, dynamic>> donelist = <Map<String, dynamic>>[].obs;

  void addTodonelist(Map<String, dynamic> newData) {
    donelist.add(newData);
  }

  RxList<Map<String, dynamic>> wrokinglist = <Map<String, dynamic>>[].obs;

  void addTowrokinglist(Map<String, dynamic> newData) {
    wrokinglist.add(newData);
  }
   RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;

  void addToDataList(Map<String, dynamic> newData) {
    dataList.add(newData);
  }
  RxList<Map<String, dynamic>> dataLists = <Map<String, dynamic>>[].obs;

  void addToDataLists(Map<String, dynamic> newData) {
    dataLists.add(newData);
  }
   @override
  void onClose() {
    // Dispose the text editing controllers when the controller is closed
   
    dataList.clear();
    dataLists.clear();
     donelist.clear();
     wrokinglist.clear();
    super.onClose();
  }
}
