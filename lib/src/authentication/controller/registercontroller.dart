import 'package:ASA/src/authentication/Auth/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

 TextEditingController username= TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController address= TextEditingController();
    TextEditingController serviceName= TextEditingController();
  
final TextEditingController userTypeController = TextEditingController(text: 'Consumer');

  void registerUser(String email, String password, String username) {
     Get.put(AuthenticationRepository()).createuserwithEmailAndPasword(email, password);
  }
  void loginUser(String email, String password){
     Get.put(AuthenticationRepository()).loginwithEmailAndPasword(email, password);
  }
  void signout()
  {
   Get.put(AuthenticationRepository()).signout(); 
  }
}
