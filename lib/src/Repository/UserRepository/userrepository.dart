import 'package:ASA/src/authentication/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class UserRepository extends GetxController{
  static UserRepository get instance=> Get.find();
  final _db=FirebaseFirestore.instance;
  createuser(Usermodel user){
    _db.collection("User").add(user.toJson()).whenComplete(() => Get.snackbar("title", "message"));
  }
}